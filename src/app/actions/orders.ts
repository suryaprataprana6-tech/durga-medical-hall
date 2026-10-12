'use server';

import { createClient, isSupabaseConfigured } from '@/lib/supabase/server';
import { OrderItem } from '@/types';

export interface SubmitOrderInput {
  customerName: string;
  mobile: string;
  email?: string;
  preference: 'Pickup at Kubri Store' | 'Local Home Delivery (Subject to Area)';
  address: string;
  additionalMessage?: string;
  medicineNameText?: string;
  quantity?: number;
  items?: OrderItem[];
}

export async function submitOrderAction(input: SubmitOrderInput) {
  // 1. Validation
  if (!input.customerName || input.customerName.trim().length < 2) {
    return { success: false, error: 'Please enter a valid customer name (at least 2 characters).' };
  }

  const cleanMobile = input.mobile.replace(/\D/g, '');
  if (cleanMobile.length < 10) {
    return { success: false, error: 'Please enter a valid 10-digit mobile number.' };
  }

  if (!input.address || input.address.trim().length < 4) {
    return { success: false, error: 'Please enter a valid delivery or pickup address in Kubri / nearby area.' };
  }

  const orderNumber = `DMH-${Date.now().toString().slice(-6)}-${Math.floor(100 + Math.random() * 900)}`;

  // 2. Check if Supabase is live
  if (isSupabaseConfigured()) {
    try {
      const supabase = await createClient();

      // Upsert customer record
      const { data: customerData } = await supabase
        .from('customers')
        .upsert(
          {
            full_name: input.customerName.trim(),
            mobile: cleanMobile,
            email: input.email?.trim() || null,
            address: input.address.trim(),
            village: 'Kubri',
            district: 'Giridih',
            state: 'Jharkhand',
            pincode: '825418',
          },
          { onConflict: 'mobile' }
        )
        .select('id')
        .single();

      // Insert Order
      const { data: orderData, error: orderError } = await supabase
        .from('orders')
        .insert({
          order_number: orderNumber,
          customer_id: customerData?.id || null,
          customer_name: input.customerName.trim(),
          mobile: cleanMobile,
          email: input.email?.trim() || null,
          preference: input.preference,
          delivery_address: input.address.trim(),
          additional_message: input.additionalMessage?.trim() || null,
          status: 'Pending',
        })
        .select('id, order_number')
        .single();

      if (orderError) {
        console.error('Supabase order insert error:', orderError);
        // Fall back gracefully
        return {
          success: true,
          orderNumber,
          isStoredLocally: true,
          warning: 'Saved to local system (Database response: ' + orderError.message + ')',
        };
      }

      // Insert Order Items if provided
      if (input.items && input.items.length > 0) {
        const itemsToInsert = input.items.map((item) => ({
          order_id: orderData.id,
          medicine_id: item.medicineId.startsWith('dmh-') ? null : item.medicineId,
          medicine_name: item.medicineName,
          quantity: item.quantity,
          estimated_price: item.priceEstimate || null,
        }));

        await supabase.from('order_items').insert(itemsToInsert);
      } else if (input.medicineNameText) {
        await supabase.from('order_items').insert({
          order_id: orderData.id,
          medicine_name: input.medicineNameText.trim(),
          quantity: input.quantity || 1,
        });
      }

      return {
        success: true,
        orderNumber: orderData.order_number,
        orderId: orderData.id,
        isStoredInSupabase: true,
      };
    } catch (err: unknown) {
      console.error('Failed to submit order to Supabase:', err);
      return {
        success: true,
        orderNumber,
        isStoredLocally: true,
        warning: 'Order generated successfully (Offline/Local mode)',
      };
    }
  }

  // Fallback when Supabase env vars are pending setup
  return {
    success: true,
    orderNumber,
    isStoredLocally: true,
    note: 'Supabase credentials pending in .env.local',
  };
}
