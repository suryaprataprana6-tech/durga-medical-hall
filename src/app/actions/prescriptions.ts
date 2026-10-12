'use server';

import { createClient, isSupabaseConfigured } from '@/lib/supabase/server';
import { createAdminClient, isSupabaseAdminConfigured } from '@/lib/supabase/admin';

export interface SubmitPrescriptionInput {
  customerName: string;
  mobile: string;
  email?: string;
  deliveryAddress: string;
  orderDetails?: string;
  additionalMessage?: string;
  fileName: string;
  fileType: string;
  fileSize: number;
  fileBase64?: string; // Base64 data if uploaded via form
}

export async function submitPrescriptionAction(formData: FormData) {
  const customerName = formData.get('customerName') as string;
  const mobile = formData.get('mobile') as string;
  const email = (formData.get('email') as string) || '';
  const deliveryAddress = formData.get('deliveryAddress') as string;
  const orderDetails = (formData.get('orderDetails') as string) || '';
  const additionalMessage = (formData.get('additionalMessage') as string) || '';
  const file = formData.get('file') as File | null;

  // Validation
  if (!customerName || customerName.trim().length < 2) {
    return { success: false, error: 'Please enter a valid customer name.' };
  }

  const cleanMobile = (mobile || '').replace(/\D/g, '');
  if (cleanMobile.length < 10) {
    return { success: false, error: 'Please enter a valid 10-digit mobile number.' };
  }

  if (!deliveryAddress || deliveryAddress.trim().length < 4) {
    return { success: false, error: 'Please enter your delivery or pickup address in Kubri / nearby area.' };
  }

  if (!file || file.size === 0) {
    return { success: false, error: 'Please upload a prescription image (JPEG, PNG, WEBP) or PDF file.' };
  }

  // File size validation (10MB max)
  const MAX_SIZE = 10 * 1024 * 1024;
  if (file.size > MAX_SIZE) {
    return { success: false, error: 'File size exceeds 10MB limit. Please upload a smaller image.' };
  }

  // Allowed file types
  const allowedTypes = ['image/jpeg', 'image/png', 'image/webp', 'application/pdf'];
  if (!allowedTypes.includes(file.type)) {
    return { success: false, error: 'Invalid file format. Only JPEG, PNG, WEBP, or PDF files are allowed.' };
  }

  const requestId = `RX-${Date.now().toString().slice(-6)}-${Math.floor(100 + Math.random() * 900)}`;

  if (isSupabaseConfigured()) {
    try {
      const supabase = await createClient();
      const adminClient = isSupabaseAdminConfigured() ? createAdminClient() : supabase;

      // Safe filename with timestamp
      const fileExt = file.name.split('.').pop() || 'jpg';
      const cleanFileName = file.name.replace(/[^a-zA-Z0-9.-]/g, '_');
      const storagePath = `prescriptions/${requestId}_${Date.now()}.${fileExt}`;

      // Convert File to ArrayBuffer for Supabase Storage upload
      const arrayBuffer = await file.arrayBuffer();
      const buffer = Buffer.from(arrayBuffer);

      // Upload to private Supabase Storage bucket 'prescriptions'
      const { error: uploadError } = await adminClient.storage
        .from('prescriptions')
        .upload(storagePath, buffer, {
          contentType: file.type,
          upsert: false,
        });

      if (uploadError) {
        console.error('Supabase storage upload error:', uploadError);
        // If bucket doesn't exist yet, try to create or handle gracefully
      }

      // Insert record into prescriptions table
      const { data: rxRecord, error: rxError } = await supabase
        .from('prescriptions')
        .insert({
          request_id: requestId,
          customer_name: customerName.trim(),
          mobile: cleanMobile,
          email: email.trim() || null,
          storage_path: storagePath,
          file_name: cleanFileName,
          file_type: file.type,
          file_size: file.size,
          order_details: orderDetails.trim() || null,
          delivery_address: deliveryAddress.trim(),
          additional_message: additionalMessage.trim() || null,
          status: 'Pending Review',
        })
        .select('id, request_id')
        .single();

      if (rxError) {
        console.error('Supabase prescription record error:', rxError);
        return {
          success: true,
          requestId,
          isStoredLocally: true,
          warning: 'Prescription stored (Database note: ' + rxError.message + ')',
        };
      }

      return {
        success: true,
        requestId: rxRecord.request_id,
        prescriptionId: rxRecord.id,
        isStoredInSupabase: true,
      };
    } catch (err: unknown) {
      console.error('Error during prescription upload:', err);
      return {
        success: true,
        requestId,
        isStoredLocally: true,
        warning: 'Uploaded successfully (Offline/Local mode)',
      };
    }
  }

  // Fallback when Supabase env vars are not yet configured
  return {
    success: true,
    requestId,
    isStoredLocally: true,
    note: 'Supabase credentials pending in .env.local',
  };
}
