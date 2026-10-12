'use client';

import React, { useState, Suspense } from 'react';
import { useSearchParams } from 'next/navigation';
import Link from 'next/link';
import {
  MessageCircle,
  FileUp,
  CheckCircle2,
  AlertCircle,
  ShieldCheck,
  Building,
  Phone,
  Clock,
} from 'lucide-react';
import { createOrder, useShopSettings } from '@/lib/store';
import { submitOrderAction } from '@/app/actions/orders';
import { getWhatsAppUrl } from '@/lib/contact';

function OrderMedicineContent() {
  const searchParams = useSearchParams();
  const prefillMedicine = searchParams.get('medicine') || '';

  const settings = useShopSettings();
  const [formData, setFormData] = useState({
    customerName: '',
    mobile: '',
    email: '',
    medicineName: prefillMedicine,
    quantity: 1,
    preference: 'Pickup at Kubri Store' as 'Pickup at Kubri Store' | 'Local Home Delivery (Subject to Area)',
    address: 'Village Kubri, Giridih',
    additionalMessage: '',
  });

  const [prescriptionFile, setPrescriptionFile] = useState<File | null>(null);
  const [fileError, setFileError] = useState<string | null>(null);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [submittedOrderNumber, setSubmittedOrderNumber] = useState<string | null>(null);

  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setFileError(null);
    const file = e.target.files?.[0];
    if (!file) return;

    // Validate type: JPG, JPEG, PNG, PDF
    const validTypes = ['image/jpeg', 'image/png', 'image/jpg', 'application/pdf'];
    if (!validTypes.includes(file.type)) {
      setFileError('Invalid file type. Please upload JPG, PNG, or PDF.');
      return;
    }

    // Validate size: max 10MB
    if (file.size > 10 * 1024 * 1024) {
      setFileError('File size exceeds 10MB limit. Please upload a smaller file.');
      return;
    }

    setPrescriptionFile(file);
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!formData.customerName.trim() || !formData.mobile.trim() || !formData.medicineName.trim()) {
      alert('Please fill in Customer Name, Mobile Number, and Medicine Name.');
      return;
    }

    setIsSubmitting(true);

    try {
      const res = await submitOrderAction({
        customerName: formData.customerName.trim(),
        mobile: formData.mobile.trim(),
        email: formData.email.trim() || undefined,
        preference: formData.preference,
        address: formData.address.trim(),
        additionalMessage: formData.additionalMessage.trim() || undefined,
        medicineNameText: formData.medicineName.trim(),
        quantity: Number(formData.quantity) || 1,
        items: [
          {
            medicineId: 'custom-item',
            medicineName: formData.medicineName.trim(),
            quantity: Number(formData.quantity) || 1,
          },
        ],
      });

      if (!res.success) {
        alert(res.error || 'Failed to submit order request. Please try again.');
        setIsSubmitting(false);
        return;
      }

      // Also sync to local state store for immediate local display
      createOrder({
        customerName: formData.customerName.trim(),
        mobile: formData.mobile.trim(),
        email: formData.email.trim() || undefined,
        preference: formData.preference,
        address: formData.address.trim(),
        additionalMessage: formData.additionalMessage.trim() || undefined,
        medicineNameText: formData.medicineName.trim(),
        quantity: Number(formData.quantity) || 1,
        items: [
          {
            medicineId: 'custom-item',
            medicineName: formData.medicineName.trim(),
            quantity: Number(formData.quantity) || 1,
          },
        ],
        prescriptionFileName: prescriptionFile ? prescriptionFile.name : undefined,
      });

      setSubmittedOrderNumber(res.orderNumber);
    } catch (err) {
      console.error(err);
      alert('Something went wrong while submitting your request. Please try again or WhatsApp us.');
    } finally {
      setIsSubmitting(false);
    }
  };

  // WhatsApp Order generator with exact requested format
  const handleWhatsAppOrder = () => {
    const message = `Hello Durga Medical Hall,\n\nI want to enquire/order the following medicine:\n\nMedicine: ${formData.medicineName || '[Please enter medicine name]'}\nQuantity: ${formData.quantity}\nCustomer Name: ${formData.customerName || '[Name]'}\nMobile: ${formData.mobile || '[Mobile]'}\nAddress: ${formData.address || '[Village Kubri, Giridih]'}\n\nPlease confirm availability.`;

    window.open(getWhatsAppUrl(message, settings.whatsapp), '_blank');
  };

  return (
    <div className="min-h-screen bg-slate-50 py-10">
      <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
        {/* Breadcrumb */}
        <div className="flex items-center gap-2 text-xs text-slate-500 mb-6">
          <Link href="/" className="hover:text-teal-700">
            Home
          </Link>
          <span>/</span>
          <span className="text-slate-800 font-semibold">Order Medicine</span>
        </div>

        {/* Page Title */}
        <div className="mb-8">
          <h1 className="text-3xl font-extrabold text-slate-900 tracking-tight">
            Order Medicine Request
          </h1>
          <p className="text-sm text-slate-600 mt-1 max-w-2xl">
            Submit your medicine requirements to Durga Medical Hall, Village Kubri. Our pharmacist will verify availability and reach out to you with pricing and readiness.
          </p>
        </div>

        {/* Submitted Success State (Requirement #12) */}
        {submittedOrderNumber ? (
          <div className="bg-white rounded-3xl p-8 sm:p-12 border border-slate-200 text-center shadow-md animate-in fade-in zoom-in-95 duration-200">
            <div className="w-16 h-16 rounded-full bg-emerald-100 text-emerald-700 flex items-center justify-center mx-auto mb-4">
              <CheckCircle2 className="w-8 h-8" />
            </div>
            <span className="text-xs font-bold uppercase tracking-wider text-emerald-700 bg-emerald-50 px-3 py-1 rounded-full border border-emerald-200">
              Request Received: {submittedOrderNumber}
            </span>
            <h2 className="text-2xl font-extrabold text-slate-900 mt-3 mb-2">
              Your medicine request has been received.
            </h2>
            <p className="text-base text-slate-700 max-w-md mx-auto mb-6 leading-relaxed">
              Durga Medical Hall will verify availability and contact you on{' '}
              <strong className="text-slate-900">{formData.mobile}</strong>.
            </p>

            <div className="p-4 rounded-2xl bg-amber-50/80 border border-amber-200 text-xs text-amber-900 max-w-lg mx-auto text-left mb-8 flex items-start gap-2.5">
              <AlertCircle className="w-4 h-4 text-amber-700 shrink-0 mt-0.5" />
              <span>
                <strong>Verification Policy:</strong> Durga Medical Hall does not automatically confirm stock until physically checked at our Kubri dispensary. Prescription items require pharmacist authorization.
              </span>
            </div>

            <div className="flex flex-wrap items-center justify-center gap-3">
              <button
                type="button"
                onClick={handleWhatsAppOrder}
                className="py-3 px-5 rounded-xl bg-emerald-600 hover:bg-emerald-700 text-white font-bold text-xs sm:text-sm flex items-center gap-2 shadow-sm transition-all"
              >
                <MessageCircle className="w-4 h-4" />
                <span>Confirm on WhatsApp</span>
              </button>
              <Link
                href="/medicines"
                className="py-3 px-5 rounded-xl border border-slate-300 text-slate-700 font-semibold text-xs sm:text-sm hover:bg-slate-50 transition-colors"
              >
                Browse Other Medicines
              </Link>
            </div>
          </div>
        ) : (
          <div className="grid grid-cols-1 lg:grid-cols-12 gap-8">
            {/* Left Col: Order Form */}
            <div className="lg:col-span-8">
              <form
                onSubmit={handleSubmit}
                className="bg-white rounded-3xl p-6 sm:p-8 border border-slate-200 shadow-xs space-y-6"
              >
                {/* Customer Details Section */}
                <div>
                  <h2 className="text-base font-bold text-slate-900 mb-4 pb-2 border-b border-slate-100 flex items-center gap-2">
                    <span className="w-6 h-6 rounded-full bg-teal-100 text-teal-800 text-xs flex items-center justify-center font-bold">
                      1
                    </span>
                    Customer Information
                  </h2>
                  <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                    <div>
                      <label className="block text-xs font-semibold text-slate-700 mb-1">
                        Full Name <span className="text-rose-500">*</span>
                      </label>
                      <input
                        type="text"
                        required
                        value={formData.customerName}
                        onChange={(e) => setFormData({ ...formData, customerName: e.target.value })}
                        placeholder="e.g. Ramesh Kumar"
                        className="w-full py-2.5 px-3.5 bg-slate-50 border border-slate-300 rounded-xl text-slate-800 text-sm focus:bg-white focus:border-teal-600 focus:ring-1 focus:ring-teal-600 outline-hidden"
                      />
                    </div>

                    <div>
                      <label className="block text-xs font-semibold text-slate-700 mb-1">
                        Mobile Number <span className="text-rose-500">*</span>
                      </label>
                      <input
                        type="tel"
                        required
                        value={formData.mobile}
                        onChange={(e) => setFormData({ ...formData, mobile: e.target.value })}
                        placeholder="e.g. 9876543210"
                        className="w-full py-2.5 px-3.5 bg-slate-50 border border-slate-300 rounded-xl text-slate-800 text-sm focus:bg-white focus:border-teal-600 focus:ring-1 focus:ring-teal-600 outline-hidden"
                      />
                    </div>

                    <div className="sm:col-span-2">
                      <label className="block text-xs font-semibold text-slate-700 mb-1">
                        Email Address <span className="text-slate-400 font-normal">(Optional)</span>
                      </label>
                      <input
                        type="email"
                        value={formData.email}
                        onChange={(e) => setFormData({ ...formData, email: e.target.value })}
                        placeholder="e.g. yourname@example.com"
                        className="w-full py-2.5 px-3.5 bg-slate-50 border border-slate-300 rounded-xl text-slate-800 text-sm focus:bg-white focus:border-teal-600 focus:ring-1 focus:ring-teal-600 outline-hidden"
                      />
                    </div>
                  </div>
                </div>

                {/* Medicine / Product Requirements */}
                <div>
                  <h2 className="text-base font-bold text-slate-900 mb-4 pb-2 border-b border-slate-100 flex items-center gap-2">
                    <span className="w-6 h-6 rounded-full bg-teal-100 text-teal-800 text-xs flex items-center justify-center font-bold">
                      2
                    </span>
                    Medicine Requirements
                  </h2>
                  <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
                    <div className="sm:col-span-2">
                      <label className="block text-xs font-semibold text-slate-700 mb-1">
                        Medicine / Product Name <span className="text-rose-500">*</span>
                      </label>
                      <input
                        type="text"
                        required
                        value={formData.medicineName}
                        onChange={(e) => setFormData({ ...formData, medicineName: e.target.value })}
                        placeholder="e.g. Paracetamol 650mg, ORS, BP Machine"
                        className="w-full py-2.5 px-3.5 bg-slate-50 border border-slate-300 rounded-xl text-slate-800 text-sm focus:bg-white focus:border-teal-600 focus:ring-1 focus:ring-teal-600 outline-hidden"
                      />
                    </div>

                    <div>
                      <label className="block text-xs font-semibold text-slate-700 mb-1">
                        Quantity / Pack
                      </label>
                      <input
                        type="number"
                        min="1"
                        value={formData.quantity}
                        onChange={(e) => setFormData({ ...formData, quantity: Math.max(1, parseInt(e.target.value) || 1) })}
                        className="w-full py-2.5 px-3.5 bg-slate-50 border border-slate-300 rounded-xl text-slate-800 text-sm focus:bg-white focus:border-teal-600 focus:ring-1 focus:ring-teal-600 outline-hidden"
                      />
                    </div>
                  </div>

                  {/* Prescription Upload Attachment Option */}
                  <div className="mt-4 p-4 rounded-2xl bg-teal-50/50 border border-teal-200/80">
                    <div className="flex items-center justify-between mb-2">
                      <label className="text-xs font-bold text-teal-900 flex items-center gap-1.5">
                        <FileUp className="w-4 h-4 text-teal-700" />
                        <span>Upload Prescription (Optional / Required for Rx drugs)</span>
                      </label>
                      <span className="text-[11px] text-slate-500">JPG, PNG, PDF up to 10MB</span>
                    </div>

                    <input
                      type="file"
                      accept=".jpg,.jpeg,.png,.pdf"
                      onChange={handleFileChange}
                      className="block w-full text-xs text-slate-500 file:mr-4 file:py-2 file:px-4 file:rounded-xl file:border-0 file:text-xs file:font-semibold file:bg-teal-700 file:text-white hover:file:bg-teal-800 cursor-pointer"
                    />

                    {fileError && (
                      <p className="text-xs text-rose-600 mt-2 font-medium">{fileError}</p>
                    )}

                    {prescriptionFile && (
                      <div className="mt-2 text-xs text-teal-800 font-medium">
                        ✓ Selected: {prescriptionFile.name} ({(prescriptionFile.size / 1024).toFixed(1)} KB)
                      </div>
                    )}
                  </div>
                </div>

                {/* Fulfillment Preference & Address */}
                <div>
                  <h2 className="text-base font-bold text-slate-900 mb-4 pb-2 border-b border-slate-100 flex items-center gap-2">
                    <span className="w-6 h-6 rounded-full bg-teal-100 text-teal-800 text-xs flex items-center justify-center font-bold">
                      3
                    </span>
                    Fulfillment & Delivery
                  </h2>
                  <div className="space-y-4">
                    <div>
                      <label className="block text-xs font-semibold text-slate-700 mb-1">
                        Pickup / Delivery Preference
                      </label>
                      <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
                        <label
                          className={`p-3.5 rounded-xl border flex items-center gap-3 cursor-pointer transition-all ${
                            formData.preference === 'Pickup at Kubri Store'
                              ? 'bg-teal-50 border-teal-500 text-teal-950 font-semibold'
                              : 'bg-white border-slate-200 text-slate-700 hover:bg-slate-50'
                          }`}
                        >
                          <input
                            type="radio"
                            name="preference"
                            checked={formData.preference === 'Pickup at Kubri Store'}
                            onChange={() =>
                              setFormData({ ...formData, preference: 'Pickup at Kubri Store' })
                            }
                            className="text-teal-600 focus:ring-teal-500"
                          />
                          <div>
                            <span className="text-xs block">Pickup at Kubri Store</span>
                            <span className="text-[10px] text-slate-500">
                              Direct counter collection
                            </span>
                          </div>
                        </label>

                        <label
                          className={`p-3.5 rounded-xl border flex items-center gap-3 cursor-pointer transition-all ${
                            formData.preference === 'Local Home Delivery (Subject to Area)'
                              ? 'bg-teal-50 border-teal-500 text-teal-950 font-semibold'
                              : 'bg-white border-slate-200 text-slate-700 hover:bg-slate-50'
                          }`}
                        >
                          <input
                            type="radio"
                            name="preference"
                            checked={
                              formData.preference === 'Local Home Delivery (Subject to Area)'
                            }
                            onChange={() =>
                              setFormData({
                                ...formData,
                                preference: 'Local Home Delivery (Subject to Area)',
                              })
                            }
                            className="text-teal-600 focus:ring-teal-500"
                          />
                          <div>
                            <span className="text-xs block">Local Home Delivery</span>
                            <span className="text-[10px] text-slate-500">
                              Subject to Kubri & Makdiha area
                            </span>
                          </div>
                        </label>
                      </div>
                    </div>

                    <div>
                      <label className="block text-xs font-semibold text-slate-700 mb-1">
                        Delivery Address / Landmark <span className="text-rose-500">*</span>
                      </label>
                      <textarea
                        required
                        rows={2}
                        value={formData.address}
                        onChange={(e) => setFormData({ ...formData, address: e.target.value })}
                        placeholder="e.g. Village Kubri, Near Makdiha Panchayat Bhavan, Giridih"
                        className="w-full py-2.5 px-3.5 bg-slate-50 border border-slate-300 rounded-xl text-slate-800 text-sm focus:bg-white focus:border-teal-600 focus:ring-1 focus:ring-teal-600 outline-hidden"
                      />
                    </div>

                    <div>
                      <label className="block text-xs font-semibold text-slate-700 mb-1">
                        Additional Instructions / Note
                      </label>
                      <input
                        type="text"
                        value={formData.additionalMessage}
                        onChange={(e) =>
                          setFormData({ ...formData, additionalMessage: e.target.value })
                        }
                        placeholder="e.g. Need urgent delivery by this evening / Call before dispatch"
                        className="w-full py-2.5 px-3.5 bg-slate-50 border border-slate-300 rounded-xl text-slate-800 text-sm focus:bg-white focus:border-teal-600 focus:ring-1 focus:ring-teal-600 outline-hidden"
                      />
                    </div>
                  </div>
                </div>

                {/* Form Action Buttons */}
                <div className="pt-4 border-t border-slate-100 flex flex-col sm:flex-row gap-3">
                  <button
                    type="submit"
                    disabled={isSubmitting}
                    className="flex-1 py-3.5 px-6 rounded-xl bg-teal-700 hover:bg-teal-800 text-white font-bold text-sm shadow-md shadow-teal-700/20 text-center transition-all disabled:opacity-50"
                  >
                    {isSubmitting ? 'Submitting Request...' : 'Submit Order Request'}
                  </button>

                  <button
                    type="button"
                    onClick={handleWhatsAppOrder}
                    className="flex-1 py-3.5 px-6 rounded-xl bg-emerald-600 hover:bg-emerald-700 text-white font-bold text-sm shadow-md shadow-emerald-700/20 text-center flex items-center justify-center gap-2 transition-all"
                  >
                    <MessageCircle className="w-4 h-4" />
                    <span>Order via WhatsApp</span>
                  </button>
                </div>
              </form>
            </div>

            {/* Right Col: Store Info & Regulatory Reminder */}
            <div className="lg:col-span-4 space-y-6">
              <div className="bg-white rounded-3xl p-6 border border-slate-200 shadow-xs space-y-4">
                <div className="flex items-center gap-2 text-teal-800 font-bold text-sm">
                  <Building className="w-4 h-4 text-teal-700" />
                  <span>Durga Medical Hall Counter</span>
                </div>
                <p className="text-xs text-slate-600 leading-relaxed">
                  Orders submitted through this form are prepared directly at our local store:
                </p>
                <address className="not-italic text-xs text-slate-700 bg-slate-50 p-3 rounded-xl border border-slate-100 leading-relaxed font-mono">
                  Village – Kubri, Post – Kubri
                  <br />
                  Panchayat – Makdiha, Giridih
                  <br />
                  Jharkhand – 825418
                </address>

                <div className="text-xs space-y-2 pt-2 border-t border-slate-100 text-slate-600">
                  <div className="flex items-center gap-2">
                    <Clock className="w-3.5 h-3.5 text-teal-700" />
                    <span>
                      Counter Hours: {settings.openingTime} – {settings.closingTime}
                    </span>
                  </div>
                  <div className="flex items-center gap-2">
                    <Phone className="w-3.5 h-3.5 text-teal-700" />
                    <span>Helpline: {settings.phone}</span>
                  </div>
                </div>
              </div>

              {/* Safety notice card */}
              <div className="bg-amber-50 rounded-3xl p-6 border border-amber-200 text-xs text-amber-950 space-y-2">
                <div className="flex items-center gap-2 font-bold text-amber-900">
                  <ShieldCheck className="w-4 h-4 text-amber-700" />
                  <span>Pharmacy Protocol</span>
                </div>
                <p className="leading-relaxed">
                  By pharmacy regulations, all prescription medicines require verification by our registered pharmacist before being released for pickup or delivery.
                </p>
              </div>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}

export default function OrderMedicinePage() {
  return (
    <Suspense fallback={<div className="p-12 text-center text-slate-500">Loading order form...</div>}>
      <OrderMedicineContent />
    </Suspense>
  );
}
