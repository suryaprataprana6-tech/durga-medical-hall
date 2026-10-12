'use server';

import { createClient, isSupabaseConfigured } from '@/lib/supabase/server';
import { Category, Medicine } from '@/types';
import { initialCategories, initialMedicines } from '@/data/mockData';

export async function getCategoriesAction(): Promise<Category[]> {
  if (isSupabaseConfigured()) {
    try {
      const supabase = await createClient();
      const { data, error } = await supabase
        .from('categories')
        .select('*, medicines(count)')
        .eq('status', 'active')
        .order('display_order', { ascending: true });

      if (error) {
        console.error('Supabase getCategories error:', error);
        return initialCategories;
      }

      if (data && data.length > 0) {
        return data.map((c) => {
          const countArr = c.medicines as { count: number }[] | null;
          const count = Array.isArray(countArr) && countArr.length > 0 ? countArr[0]?.count || 0 : 0;
          return {
            id: c.id,
            name: c.name,
            slug: c.slug,
            description: c.description || '',
            iconName: c.icon_name || 'Pill',
            productCount: count,
            displayOrder: c.display_order || 0,
            status: c.status as 'active' | 'inactive',
          };
        });
      }
    } catch (err) {
      console.error('Error fetching categories from Supabase:', err);
    }
  }

  return initialCategories;
}

export async function getMedicinesAction(): Promise<Medicine[]> {
  if (isSupabaseConfigured()) {
    try {
      const supabase = await createClient();
      const { data, error } = await supabase
        .from('medicines')
        .select('*, categories(name)')
        .eq('status', 'active');

      if (error) {
        console.error('Supabase getMedicines error:', error);
        return initialMedicines;
      }

      if (data && data.length > 0) {
        return data.map((m) => {
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
            status: m.status as 'active' | 'inactive',
            isDemo: !!m.is_demo,
            featured: !!m.is_featured,
          };
        });
      }
    } catch (err) {
      console.error('Error fetching medicines from Supabase:', err);
    }
  }

  return initialMedicines;
}
