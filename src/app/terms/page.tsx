import React from 'react';
import Link from 'next/link';
import type { Metadata } from 'next';
import { AlertTriangle } from 'lucide-react';

export const metadata: Metadata = {
  title: 'Terms & Conditions | Durga Medical Hall',
  description: 'Terms and Conditions of service, medicine dispensing, and order processing at Durga Medical Hall, Kubri, Giridih.',
};

export default function TermsPage() {
  return (
    <div className="min-h-screen bg-slate-50 py-10">
      <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex items-center gap-2 text-xs text-slate-500 mb-6">
          <Link href="/" className="hover:text-teal-700">Home</Link>
          <span>/</span>
          <span className="text-slate-800 font-semibold">Terms & Conditions</span>
        </div>

        <div className="bg-white rounded-3xl p-6 sm:p-10 border border-slate-200 shadow-xs space-y-8">
          <div className="border-b border-slate-100 pb-6">
            <span className="text-xs font-bold uppercase tracking-wider text-teal-700 bg-teal-50 px-3 py-1 rounded-full border border-teal-200">
              User Agreement
            </span>
            <h1 className="text-3xl font-extrabold text-slate-900 mt-3">Terms & Conditions</h1>
            <p className="text-xs text-slate-500 mt-1">
              Durga Medical Hall • Village Kubri, Post Kubri, Panchayat Makdiha, District Giridih, Jharkhand – 825418
            </p>
          </div>

          <div className="p-4 rounded-2xl bg-amber-50 border border-amber-200 text-xs text-amber-950 flex items-start gap-2.5">
            <AlertTriangle className="w-4 h-4 text-amber-700 shrink-0 mt-0.5" />
            <div>
              <strong>Emergency Notice:</strong> This website is NOT an emergency response facility. In case of acute medical emergencies, poisoning, or severe trauma, please contact your nearest hospital, emergency health center, or an ambulance immediately.
            </div>
          </div>

          <section className="space-y-3 text-sm text-slate-700 leading-relaxed">
            <h2 className="text-lg font-bold text-slate-900">1. Acceptance of Terms</h2>
            <p>
              By accessing the website of Durga Medical Hall, submitting medicine requests, or uploading prescriptions, you agree to comply with and be bound by these Terms and Conditions. If you do not agree with any part, please refrain from using the digital services.
            </p>
          </section>

          <section className="space-y-3 text-sm text-slate-700 leading-relaxed">
            <h2 className="text-lg font-bold text-slate-900">2. Product Availability & Dynamic Pricing</h2>
            <ul className="list-disc list-inside space-y-1.5 pl-2">
              <li>Product availability and batch stock levels are dynamic and can change without prior notice.</li>
              <li>Maximum Retail Prices (MRP) and selling rates are subject to manufacturer revisions and packaging changes.</li>
              <li>An order request submitted online does not constitute a legally binding sale until physically verified and confirmed by our Kubri dispensary.</li>
            </ul>
          </section>

          <section className="space-y-3 text-sm text-slate-700 leading-relaxed">
            <h2 className="text-lg font-bold text-slate-900">3. Prescription Verification Requirements</h2>
            <p>
              Under the Drugs and Cosmetics Act and applicable pharmacy regulations, prescription-only drugs (Schedule H, H1, X) will <strong>strictly not be dispensed</strong> without a genuine prescription written by a Registered Medical Practitioner.
            </p>
            <p>
              Our qualified pharmacist reserves the right to decline or request clarification on any prescription that is unreadable, expired, altered, or lacks necessary doctor credentials.
            </p>
          </section>

          <section className="space-y-3 text-sm text-slate-700 leading-relaxed">
            <h2 className="text-lg font-bold text-slate-900">4. Customer Obligations & Accuracy of Data</h2>
            <p>
              Customers must provide accurate contact numbers, valid patient names, and true delivery locations in Village Kubri or surrounding panchayats. Providing false or misleading information may lead to immediate cancellation of the order request.
            </p>
          </section>

          <section className="space-y-3 text-sm text-slate-700 leading-relaxed">
            <h2 className="text-lg font-bold text-slate-900">5. No Medical Advice or Self-Medication</h2>
            <p>
              The content published on this website (including medicine compositions, categories, and descriptions) is provided exclusively for general information and catalogue browsing. It does NOT constitute medical diagnosis, treatment recommendations, or doctor consultations. Customers must always consult a certified doctor before consuming any medication.
            </p>
          </section>

          <section className="space-y-3 text-sm text-slate-700 leading-relaxed">
            <h2 className="text-lg font-bold text-slate-900">6. Compliance with Indian Law</h2>
            <p>
              All interactions and sales are governed by the laws of India, the state of Jharkhand, and applicable municipal jurisdictions.
            </p>
          </section>

          <div className="pt-6 border-t border-slate-100 text-xs text-slate-500">
            <p>
              <em>Important Note: These terms are website templates and should be customized according to actual business requirements and local legal regulations before final commercial deployment.</em>
            </p>
          </div>
        </div>
      </div>
    </div>
  );
}
