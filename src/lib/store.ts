'use client';

import { useSyncExternalStore } from 'react';
import {
  Category,
  Medicine,
  ShopSettings,
  Order,
  PrescriptionRequest,
  CustomerEnquiry,
  InventoryBatch,
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
import { createClient, isSupabaseConfigured } from '@/lib/supabase/client';

const STORAGE_KEYS = {
  CATEGORIES: 'dmh_categories',
  MEDICINES: 'dmh_medicines',
  ORDERS: 'dmh_orders',
  PRESCRIPTIONS: 'dmh_prescriptions',
  ENQUIRIES: 'dmh_enquiries',
  INVENTORY: 'dmh_inventory',
  SETTINGS: 'dmh_settings',
  ADMIN_AUTH: 'dmh_admin_auth',
};

// Cache references to avoid new object identity on every get if unchanged
const cachedMedicines: { raw: string | null; val: Medicine[] } = { raw: null, val: initialMedicines };
const cachedCategories: { raw: string | null; val: Category[] } = { raw: null, val: initialCategories };
const cachedOrders: { raw: string | null; val: Order[] } = { raw: null, val: initialOrders };
const cachedPrescriptions: { raw: string | null; val: PrescriptionRequest[] } = { raw: null, val: initialPrescriptions };
const cachedEnquiries: { raw: string | null; val: CustomerEnquiry[] } = { raw: null, val: initialEnquiries };
const cachedInventory: { raw: string | null; val: InventoryBatch[] } = { raw: null, val: initialInventory };
const cachedSettings: { raw: string | null; val: ShopSettings } = { raw: null, val: initialShopSettings };

function getFromStorage<T>(key: string, fallback: T, cacheRef: { raw: string | null; val: T }): T {
  if (typeof window === 'undefined') return fallback;
  try {
    const raw = localStorage.getItem(key);
    if (raw === cacheRef.raw && cacheRef.raw !== null) {
      return cacheRef.val;
    }
    if (raw) {
      const parsed = JSON.parse(raw);
      cacheRef.raw = raw;
      cacheRef.val = parsed;
      return parsed;
    }
    return fallback;
  } catch {
    return fallback;
  }
}

function saveToStorage<T>(key: string, data: T): void {
  if (typeof window === 'undefined') return;
  try {
    localStorage.setItem(key, JSON.stringify(data));
    window.dispatchEvent(new Event('dmh_storage_updated'));
  } catch (err) {
    console.error('Storage error:', err);
  }
}

function subscribe(callback: () => void) {
  if (typeof window === 'undefined') return () => {};
  window.addEventListener('storage', callback);
  window.addEventListener('dmh_storage_updated', callback);
  return () => {
    window.removeEventListener('storage', callback);
    window.removeEventListener('dmh_storage_updated', callback);
  };
}

// Medicines
export const getMedicines = (): Medicine[] => {
  return getFromStorage<Medicine[]>(STORAGE_KEYS.MEDICINES, initialMedicines, cachedMedicines);
};

export function useMedicines(): Medicine[] {
  return useSyncExternalStore(subscribe, getMedicines, () => initialMedicines);
}

export const saveMedicine = (med: Medicine): void => {
  const list = [...getMedicines()];
  const existingIdx = list.findIndex((m) => m.id === med.id);
  if (existingIdx >= 0) {
    list[existingIdx] = med;
  } else {
    list.unshift(med);
  }
  saveToStorage(STORAGE_KEYS.MEDICINES, list);
};

export const deleteMedicine = (id: string): void => {
  const list = getMedicines().filter((m) => m.id !== id);
  saveToStorage(STORAGE_KEYS.MEDICINES, list);
};

// Categories
export const getCategories = (): Category[] => {
  return getFromStorage<Category[]>(STORAGE_KEYS.CATEGORIES, initialCategories, cachedCategories);
};

export function useCategories(): Category[] {
  return useSyncExternalStore(subscribe, getCategories, () => initialCategories);
}

export const saveCategory = (cat: Category): void => {
  const list = [...getCategories()];
  const existingIdx = list.findIndex((c) => c.id === cat.id);
  if (existingIdx >= 0) {
    list[existingIdx] = cat;
  } else {
    list.push(cat);
  }
  saveToStorage(STORAGE_KEYS.CATEGORIES, list);
};

export const deleteCategory = (id: string): void => {
  const list = getCategories().filter((c) => c.id !== id);
  saveToStorage(STORAGE_KEYS.CATEGORIES, list);
};

// Orders
export const getOrders = (): Order[] => {
  return getFromStorage<Order[]>(STORAGE_KEYS.ORDERS, initialOrders, cachedOrders);
};

export function useOrders(): Order[] {
  return useSyncExternalStore(subscribe, getOrders, () => initialOrders);
}

export const createOrder = (order: Omit<Order, 'id' | 'orderNumber' | 'createdAt' | 'status'>): Order => {
  const list = [...getOrders()];
  const newOrder: Order = {
    ...order,
    id: 'ord-' + Date.now(),
    orderNumber: `DMH-2026-${String(list.length + 1).padStart(3, '0')}`,
    createdAt: new Date().toISOString(),
    status: 'Pending',
  };
  list.unshift(newOrder);
  saveToStorage(STORAGE_KEYS.ORDERS, list);
  return newOrder;
};

export const updateOrderStatus = (id: string, status: OrderStatus, internalNotes?: string): void => {
  const list = [...getOrders()];
  const target = list.find((o) => o.id === id);
  if (target) {
    target.status = status;
    if (internalNotes !== undefined) target.internalNotes = internalNotes;
    saveToStorage(STORAGE_KEYS.ORDERS, list);
  }
};

// Prescriptions
export const getPrescriptions = (): PrescriptionRequest[] => {
  return getFromStorage<PrescriptionRequest[]>(STORAGE_KEYS.PRESCRIPTIONS, initialPrescriptions, cachedPrescriptions);
};

export function usePrescriptions(): PrescriptionRequest[] {
  return useSyncExternalStore(subscribe, getPrescriptions, () => initialPrescriptions);
}

export const createPrescriptionRequest = (
  req: Omit<PrescriptionRequest, 'id' | 'requestId' | 'createdAt' | 'status'>
): PrescriptionRequest => {
  const list = [...getPrescriptions()];
  const newReq: PrescriptionRequest = {
    ...req,
    id: 'rx-' + Date.now(),
    requestId: `RX-2026-${String(list.length + 1).padStart(3, '0')}`,
    createdAt: new Date().toISOString(),
    status: 'Pending Review',
  };
  list.unshift(newReq);
  saveToStorage(STORAGE_KEYS.PRESCRIPTIONS, list);
  return newReq;
};

export const updatePrescriptionStatus = (
  id: string,
  status: PrescriptionStatus,
  internalNotes?: string
): void => {
  const list = [...getPrescriptions()];
  const target = list.find((p) => p.id === id);
  if (target) {
    target.status = status;
    if (internalNotes !== undefined) target.internalNotes = internalNotes;
    saveToStorage(STORAGE_KEYS.PRESCRIPTIONS, list);
  }
};

// Enquiries
export const getEnquiries = (): CustomerEnquiry[] => {
  return getFromStorage<CustomerEnquiry[]>(STORAGE_KEYS.ENQUIRIES, initialEnquiries, cachedEnquiries);
};

export function useEnquiries(): CustomerEnquiry[] {
  return useSyncExternalStore(subscribe, getEnquiries, () => initialEnquiries);
}

export const createEnquiry = (enquiry: Omit<CustomerEnquiry, 'id' | 'createdAt' | 'status'>): CustomerEnquiry => {
  const list = [...getEnquiries()];
  const newEnq: CustomerEnquiry = {
    ...enquiry,
    id: 'enq-' + Date.now(),
    createdAt: new Date().toISOString(),
    status: 'New',
  };
  list.unshift(newEnq);
  saveToStorage(STORAGE_KEYS.ENQUIRIES, list);
  return newEnq;
};

export const updateEnquiryStatus = (id: string, status: EnquiryStatus, adminResponse?: string): void => {
  const list = [...getEnquiries()];
  const target = list.find((e) => e.id === id);
  if (target) {
    target.status = status;
    if (adminResponse !== undefined) target.adminResponse = adminResponse;
    saveToStorage(STORAGE_KEYS.ENQUIRIES, list);
  }
};

// Inventory
export const getInventory = (): InventoryBatch[] => {
  return getFromStorage<InventoryBatch[]>(STORAGE_KEYS.INVENTORY, initialInventory, cachedInventory);
};

export function useInventory(): InventoryBatch[] {
  return useSyncExternalStore(subscribe, getInventory, () => initialInventory);
}

export const saveInventoryBatch = (batch: InventoryBatch): void => {
  const list = [...getInventory()];
  const idx = list.findIndex((b) => b.id === batch.id);
  if (idx >= 0) {
    list[idx] = batch;
  } else {
    list.unshift(batch);
  }
  saveToStorage(STORAGE_KEYS.INVENTORY, list);
};

// Settings
export const getSettings = (): ShopSettings => {
  return getFromStorage<ShopSettings>(STORAGE_KEYS.SETTINGS, initialShopSettings, cachedSettings);
};

export function useShopSettings(): ShopSettings {
  return useSyncExternalStore(subscribe, getSettings, () => initialShopSettings);
}

export const saveSettings = (settings: ShopSettings): void => {
  saveToStorage(STORAGE_KEYS.SETTINGS, settings);
};

// Admin Session
export const isAdminAuthenticated = (): boolean => {
  if (typeof window === 'undefined') return false;
  return localStorage.getItem(STORAGE_KEYS.ADMIN_AUTH) === 'true';
};

export function useIsAdminAuthenticated(): boolean {
  return useSyncExternalStore(subscribe, isAdminAuthenticated, () => false);
}

export const setAdminAuthenticated = (val: boolean): void => {
  if (typeof window === 'undefined') return;
  if (val) {
    localStorage.setItem(STORAGE_KEYS.ADMIN_AUTH, 'true');
  } else {
    localStorage.removeItem(STORAGE_KEYS.ADMIN_AUTH);
  }
  window.dispatchEvent(new Event('dmh_storage_updated'));
};

// Real-time synchronization from Supabase PostgreSQL
export async function syncFromSupabase(): Promise<void> {
  if (typeof window === 'undefined') return;
  if (!isSupabaseConfigured()) return;

  try {
    const supabase = createClient();

    // 1. Fetch medicines
    let meds: Medicine[] = [];
    const { data: dbMedicines } = await supabase
      .from('medicines')
      .select('*, categories(name)')
      .eq('status', 'active');

    if (dbMedicines && dbMedicines.length > 0) {
      meds = dbMedicines.map((m) => {
        const catObj = m.categories;
        const catName = Array.isArray(catObj)
          ? catObj[0]?.name
          : (catObj as { name?: string } | null)?.name;
        return {
          id: m.id,
          name: m.name,
          slug: m.slug,
          brand: m.brand || '',
          genericName: m.generic_name || '',
          composition: m.composition || '',
          categoryId: m.category_id || '',
          categoryName: catName || 'General Healthcare',
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
      });
      saveToStorage(STORAGE_KEYS.MEDICINES, meds);
    }

    // 2. Fetch categories and map accurate product counts
    const { data: dbCategories } = await supabase
      .from('categories')
      .select('*')
      .eq('status', 'active')
      .order('display_order', { ascending: true });

    if (dbCategories && dbCategories.length > 0) {
      const countsMap: Record<string, number> = {};
      meds.forEach((m) => {
        if (m.categoryId) countsMap[m.categoryId] = (countsMap[m.categoryId] || 0) + 1;
      });

      const cats: Category[] = dbCategories.map((c) => ({
        id: c.id,
        name: c.name,
        slug: c.slug,
        description: c.description || '',
        iconName: c.icon_name || 'Pill',
        productCount: countsMap[c.id] || 0,
        displayOrder: c.display_order || 0,
        status: c.status,
      }));
      saveToStorage(STORAGE_KEYS.CATEGORIES, cats);
    }

    // 3. Fetch settings
    const { data: dbSettings } = await supabase
      .from('site_settings')
      .select('value')
      .eq('key', 'shop_profile')
      .maybeSingle();

    if (dbSettings?.value) {
      saveToStorage(STORAGE_KEYS.SETTINGS, dbSettings.value);
    }
  } catch (err) {
    console.warn('Supabase sync skipped/deferred:', err);
  }
}

if (typeof window !== 'undefined') {
  setTimeout(() => {
    syncFromSupabase();
  }, 100);
}

