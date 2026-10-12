'use server';

import { createClient, isSupabaseConfigured } from '@/lib/supabase/server';
import { createAdminClient, isSupabaseAdminConfigured } from '@/lib/supabase/admin';
import {
  Category,
  Medicine,
  Order,
  PrescriptionRequest,
  CustomerEnquiry,
  InventoryBatch,
  ShopSettings,
  OrderStatus,
  PrescriptionStatus,
  EnquiryStatus,
} from '@/types';
import {
  initialCategories,
  initialMedicines,
  initialOrders,
  initialPrescriptions,
  initialEnquiries,
  initialInventory,
  initialShopSettings,
} from '@/data/mockData';

// 1. AUTHENTICATION (NO HARDCODED PASSWORDS - PURE SUPABASE AUTH)
export async function adminLoginAction(formData: FormData) {
  const email = (formData.get('email') as string)?.trim();
  const password = (formData.get('password') as string);

  if (!email || !password) {
    return { success: false, error: 'Email and password are required.' };
  }

  if (!isSupabaseConfigured()) {
    return {
      success: false,
      error: 'Supabase credentials are not configured. Please add NEXT_PUBLIC_SUPABASE_URL and NEXT_PUBLIC_SUPABASE_ANON_KEY to .env.local and create an admin user in Supabase Auth.',
    };
  }

  try {
    const supabase = await createClient();
    const { data, error } = await supabase.auth.signInWithPassword({
      email,
      password,
    });

    if (error || !data.user) {
      return { success: false, error: error?.message || 'Authentication failed. Please check your admin credentials.' };
    }

    // Check if the user is listed in public.admins
    const { data: adminRecord } = await supabase
      .from('admins')
      .select('id, role, full_name')
      .eq('id', data.user.id)
      .maybeSingle();

    return {
      success: true,
      user: {
        id: data.user.id,
        email: data.user.email,
        role: adminRecord?.role || 'admin',
        name: adminRecord?.full_name || 'Pharmacist Admin',
      },
    };
  } catch (err: unknown) {
    console.error('Admin login error:', err);
    return { success: false, error: 'An unexpected authentication error occurred.' };
  }
}

export async function adminLogoutAction() {
  if (isSupabaseConfigured()) {
    try {
      const supabase = await createClient();
      await supabase.auth.signOut();
    } catch (err) {
      console.error('Admin logout error:', err);
    }
  }
  return { success: true };
}

export async function getAdminSessionAction() {
  if (!isSupabaseConfigured()) {
    return { authenticated: false, isConfigured: false };
  }

  try {
    const supabase = await createClient();
    const { data: { user } } = await supabase.auth.getUser();

    if (!user) {
      return { authenticated: false, isConfigured: true };
    }

    return {
      authenticated: true,
      isConfigured: true,
      user: {
        id: user.id,
        email: user.email,
      },
    };
  } catch {
    return { authenticated: false, isConfigured: true };
  }
}

