'use client';

import React from 'react';
import Link from 'next/link';
import {
  Building2,
  HeartHandshake,
  ShieldCheck,
  MapPin,
  Sparkles,
  Users,
  AlertCircle,
} from 'lucide-react';
import { CONTACT_CONFIG } from '@/lib/contact';
import ContactButtons from '@/components/ContactButtons';

export default function AboutPage() {
  return (
    <div className="min-h-screen bg-slate-50 py-10">
      <div className="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8">
        {/* Breadcrumb */}
        <div className="flex items-center gap-2 text-xs text-slate-500 mb-6">
          <Link href="/" className="hover:text-teal-700">
            Home
          </Link>
          <span>/</span>
          <span className="text-slate-800 font-semibold">About Us</span>
        </div>

        {/* Hero Banner */}
        <div className="bg-white rounded-3xl p-8 sm:p-12 border border-slate-200 shadow-xs mb-10 text-center max-w-4xl mx-auto">
          <span className="text-xs font-bold uppercase tracking-wider text-teal-700 bg-teal-50 px-3 py-1 rounded-full border border-teal-200">
            About Durga Medical Hall
          </span>
          <h1 className="text-3xl sm:text-4xl font-extrabold text-slate-900 mt-4 mb-4 tracking-tight">
            Your Local Medical Store in Village Kubri, Giridih
          </h1>
          <p className="text-base sm:text-lg text-slate-700 leading-relaxed max-w-2xl mx-auto font-normal">
            &ldquo;Durga Medical Hall is a local medical store located in Village Kubri, District Giridih, Jharkhand. Our goal is to make medicines and healthcare products easily accessible to customers while providing convenient and customer-friendly service.&rdquo;
          </p>

          <div className="mt-6 flex flex-wrap items-center justify-center gap-3 text-xs text-slate-500">
            <span className="flex items-center gap-1">
              <MapPin className="w-3.5 h-3.5 text-teal-600" />
              Panchayat Makdiha, Giridih
            </span>
            <span>•</span>
            <span className="flex items-center gap-1">
              <Building2 className="w-3.5 h-3.5 text-teal-600" />
              PIN: 825418, Jharkhand
            </span>
          </div>
        </div>

        {/* 5 Core Sections per Requirement #17 */}
        <div className="space-y-8">
          {/* 1. Our Mission */}
          <div className="bg-white rounded-3xl p-6 sm:p-8 border border-slate-200 shadow-xs">
            <div className="flex items-start gap-4">
              <div className="w-12 h-12 rounded-2xl bg-teal-50 text-teal-700 flex items-center justify-center shrink-0">
                <HeartHandshake className="w-6 h-6" />
              </div>
              <div className="space-y-2">
                <h2 className="text-xl font-bold text-slate-900">Our Mission</h2>
                <p className="text-sm text-slate-600 leading-relaxed">
                  Our mission is to bridge healthcare accessibility in rural and semi-urban communities by providing reliable medicines, healthcare supplies, and attentive customer assistance right in Village Kubri. We aim to ensure that local residents have access to necessary health products without having to undertake lengthy journeys to distant municipal centers.
                </p>
              </div>
            </div>
          </div>

          {/* 2. Our Service */}
          <div className="bg-white rounded-3xl p-6 sm:p-8 border border-slate-200 shadow-xs">
            <div className="flex items-start gap-4">
              <div className="w-12 h-12 rounded-2xl bg-blue-50 text-blue-700 flex items-center justify-center shrink-0">
                <ShieldCheck className="w-6 h-6" />
              </div>
              <div className="space-y-2">
                <h2 className="text-xl font-bold text-slate-900">Our Service</h2>
                <p className="text-sm text-slate-600 leading-relaxed">
                  We operate a neighborhood pharmacy dispensary adhering strictly to standard pharmacy regulations. Our services include:
                </p>
                <ul className="text-sm text-slate-600 space-y-2 list-disc list-inside pt-1">
                  <li>Counter dispensing of verified prescription medications.</li>
                  <li>Over-the-counter (OTC) remedies for fever, cough, acidity, and minor ailments.</li>
                  <li>In-store and digital prescription verification before dispensing.</li>
                  <li>Checking batch numbers and expiration dates prior to product release.</li>
                </ul>
              </div>
            </div>
          </div>

          {/* 3. Customer Convenience */}
          <div className="bg-white rounded-3xl p-6 sm:p-8 border border-slate-200 shadow-xs">
            <div className="flex items-start gap-4">
              <div className="w-12 h-12 rounded-2xl bg-emerald-50 text-emerald-700 flex items-center justify-center shrink-0">
                <Sparkles className="w-6 h-6" />
              </div>
              <div className="space-y-2">
                <h2 className="text-xl font-bold text-slate-900">Customer Convenience</h2>
                <p className="text-sm text-slate-600 leading-relaxed">
                  To save our customers valuable time and hassle, Durga Medical Hall offers flexible channels to enquire and arrange medicines:
                </p>
                <div className="grid grid-cols-1 sm:grid-cols-3 gap-3 pt-2">
                  <div className="p-3.5 rounded-xl bg-slate-50 border border-slate-100 text-xs">
                    <strong className="text-slate-900 block font-semibold mb-1">
                      Online Medicine Order
                    </strong>
                    <span>Submit medicine names through our web portal for rapid counter packing.</span>
                  </div>
                  <div className="p-3.5 rounded-xl bg-slate-50 border border-slate-100 text-xs">
                    <strong className="text-slate-900 block font-semibold mb-1">
                      Prescription Upload
                    </strong>
                    <span>Upload a clear slip photo from your smartphone for pharmacist verification.</span>
                  </div>
                  <div className="p-3.5 rounded-xl bg-slate-50 border border-slate-100 text-xs">
                    <strong className="text-slate-900 block font-semibold mb-1">
                      WhatsApp Quick Chat
                    </strong>
                    <span>Direct chat to check stock, prices, or batch availability from home.</span>
                  </div>
                </div>
              </div>
            </div>
          </div>

          {/* 4. Healthcare Products */}
          <div className="bg-white rounded-3xl p-6 sm:p-8 border border-slate-200 shadow-xs">
            <div className="flex items-start gap-4">
              <div className="w-12 h-12 rounded-2xl bg-amber-50 text-amber-700 flex items-center justify-center shrink-0">
                <Building2 className="w-6 h-6" />
              </div>
              <div className="space-y-2">
                <h2 className="text-xl font-bold text-slate-900">Healthcare Products Range</h2>
                <p className="text-sm text-slate-600 leading-relaxed">
                  Beyond therapeutic drugs, our catalogue covers essential personal and family healthcare needs across 28 health categories, including baby care essentials, oral hygiene, first-aid bandages, digital thermometers, blood glucose strips, and traditional wellness formulations.
                </p>
              </div>
            </div>
          </div>

          {/* 5. Local Community */}
          <div className="bg-white rounded-3xl p-6 sm:p-8 border border-slate-200 shadow-xs">
            <div className="flex items-start gap-4">
              <div className="w-12 h-12 rounded-2xl bg-purple-50 text-purple-700 flex items-center justify-center shrink-0">
                <Users className="w-6 h-6" />
              </div>
              <div className="space-y-2">
                <h2 className="text-xl font-bold text-slate-900">Local Community Commitment</h2>
                <p className="text-sm text-slate-600 leading-relaxed">
                  We take pride in being rooted in Village Kubri and Makdiha Panchayat. We value personal relationships, mutual trust, and transparency with every family who walks through our doors.
                </p>
              </div>
            </div>
          </div>

          {/* 6. Pharmacist / Chemist Information */}
          <div className="bg-white rounded-3xl p-6 sm:p-8 border border-slate-200 shadow-xs">
            <div className="flex items-start gap-4">
              <div className="w-12 h-12 rounded-2xl bg-teal-50 text-teal-700 flex items-center justify-center shrink-0">
                <ShieldCheck className="w-6 h-6" />
              </div>
              <div className="space-y-2">
                <span className="text-xs font-bold uppercase tracking-wider text-teal-700 block">
                  Pharmacy Dispensing & Supervision
                </span>
                <h2 className="text-xl font-bold text-slate-900">
                  {CONTACT_CONFIG.pharmacistChemistTitle}
                </h2>
                <p className="text-sm text-slate-600 leading-relaxed">
                  Dispensing oversight, prescription handling, and customer medicine checks at Durga Medical Hall are conducted under the supervision of {CONTACT_CONFIG.pharmacistName} at our Village Kubri premises.
                </p>
              </div>
            </div>
          </div>
        </div>

        {/* Regulatory disclaimer notice */}
        <div className="mt-10 p-5 rounded-2xl bg-slate-100 border border-slate-200 text-xs text-slate-600 flex items-start gap-3">
          <AlertCircle className="w-5 h-5 text-slate-500 shrink-0 mt-0.5" />
          <p>
            <strong>Regulatory Statement:</strong> Durga Medical Hall adheres to the Drugs and Cosmetics Act and applicable pharmacy practice regulations. We do not provide automated disease diagnosis or symptom-based drug recommendations. Always consult a qualified registered medical practitioner.
          </p>
        </div>

        {/* CTA banner */}
        <div className="mt-8 bg-teal-800 text-white rounded-3xl p-8 text-center space-y-4">
          <h3 className="text-2xl font-bold">Have a Question or Need a Medicine?</h3>
          <p className="text-teal-100 text-sm max-w-lg mx-auto">
            Contact Durga Medical Hall in Village Kubri today or explore our medicines catalogue online.
          </p>
          <div className="flex flex-wrap items-center justify-center gap-3 pt-2">
            <ContactButtons
              size="md"
              phoneLabel="Call Now"
              whatsAppLabel="WhatsApp Us"
            />
            <Link
              href="/order-medicine"
              className="py-2 px-4 rounded-lg bg-white/10 hover:bg-white/20 text-white font-semibold text-xs border border-white/20 transition-colors"
            >
              Order Medicine
            </Link>
            <Link
              href="/contact"
              className="py-2 px-4 rounded-lg bg-white/10 hover:bg-white/20 text-white font-semibold text-xs border border-white/20 transition-colors"
            >
              Store Directions
            </Link>
          </div>
        </div>
      </div>
    </div>
  );
}
