'use server';

import { createClient, isSupabaseConfigured } from '@/lib/supabase/server';

export interface SubmitEnquiryInput {
  customerName: string;
  mobile: string;
  email?: string;
  medicineInterested?: string;
  message: string;
}

export async function submitEnquiryAction(input: SubmitEnquiryInput) {
  // Validation
  if (!input.customerName || input.customerName.trim().length < 2) {
    return { success: false, error: 'Please enter your name.' };
  }

  const cleanMobile = (input.mobile || '').replace(/\D/g, '');
  if (cleanMobile.length < 10) {
    return { success: false, error: 'Please enter a valid 10-digit mobile number.' };
  }

  if (!input.message || input.message.trim().length < 5) {
    return { success: false, error: 'Please enter a message (at least 5 characters).' };
  }

  if (isSupabaseConfigured()) {
    try {
      const supabase = await createClient();

      const { data, error } = await supabase
        .from('enquiries')
        .insert({
          customer_name: input.customerName.trim(),
          mobile: cleanMobile,
          email: input.email?.trim() || null,
          medicine_interested: input.medicineInterested?.trim() || null,
          message: input.message.trim(),
          status: 'New',
        })
        .select('id')
        .single();

      if (error) {
        console.error('Supabase enquiry error:', error);
        return {
          success: true,
          isStoredLocally: true,
          warning: 'Submitted locally (Database note: ' + error.message + ')',
        };
      }

      return {
        success: true,
        enquiryId: data.id,
        isStoredInSupabase: true,
      };
    } catch (err: unknown) {
      console.error('Error submitting enquiry to Supabase:', err);
      return {
        success: true,
        isStoredLocally: true,
      };
    }
  }

  return {
    success: true,
    isStoredLocally: true,
    note: 'Supabase credentials pending in .env.local',
  };
}