// 2. FETCH ALL REAL DATA FROM POSTGRESQL / SUPABASE
export async function adminGetDashboardDataAction() {
  if (!isSupabaseConfigured()) {
    return {
      isSupabase: false,
      categories: initialCategories,
      medicines: initialMedicines,
      orders: initialOrders,
      prescriptions: initialPrescriptions,
      enquiries: initialEnquiries,
      inventory: initialInventory,
      settings: initialShopSettings,
    };
  }

  try {
    const supabase = await createClient();
    const adminClient = isSupabaseAdminConfigured() ? createAdminClient() : supabase;

    // A. Categories
    const { data: dbCategories } = await supabase
      .from('categories')
      .select('*')
      .order('display_order', { ascending: true });

    const categories: Category[] = (dbCategories && dbCategories.length > 0)
      ? dbCategories.map((c) => ({
          id: c.id,
          name: c.name,
          slug: c.slug,
          description: c.description || '',
          iconName: c.icon_name || 'Pill',
          productCount: 0,
          displayOrder: c.display_order || 0,
          status: c.status,
        }))
      : initialCategories;

    // B. Medicines
    const { data: dbMedicines } = await supabase
      .from('medicines')
      .select('*, categories(name)')
      .order('created_at', { ascending: false });

    const medicines: Medicine[] = (dbMedicines && dbMedicines.length > 0)
      ? dbMedicines.map((m) => {
          const cat = m.categories as { name: string } | null;
          return {
            id: m.id,
            name: m.name,
            slug: m.slug,
            brand: m.brand || '',
            genericName: m.generic_name || '',
            composition: m.composition || '',
            categoryId: m.category_id || '',
            categoryName: cat?.name || 'General Health',
            manufacturer: m.manufacturer || '',
            packSize: m.pack_size || '',
            mrp: Number(m.mrp) || 0,
            sellingPrice: Number(m.selling_price) || 0,
            stockQuantity: m.stock_quantity || 0,
            batchNumber: m.batch_number || '',
            expiryDate: m.expiry_date || '',
            prescriptionRequired: !!m.prescription_required,
            description: m.description || '',
            dosageGuidelines: m.dosage_guidelines || '',
            storageInstructions: m.storage_instructions || '',
            imageUrl: m.image_url || undefined,
            status: m.status,
            isDemo: !!m.is_demo,
            featured: !!m.is_featured,
          };
        })
      : initialMedicines;

    // C. Orders & Order Items
    const { data: dbOrders } = await supabase
      .from('orders')
      .select('*, order_items(*)')
      .order('created_at', { ascending: false });

    const orders: Order[] = (dbOrders && dbOrders.length > 0)
      ? dbOrders.map((o) => {
          const rawItems = (o.order_items || []) as Array<{
            id: string;
            medicine_id?: string;
            medicine_name: string;
            quantity: number;
            estimated_price?: number;
          }>;
          return {
            id: o.id,
            orderNumber: o.order_number,
            customerName: o.customer_name,
            mobile: o.mobile,
            email: o.email || undefined,
            preference: o.preference,
            address: o.delivery_address,
            additionalMessage: o.additional_message || undefined,
            status: o.status as OrderStatus,
            createdAt: o.created_at,
            internalNotes: o.internal_notes || undefined,
            items: rawItems.map((item) => ({
              medicineId: item.medicine_id || '',
              medicineName: item.medicine_name,
              quantity: item.quantity,
              priceEstimate: item.estimated_price ? Number(item.estimated_price) : undefined,
            })),
          };
        })
      : initialOrders;

    // D. Prescriptions with Signed URLs for Private Storage
    const { data: dbPrescriptions } = await supabase
      .from('prescriptions')
      .select('*')
      .order('created_at', { ascending: false });

    let prescriptions: PrescriptionRequest[] = initialPrescriptions;
    if (dbPrescriptions && dbPrescriptions.length > 0) {
      prescriptions = await Promise.all(
        dbPrescriptions.map(async (rx) => {
          let signedUrl = undefined;
          if (rx.storage_path) {
            try {
              // Generate a 1-hour secure signed URL for the admin only
              const { data: urlData } = await adminClient.storage
                .from('prescriptions')
                .createSignedUrl(rx.storage_path, 3600);
              signedUrl = urlData?.signedUrl;
            } catch (storageErr) {
              console.error('Error generating signed URL for prescription:', storageErr);
            }
          }

          return {
            id: rx.id,
            requestId: rx.request_id,
            customerName: rx.customer_name,
            mobile: rx.mobile,
            email: rx.email || undefined,
            fileName: rx.file_name,
            fileType: rx.file_type || 'image/jpeg',
            fileSize: rx.file_size || 0,
            storagePath: rx.storage_path,
            signedUrl: signedUrl,
            orderDetails: rx.order_details || undefined,
            deliveryAddress: rx.delivery_address,
            additionalMessage: rx.additional_message || undefined,
            status: rx.status as PrescriptionStatus,
            createdAt: rx.created_at,
            internalNotes: rx.internal_notes || undefined,
          };
        })
      );
    }

    // E. Enquiries
    const { data: dbEnquiries } = await supabase
      .from('enquiries')
      .select('*')
      .order('created_at', { ascending: false });

    const enquiries: CustomerEnquiry[] = (dbEnquiries && dbEnquiries.length > 0)
      ? dbEnquiries.map((e) => ({
          id: e.id,
          customerName: e.customer_name,
          mobile: e.mobile,
          email: e.email || undefined,
          medicineInterested: e.medicine_interested || undefined,
          message: e.message,
          createdAt: e.created_at,
          status: e.status as EnquiryStatus,
          adminResponse: e.admin_response || undefined,
        }))
      : initialEnquiries;

    // F. Inventory Batches
    const { data: dbInventory } = await supabase
      .from('inventory_batches')
      .select('*')
      .order('expiry_date', { ascending: true });

    const inventory: InventoryBatch[] = (dbInventory && dbInventory.length > 0)
      ? dbInventory.map((b) => ({
          id: b.id,
          medicineId: b.medicine_id,
          medicineName: b.medicine_name,
          batchNumber: b.batch_number,
          manufacturingDate: b.manufacturing_date || '',
          expiryDate: b.expiry_date,
          stockQuantity: b.stock_quantity,
          mrp: Number(b.mrp),
          purchasePrice: Number(b.purchase_price) || 0,
          sellingPrice: Number(b.selling_price),
          status: b.status as 'In Stock' | 'Low Stock' | 'Expired',
        }))
      : initialInventory;

    // G. Site Settings
    const { data: dbSettings } = await supabase
      .from('site_settings')
      .select('value')
      .eq('key', 'shop_profile')
      .maybeSingle();

    const settings: ShopSettings = dbSettings?.value ? dbSettings.value : initialShopSettings;

    return {
      isSupabase: true,
      categories,
      medicines,
      orders,
      prescriptions,
      enquiries,
      inventory,
      settings,
    };
  } catch (err) {
    console.error('Error fetching admin dashboard data from Supabase:', err);
    return {
      isSupabase: false,
      categories: initialCategories,
      medicines: initialMedicines,
      orders: initialOrders,
      prescriptions: initialPrescriptions,
      enquiries: initialEnquiries,
      inventory: initialInventory,
      settings: initialShopSettings,
    };
  }
}

