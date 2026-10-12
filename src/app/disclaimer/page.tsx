import React from 'react';
import Link from 'next/link';
import type { Metadata } from 'next';
import { AlertTriangle } from 'lucide-react';

export const metadata: Metadata = {
  title: 'Medical Disclaimer | Durga Medical Hall',
  description: 'Important medical and pharmaceutical disclaimer for Durga Medical Hall, Kubri, Giridih.',
};

export default function MedicalDisclaimerPage() {
  return (
    <div className="min-h-screen bg-slate-50 py-10">
      <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex items-center gap-2 text-xs text-slate-500 mb-6">
          <Link href="/" className="hover:text-teal-700">Home</Link>
          <span>/</span>
          <span className="text-slate-800 font-semibold">Medical Disclaimer</span>
        </div>

        <div className="bg-white rounded-3xl p-6 sm:p-10 border border-slate-200 shadow-xs space-y-8">
          <div className="border-b border-slate-100 pb-6">
            <span className="text-xs font-bold uppercase tracking-wider text-rose-700 bg-rose-50 px-3 py-1 rounded-full border border-rose-200">
              Mandatory Healthcare Notice
            </span>
            <h1 className="text-3xl font-extrabold text-slate-900 mt-3">Medical Disclaimer</h1>
            <p className="text-xs text-slate-500 mt-1">
              Durga Medical Hall • Village Kubri, Post Kubri, Panchayat Makdiha, District Giridih, Jharkhand – 825418
            </p>
          </div>

          {/* Emergency Alert Callout */}
          <div className="p-5 rounded-2xl bg-rose-50 border border-rose-200 text-rose-950 space-y-2">
            <div className="flex items-center gap-2 font-bold text-rose-900 text-base">
              <AlertTriangle className="w-5 h-5 text-rose-600" />
              <span>Medical Emergency Notice</span>
            </div>
            <p className="text-xs sm:text-sm leading-relaxed">
              If you or someone under your care is experiencing a severe medical emergency, chest pain, breathing difficulty, acute poisoning, severe allergic reaction, or injury, <strong>DO NOT rely on this website</strong>. Contact an ambulance, call 108/112, or proceed immediately to the nearest hospital or emergency healthcare facility.
            </p>
          </div>

          <section className="space-y-3 text-sm text-slate-700 leading-relaxed">
            <h2 className="text-lg font-bold text-slate-900">1. Not a Substitute for Medical Advice</h2>
            <p>
              The content published on this website — including drug classifications, product descriptions, salt compositions, pack sizes, and therapeutic categories — is intended <strong>strictly for general educational and product identification purposes</strong>.
            </p>
            <p>
              This website is <strong>NOT a substitute for professional medical advice, diagnosis, or clinical treatment</strong>. Always seek the advice of a certified physician, registered medical practitioner, or other qualified healthcare provider regarding any medical condition or treatment plan.
            </p>
          </section>

          <section className="space-y-3 text-sm text-slate-700 leading-relaxed">
            <h2 className="text-lg font-bold text-slate-900">2. Prohibition on Self-Medication</h2>
            <p>
              Customers must never self-medicate, alter their drug dosages, or initiate new pharmaceutical regimens based solely on information found on this website or online search. Self-medication carries significant health hazards including adverse drug interactions, organ toxicity, and severe allergic reactions.
            </p>
          </section>

          <section className="space-y-3 text-sm text-slate-700 leading-relaxed">
            <h2 className="text-lg font-bold text-slate-900">3. Prescription Dispensing Regulations</h2>
            <p>
              All prescription medications catalogued on this website are dispensed strictly in adherence to the Drugs and Cosmetics Act (1940) and Pharmacy Practice Regulations.
            </p>
            <p>
              No prescription-only medicine will be supplied or released without verification of an authentic, non-expired prescription issued by a Registered Medical Practitioner. Durga Medical Hall pharmacists reserve the absolute right to refuse dispensing if prescription criteria are not met.
            </p>
          </section>

          <section className="space-y-3 text-sm text-slate-700 leading-relaxed">
            <h2 className="text-lg font-bold text-slate-900">4. Limitation of Liability</h2>
            <p>
              Durga Medical Hall, its management, and staff disclaim all liability for any direct, indirect, incidental, or consequential harm or damages resulting from the misuse of information provided on this platform or self-administration of medications without medical supervision.
            </p>
          </section>

          <div className="pt-6 border-t border-slate-100 flex flex-wrap items-center justify-between gap-4 text-xs text-slate-500">
            <span>Durga Medical Hall — Committed to Safe Pharmacy Practice</span>
            <Link href="/medicines" className="text-teal-700 hover:underline font-semibold">
              Browse Medicine Catalogue →
            </Link>
          </div>
        </div>
      </div>
    </div>
  );
}
