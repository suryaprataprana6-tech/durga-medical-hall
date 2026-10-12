import React from 'react';
import Link from 'next/link';
import type { Metadata } from 'next';

export const metadata: Metadata = {
  title: 'Privacy Policy | Durga Medical Hall',
  description: 'Privacy Policy regarding customer information, order processing, and prescription confidentiality at Durga Medical Hall, Kubri, Giridih.',
};

export default function PrivacyPolicyPage() {
  return (
    <div className="min-h-screen bg-slate-50 py-10">
      <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex items-center gap-2 text-xs text-slate-500 mb-6">
          <Link href="/" className="hover:text-teal-700">Home</Link>
          <span>/</span>
          <span className="text-slate-800 font-semibold">Privacy Policy</span>
        </div>

        <div className="bg-white rounded-3xl p-6 sm:p-10 border border-slate-200 shadow-xs space-y-8">
          <div className="border-b border-slate-100 pb-6">
            <span className="text-xs font-bold uppercase tracking-wider text-teal-700 bg-teal-50 px-3 py-1 rounded-full border border-teal-200">
              Legal & Compliance
            </span>
            <h1 className="text-3xl font-extrabold text-slate-900 mt-3">Privacy Policy</h1>
            <p className="text-xs text-slate-500 mt-1">
              Durga Medical Hall • Village Kubri, Post Kubri, Panchayat Makdiha, District Giridih, Jharkhand – 825418
            </p>
          </div>

          <section className="space-y-3 text-sm text-slate-700 leading-relaxed">
            <p>
              <strong>Durga Medical Hall</strong> respects customer privacy and is committed to protecting your personal information and sensitive healthcare data. This Privacy Policy details how we collect, use, and protect information gathered when you visit our website, submit medicine orders, or upload doctor prescriptions.
            </p>
          </section>

          <section className="space-y-3 text-sm text-slate-700 leading-relaxed">
            <h2 className="text-lg font-bold text-slate-900">1. Information We Collect</h2>
            <p>To provide reliable pharmacy services, we may collect the following details:</p>
            <ul className="list-disc list-inside space-y-1.5 pl-2">
              <li><strong>Personal Identifiers:</strong> Name, mobile telephone number, email address (optional).</li>
              <li><strong>Delivery & Location:</strong> Village name, tola/landmark, post office, pincode, delivery address.</li>
              <li><strong>Order Information:</strong> Medicine names, dosage forms, quantities, and communication preferences.</li>
              <li><strong>Prescription Information:</strong> Doctor’s slip image, PDF file, doctor’s clinic details, and patient medication history as provided by the customer.</li>
            </ul>
          </section>

          <section className="space-y-3 text-sm text-slate-700 leading-relaxed">
            <h2 className="text-lg font-bold text-slate-900">2. How Your Information is Used</h2>
            <p>The information collected is used solely for legitimate healthcare dispensary operations:</p>
            <ul className="list-disc list-inside space-y-1.5 pl-2">
              <li>Order processing, packaging, and stock verification.</li>
              <li>Pharmacist verification of doctor prescriptions in accordance with pharmacy law.</li>
              <li>Customer communication regarding medicine availability, alternatives, and order readiness.</li>
              <li>Local delivery and pickup coordination in Village Kubri and neighboring areas.</li>
              <li>Customer support and resolving inquiries.</li>
            </ul>
          </section>

          <section className="space-y-3 text-sm text-slate-700 leading-relaxed">
            <h2 className="text-lg font-bold text-slate-900">3. Confidentiality of Health & Prescription Data</h2>
            <div className="p-4 rounded-2xl bg-teal-50 border border-teal-200 text-teal-950 text-xs leading-relaxed space-y-1">
              <strong className="block font-bold">Strict Confidentiality Assurance:</strong>
              Prescription and health-related information is handled confidentially and only accessed where strictly necessary for service processing by authorized pharmacy staff. We do not expose uploaded prescriptions publicly.
            </div>
            <p>
              We maintain appropriate technical and physical safeguards to prevent unauthorized access, loss, or disclosure of your medical slips and personal contact data.
            </p>
          </section>

          <section className="space-y-3 text-sm text-slate-700 leading-relaxed">
            <h2 className="text-lg font-bold text-slate-900">4. Non-Sale of Personal Data</h2>
            <p>
              <strong>We do NOT sell, rent, trade, or monetize your personal information or patient data</strong> to third-party marketing companies or brokers under any circumstances.
            </p>
          </section>

          <section className="space-y-3 text-sm text-slate-700 leading-relaxed">
            <h2 className="text-lg font-bold text-slate-900">5. Legal Disclosures</h2>
            <p>
              Information may be disclosed when required by applicable law, regulation, lawful government request, or drug licensing authority audits as governed by the Drugs and Cosmetics Act and applicable Indian legislation.
            </p>
          </section>

          <section className="space-y-3 text-sm text-slate-700 leading-relaxed">
            <h2 className="text-lg font-bold text-slate-900">6. Contact for Privacy Concerns</h2>
            <p>
              If you have any questions about our privacy practices, please contact us directly at our store in Village Kubri, Post Kubri, Makdiha, Giridih, Jharkhand 825418 or via our website contact form.
            </p>
          </section>

          <div className="pt-6 border-t border-slate-100 text-xs text-slate-500">
            <p>
              <em>Important Note: This policy document is a website template and should be reviewed and updated according to actual business operations and pharmacy regulatory counsel.</em>
            </p>
          </div>
        </div>
      </div>
    </div>
  );
}