// 3. PERSISTENCE ACTIONS: STATUS UPDATES & CRUD

export async function adminUpdateOrderStatusAction(orderId: string, status: OrderStatus, internalNotes?: string) {
  if (isSupabaseConfigured()) {
    try {
      const supabase = await createClient();
      const updateData: { status: string; internal_notes?: string } = { status };
      if (internalNotes !== undefined) updateData.internal_notes = internalNotes;

      const { error } = await supabase
        .from('orders')
        .update(updateData)
        .eq('id', orderId);

      if (error) throw error;
      return { success: true };
    } catch (err: unknown) {
      console.error('Error updating order status in Supabase:', err);
      return { success: false, error: 'Database update failed.' };
    }
  }
  return { success: true, localOnly: true };
}

export async function adminUpdatePrescriptionStatusAction(
  rxId: string,
  status: PrescriptionStatus,
  internalNotes?: string
) {
  if (isSupabaseConfigured()) {
    try {
      const supabase = await createClient();
      const updateData: { status: string; internal_notes?: string } = { status };
      if (internalNotes !== undefined) updateData.internal_notes = internalNotes;

      const { error } = await supabase
        .from('prescriptions')
        .update(updateData)
        .eq('id', rxId);

      if (error) throw error;
      return { success: true };
    } catch (err: unknown) {
      console.error('Error updating prescription status in Supabase:', err);
      return { success: false, error: 'Database update failed.' };
    }
  }
  return { success: true, localOnly: true };
}

export async function adminUpdateEnquiryStatusAction(
  enquiryId: string,
  status: EnquiryStatus,
  adminResponse?: string
) {
  if (isSupabaseConfigured()) {
    try {
      const supabase = await createClient();
      const updateData: { status: string; admin_response?: string } = { status };
      if (adminResponse !== undefined) updateData.admin_response = adminResponse;

      const { error } = await supabase
        .from('enquiries')
        .update(updateData)
        .eq('id', enquiryId);

      if (error) throw error;
      return { success: true };
    } catch (err: unknown) {
      console.error('Error updating enquiry in Supabase:', err);
      return { success: false, error: 'Database update failed.' };
    }
  }
  return { success: true, localOnly: true };
}

const UUID_REGEX = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;

