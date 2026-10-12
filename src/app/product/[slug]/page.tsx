'use client';

import React from 'react';
import Link from 'next/link';
import { useParams } from 'next/navigation';
import { useCategories, useMedicines } from '@/lib/store';
import {
  ArrowLeft,
  ShieldCheck,
  FileCheck2,
  AlertTriangle,
  ShoppingBag,
  MessageCircle,
  Building,
  Sparkles,
  CheckCircle2,
  Pill,
  Clock,
  Phone,
} from 'lucide-react';
import { CONTACT_CONFIG } from '@/lib/contact';

function ProductDetailContent() {
  const params = useParams();
  const slug = params?.slug as string;

  const medicines = useMedicines();
  const categories = useCategories();

  const medicine = medicines.find((m) => m.slug === slug || m.id === slug);

  if (!medicine) {
    return (
      <div className="min-h-screen bg-slate-50 flex items-center justify-center p-4">
        <div className="bg-white p-8 sm:p-12 rounded-3xl border border-slate-200 text-center max-w-md shadow-xs">
          <div className="w-16 h-16 rounded-full bg-slate-100 text-slate-400 flex items-center justify-center mx-auto mb-4">
            <Pill className="w-8 h-8" />
          </div>
          <h2 className="text-xl font-bold text-slate-900">Medicine Not Found</h2>
          <p className="text-xs text-slate-500 mt-2 mb-6">
            The requested medicine or product details could not be found in our catalogue.
          </p>
          <div className="flex flex-col gap-2">
            <Link
              href="/medicines"
              className="py-2.5 px-4 rounded-xl bg-teal-700 text-white font-semibold text-xs hover:bg-teal-800"
            >
              Back to Medicine Catalogue
            </Link>
            <Link
              href="/order-medicine"
              className="py-2.5 px-4 rounded-xl border border-slate-300 text-slate-700 font-semibold text-xs hover:bg-slate-50"
            >
              Order Unlisted Medicine
            </Link>
          </div>
        </div>
      </div>
    );
  }

  const discountPercent =
    medicine.mrp > medicine.sellingPrice
      ? Math.round(((medicine.mrp - medicine.sellingPrice) / medicine.mrp) * 100)
      : 0;

  // WhatsApp Enquiry Link with pre-filled message
  const getWhatsAppLink = () => {
    const rawNumber = CONTACT_CONFIG.rawWhatsApp;
    const message = `Hello Durga Medical Hall,\n\nI want to enquire about medicine availability:\nMedicine: ${medicine.name}\nPack Size: ${medicine.packSize}\n\nPlease confirm availability at Kubri shop.`;
    const encoded = encodeURIComponent(message);
    return `https://wa.me/${rawNumber}?text=${encoded}`;
  };

  const relatedMedicines = medicines
    .filter((m) => m.categoryId === medicine.categoryId && m.id !== medicine.id)
    .slice(0, 3);

  return (
    <div className="min-h-screen bg-slate-50 py-10">
      <div className="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8">
        {/* Navigation Breadcrumb */}
        <div className="flex items-center gap-2 text-xs text-slate-500 mb-6">
          <Link href="/" className="hover:text-teal-700">
            Home
          </Link>
          <span>/</span>
          <Link href="/medicines" className="hover:text-teal-700">
            Medicines
          </Link>
          <span>/</span>
          <Link
            href={`/medicines/${categories.find((c) => c.id === medicine.categoryId || c.name.toLowerCase() === medicine.categoryName.toLowerCase())?.slug || medicine.categoryId}`}
            className="hover:text-teal-700"
          >
            {medicine.categoryName}
          </Link>
          <span>/</span>
          <span className="text-slate-800 font-semibold truncate max-w-xs">{medicine.name}</span>
        </div>

        {/* Back Button */}
        <div className="mb-6">
          <Link
            href="/medicines"
            className="inline-flex items-center gap-1.5 text-xs font-semibold text-teal-700 hover:text-teal-900"
          >
            <ArrowLeft className="w-4 h-4" />
            <span>Back to Catalogue</span>
          </Link>
        </div>

        {/* Main Product Card */}
        <div className="bg-white rounded-3xl border border-slate-200 shadow-sm overflow-hidden mb-10">
          <div className="grid grid-cols-1 lg:grid-cols-12 gap-8 p-6 sm:p-10">
            {/* Left Col: Visual Presentation */}
            <div className="lg:col-span-5 flex flex-col items-center">
              <div className="w-full aspect-square max-w-md rounded-2xl bg-gradient-to-tr from-slate-50 via-teal-50/40 to-slate-100 border border-slate-200 flex flex-col items-center justify-center p-8 relative shadow-inner">
                {/* Demo Badge */}
                {medicine.isDemo && (
                  <span className="absolute top-4 left-4 text-[11px] font-bold uppercase tracking-wider px-2.5 py-1 rounded-md bg-white border border-slate-200 text-slate-600 shadow-xs">
                    Demo Product
                  </span>
                )}

                {/* Rx Badge */}
                {medicine.prescriptionRequired ? (
                  <span className="absolute top-4 right-4 inline-flex items-center gap-1 text-xs font-bold px-2.5 py-1 rounded-full bg-rose-50 text-rose-700 border border-rose-200">
                    <FileCheck2 className="w-3.5 h-3.5 text-rose-600" />
                    Rx Required
                  </span>
                ) : (
                  <span className="absolute top-4 right-4 inline-flex items-center gap-1 text-xs font-semibold px-2.5 py-1 rounded-full bg-emerald-50 text-emerald-700 border border-emerald-200">
                    <ShieldCheck className="w-3.5 h-3.5 text-emerald-600" />
                    General Healthcare (OTC)
                  </span>
                )}

                <div className="w-24 h-24 sm:w-32 sm:h-32 rounded-3xl bg-white shadow-md border border-teal-100 flex items-center justify-center text-teal-700 mb-4">
                  <Pill className="w-12 h-12 sm:w-16 sm:h-16 text-teal-600" />
                </div>

                <div className="text-center">
                  <span className="text-sm font-bold text-slate-800 block">{medicine.packSize}</span>
                  <span className="text-xs text-slate-500 font-mono">
                    Batch: {medicine.batchNumber || 'DEMO-BATCH'}
                  </span>
                </div>
              </div>

              {/* Local store availability tag */}
              <div className="w-full mt-4 p-3.5 rounded-xl bg-slate-50 border border-slate-200 text-xs text-slate-600 flex items-center justify-between">
                <span className="flex items-center gap-2">
                  <Building className="w-4 h-4 text-teal-700" />
                  <span>Dispensed at Durga Medical Hall</span>
                </span>
                <span className="font-semibold text-slate-800">Kubri, Giridih</span>
              </div>
            </div>

            {/* Right Col: Details & Actions */}
            <div className="lg:col-span-7 space-y-6">
              <div>
                <span className="text-xs font-bold text-teal-700 uppercase tracking-wider block mb-1">
                  {medicine.categoryName}
                </span>
                <h1 className="text-2xl sm:text-3xl font-extrabold text-slate-900 leading-tight">
                  {medicine.name}
                </h1>
                <div className="flex flex-wrap items-center gap-3 mt-2 text-xs text-slate-600">
                  <span>
                    Brand: <strong className="text-slate-800">{medicine.brand}</strong>
                  </span>
                  <span>•</span>
                  <span>
                    Manufacturer: <strong className="text-slate-800">{medicine.manufacturer}</strong>
                  </span>
                </div>
              </div>

              {/* Composition block */}
              <div className="bg-slate-50 rounded-2xl p-4 border border-slate-200">
                <div className="flex items-center gap-1.5 text-xs font-bold text-slate-700 mb-1">
                  <Sparkles className="w-3.5 h-3.5 text-teal-600" />
                  <span>Active Salt & Composition</span>
                </div>
                <p className="text-xs text-slate-800 font-mono leading-relaxed">
                  {medicine.composition}
                </p>
                <div className="mt-2 pt-2 border-t border-slate-200/80 text-[11px] text-slate-500">
                  Generic Drug: {medicine.genericName}
                </div>
              </div>

              {/* Pricing & Stock Card */}
              <div className="bg-teal-50/50 rounded-2xl p-5 border border-teal-100 flex flex-col sm:flex-row sm:items-center justify-between gap-4">
                <div>
                  <div className="flex items-baseline gap-3">
                    <span className="text-3xl font-black text-slate-900">
                      ₹{medicine.sellingPrice.toFixed(2)}
                    </span>
                    {medicine.mrp > medicine.sellingPrice && (
                      <span className="text-sm text-slate-400 line-through">
                        MRP ₹{medicine.mrp.toFixed(2)}
                      </span>
                    )}
                    {discountPercent > 0 && (
                      <span className="text-xs font-bold bg-teal-600 text-white px-2 py-0.5 rounded-full">
                        {discountPercent}% OFF
                      </span>
                    )}
                  </div>
                  <span className="text-[11px] text-slate-500 block mt-0.5">
                    Inclusive of all taxes • Pack: {medicine.packSize}
                  </span>
                </div>

                <div className="shrink-0">
                  {medicine.stockQuantity > 0 ? (
                    <span className="inline-flex items-center gap-1.5 text-xs font-bold text-emerald-800 bg-emerald-100/80 px-3 py-1.5 rounded-xl border border-emerald-300">
                      <CheckCircle2 className="w-4 h-4 text-emerald-600" />
                      In Stock at Kubri ({medicine.stockQuantity} available)
                    </span>
                  ) : (
                    <span className="inline-flex items-center gap-1.5 text-xs font-bold text-amber-800 bg-amber-100/80 px-3 py-1.5 rounded-xl border border-amber-300">
                      <Clock className="w-4 h-4 text-amber-600" />
                      Check Availability
                    </span>
                  )}
                </div>
              </div>

              {/* Primary Action Buttons */}
              <div className="flex flex-col sm:flex-row gap-3 pt-2">
                <Link
                  href={`/order-medicine?medicine=${encodeURIComponent(medicine.name)}`}
                  className="flex-1 py-3.5 px-5 rounded-xl bg-teal-700 hover:bg-teal-800 text-white font-bold text-sm shadow-md shadow-teal-700/20 text-center flex items-center justify-center gap-2 transition-all"
                >
                  <ShoppingBag className="w-4 h-4" />
                  <span>Order Medicine</span>
                </Link>

                <a
                  href={getWhatsAppLink()}
                  target="_blank"
                  rel="noopener noreferrer"
                  aria-label={`WhatsApp Us about ${medicine.name}`}
                  className="flex-1 py-3.5 px-5 rounded-xl bg-emerald-600 hover:bg-emerald-700 text-white font-bold text-sm shadow-md shadow-emerald-700/20 text-center flex items-center justify-center gap-2 transition-all"
                >
                  <MessageCircle className="w-4 h-4" />
                  <span>WhatsApp Us</span>
                </a>

                <a
                  href={CONTACT_CONFIG.phoneHref}
                  aria-label={`Call Now at ${CONTACT_CONFIG.displayPhone} to enquire about ${medicine.name}`}
                  className="sm:w-auto py-3.5 px-5 rounded-xl bg-slate-100 hover:bg-slate-200 text-slate-800 font-bold text-sm text-center flex items-center justify-center gap-2 transition-all border border-slate-300"
                >
                  <Phone className="w-4 h-4 text-teal-700" />
                  <span>Call Now</span>
                </a>
              </div>

              {/* Prescription requirement warning if Rx */}
              {medicine.prescriptionRequired && (
                <div className="p-4 rounded-xl bg-rose-50 border border-rose-200 text-xs text-rose-900 flex items-start gap-2.5">
                  <FileCheck2 className="w-4 h-4 text-rose-600 shrink-0 mt-0.5" />
                  <div>
                    <strong className="font-semibold block">Prescription Drug Requirement:</strong>
                    This is a prescription medication. To dispense this medicine, our registered pharmacist at Durga Medical Hall requires a valid doctor prescription. You can upload it during checkout or bring it to our Kubri counter.
                  </div>
                </div>
              )}
            </div>
          </div>

          {/* Description & Clinical Information Tabs */}
          <div className="border-t border-slate-200 p-6 sm:p-10 space-y-6 bg-slate-50/50">
            <div>
              <h2 className="text-base font-bold text-slate-900 mb-2">Product Description</h2>
              <p className="text-sm text-slate-700 leading-relaxed">{medicine.description}</p>
            </div>

            {medicine.dosageGuidelines && (
              <div>
                <h3 className="text-sm font-bold text-slate-900 mb-1">Dosage & Administration</h3>
                <p className="text-xs text-slate-600 leading-relaxed">
                  {medicine.dosageGuidelines}
                </p>
              </div>
            )}

            {medicine.storageInstructions && (
              <div>
                <h3 className="text-sm font-bold text-slate-900 mb-1">Storage Condition</h3>
                <p className="text-xs text-slate-600 leading-relaxed">
                  {medicine.storageInstructions}
                </p>
              </div>
            )}

            {/* MANDATORY LEGAL MEDICAL DISCLAIMER BOX (Requirement #11) */}
            <div className="p-5 rounded-2xl bg-amber-50 border border-amber-300 text-xs text-amber-950 flex items-start gap-3">
              <AlertTriangle className="w-5 h-5 text-amber-700 shrink-0 mt-0.5" />
              <div className="space-y-1">
                <strong className="font-bold text-amber-900 block text-sm">
                  Important Pharmacy & Safety Notice:
                </strong>
                <p className="leading-relaxed">
                  &ldquo;Medicine information is provided for general product identification. Use medicines only as advised by a qualified healthcare professional. Prescription medicines are subject to applicable prescription and verification requirements.&rdquo;
                </p>
              </div>
            </div>
          </div>
        </div>

        {/* Related Products from same category */}
        {relatedMedicines.length > 0 && (
          <div className="mt-12">
            <h3 className="text-xl font-bold text-slate-900 mb-4">
              More in {medicine.categoryName}
            </h3>
            <div className="grid grid-cols-1 sm:grid-cols-3 gap-6">
              {relatedMedicines.map((m) => (
                <Link
                  key={m.id}
                  href={`/product/${m.slug}`}
                  className="bg-white p-5 rounded-2xl border border-slate-200 shadow-xs hover:border-teal-300 transition-all flex flex-col justify-between"
                >
                  <div>
                    <span className="text-[10px] font-semibold text-teal-700 uppercase block mb-1">
                      {m.categoryName}
                    </span>
                    <h4 className="font-bold text-slate-900 text-sm">{m.name}</h4>
                    <p className="text-xs text-slate-500 font-mono mt-1 line-clamp-1">
                      {m.genericName}
                    </p>
                  </div>
                  <div className="mt-4 pt-3 border-t border-slate-100 flex items-center justify-between text-xs">
                    <span className="font-bold text-slate-900">₹{m.sellingPrice.toFixed(2)}</span>
                    <span className="text-teal-700 font-semibold">View Details →</span>
                  </div>
                </Link>
              ))}
            </div>
          </div>
        )}
      </div>
    </div>
  );
}

export default function ProductDetailPage() {
  return (
    <React.Suspense fallback={<div className="p-12 text-center text-slate-500">Loading product...</div>}>
      <ProductDetailContent />
    </React.Suspense>
  );
}