export async function adminSaveMedicineAction(medicine: Medicine) {
  if (isSupabaseConfigured()) {
    try {
      const supabase = await createClient();
      const isUuidId = medicine.id && UUID_REGEX.test(medicine.id);

      // Resolve category_id if needed
      let categoryId: string | null = null;
      if (medicine.categoryId && UUID_REGEX.test(medicine.categoryId)) {
        categoryId = medicine.categoryId;
      } else if (medicine.categoryName) {
        const { data: catData } = await supabase
          .from('categories')
          .select('id')
          .ilike('name', medicine.categoryName)
          .maybeSingle();
        if (catData?.id) categoryId = catData.id;
      }

      const dbPayload: Record<string, unknown> = {
        name: medicine.name,
        slug: medicine.slug || medicine.name.toLowerCase().replace(/[^a-z0-9]+/g, '-'),
        brand: medicine.brand,
        generic_name: medicine.genericName,
        composition: medicine.composition,
        manufacturer: medicine.manufacturer,
        pack_size: medicine.packSize,
        mrp: medicine.mrp,
        selling_price: medicine.sellingPrice,
        stock_quantity: medicine.stockQuantity,
        batch_number: medicine.batchNumber,
        expiry_date: medicine.expiryDate || null,
        prescription_required: medicine.prescriptionRequired,
        description: medicine.description,
        dosage_guidelines: medicine.dosageGuidelines,
        storage_instructions: medicine.storageInstructions,
        image_url: medicine.imageUrl || null,
        is_demo: medicine.isDemo,
        is_featured: medicine.featured,
        status: medicine.status,
      };

      if (categoryId) {
        dbPayload.category_id = categoryId;
      }

      if (isUuidId) {
        const { error } = await supabase.from('medicines').update(dbPayload).eq('id', medicine.id);
        if (error) throw error;
        return { success: true, id: medicine.id };
      } else {
        const { data, error } = await supabase
          .from('medicines')
          .upsert(dbPayload, { onConflict: 'slug' })
          .select('id')
          .single();
        if (error) throw error;
        return { success: true, id: data?.id || medicine.id };
      }
    } catch (err: unknown) {
      console.error('Error saving medicine in Supabase:', err);
      return { success: false, error: 'Database save failed.' };
    }
  }
  return { success: true, localOnly: true, id: medicine.id };
}

export async function adminDeleteMedicineAction(id: string) {
  if (isSupabaseConfigured()) {
    try {
      const supabase = await createClient();
      if (UUID_REGEX.test(id)) {
        const { error } = await supabase.from('medicines').delete().eq('id', id);
        if (error) throw error;
      }
      return { success: true };
    } catch (err: unknown) {
      console.error('Error deleting medicine in Supabase:', err);
      return { success: false, error: 'Database deletion failed.' };
    }
  }
  return { success: true, localOnly: true };
}

export async function adminSaveCategoryAction(category: Category) {
  if (isSupabaseConfigured()) {
    try {
      const supabase = await createClient();
      const isUuidId = category.id && UUID_REGEX.test(category.id);

      const payload = {
        name: category.name,
        slug: category.slug,
        description: category.description,
        icon_name: category.iconName,
        display_order: category.displayOrder,
        status: category.status,
      };

      if (isUuidId) {
        const { error } = await supabase.from('categories').update(payload).eq('id', category.id);
        if (error) throw error;
        return { success: true, id: category.id };
      } else {
        const { data, error } = await supabase
          .from('categories')
          .upsert(payload, { onConflict: 'slug' })
          .select('id')
          .single();
        if (error) throw error;
        return { success: true, id: data?.id || category.id };
      }
    } catch (err: unknown) {
      console.error('Error saving category in Supabase:', err);
      return { success: false, error: 'Database save failed.' };
    }
  }
  return { success: true, localOnly: true, id: category.id };
}

export async function adminSaveInventoryAction(batch: InventoryBatch) {
  if (isSupabaseConfigured()) {
    try {
      const supabase = await createClient();
      const isNew = batch.id.startsWith('batch-') || !batch.id;

      const payload = {
        medicine_id: batch.medicineId.startsWith('dmh-') ? null : batch.medicineId,
        medicine_name: batch.medicineName,
        batch_number: batch.batchNumber,
        manufacturing_date: batch.manufacturingDate || null,
        expiry_date: batch.expiryDate,
        stock_quantity: batch.stockQuantity,
        mrp: batch.mrp,
        purchase_price: batch.purchasePrice,
        selling_price: batch.sellingPrice,
        status: batch.status,
      };

      if (isNew) {
        const { data, error } = await supabase.from('inventory_batches').insert(payload).select().single();
        if (error) throw error;
        return { success: true, id: data.id };
      } else {
        const { error } = await supabase.from('inventory_batches').update(payload).eq('id', batch.id);
        if (error) throw error;
        return { success: true, id: batch.id };
      }
    } catch (err: unknown) {
      console.error('Error saving inventory in Supabase:', err);
      return { success: false, error: 'Database save failed.' };
    }
  }
  return { success: true, localOnly: true, id: batch.id };
}

export async function adminSaveSettingsAction(settings: ShopSettings) {
  if (isSupabaseConfigured()) {
    try {
      const supabase = await createClient();
      const { error } = await supabase
        .from('site_settings')
        .upsert({
          key: 'shop_profile',
          value: settings,
        }, { onConflict: 'key' });

      if (error) throw error;
      return { success: true };
    } catch (err: unknown) {
      console.error('Error saving settings in Supabase:', err);
      return { success: false, error: 'Database save failed.' };
    }
  }
  return { success: true, localOnly: true };
}
