import React from 'react';
import Link from 'next/link';
import type { Metadata } from 'next';
export const metadata: Metadata = {
  title: 'Refund & Cancellation Policy | Durga Medical Hall',
  description: 'Refund, return, and cancellation policy for medicines and healthcare products at Durga Medical Hall, Kubri.',
};

export default function RefundPolicyPage() {
  return (
    <div className="min-h-screen bg-slate-50 py-10">
      <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex items-center gap-2 text-xs text-slate-500 mb-6">
          <Link href="/" className="hover:text-teal-700">Home</Link>
          <span>/</span>
          <span className="text-slate-800 font-semibold">Refund Policy</span>
        </div>

        <div className="bg-white rounded-3xl p-6 sm:p-10 border border-slate-200 shadow-xs space-y-8">
          <div className="border-b border-slate-100 pb-6">
            <span className="text-xs font-bold uppercase tracking-wider text-teal-700 bg-teal-50 px-3 py-1 rounded-full border border-teal-200">
              Customer Protection
            </span>
            <h1 className="text-3xl font-extrabold text-slate-900 mt-3">Refund & Cancellation Policy</h1>
            <p className="text-xs text-slate-500 mt-1">
              Durga Medical Hall • Village Kubri, Post Kubri, Panchayat Makdiha, District Giridih, Jharkhand – 825418
            </p>
          </div>

          <section className="space-y-3 text-sm text-slate-700 leading-relaxed">
            <h2 className="text-lg font-bold text-slate-900">1. Order Cancellation</h2>
            <p>
              Cancellation and refund depend on current order status, product classification, and applicable pharmacy health standards:
            </p>
            <ul className="list-disc list-inside space-y-1.5 pl-2">
              <li>
                <strong>Before Packing/Dispatch:</strong> Customers may cancel their pending order request at any time prior to packaging confirmation by contacting our store counter or sending a WhatsApp message.
              </li>
              <li>
                <strong>After Dispensing/Dispatch:</strong> Once prescription medications have been dispensed, packaged with batch-specific seal, or dispatched for local delivery, cancellations are restricted to preserve drug safety and integrity.
              </li>
            </ul>
          </section>

          <section className="space-y-3 text-sm text-slate-700 leading-relaxed">
            <h2 className="text-lg font-bold text-slate-900">2. Pharmaceutical Return Restrictions</h2>
            <div className="p-4 rounded-2xl bg-amber-50 border border-amber-200 text-xs text-amber-950 space-y-1">
              <strong className="block font-bold">Important Medicine Safety Regulation:</strong>
              Under pharmacy hygiene protocols and cold-chain integrity standards, medicines and opened surgical supplies cannot be returned or restocked once delivered, except in verifiable instances of transit damage, manufacturing defect, or incorrect item dispatch.
            </div>
            <p>Non-returnable product categories include:</p>
            <ul className="list-disc list-inside space-y-1 pl-2 text-xs">
              <li>Refrigerated / Temperature-sensitive biologics and vaccines.</li>
              <li>Opened or unsealed strips, syrups, and ointments.</li>
              <li>Personal hygiene products, infant feeding accessories, and diagnostic strips.</li>
            </ul>
          </section>

          <section className="space-y-3 text-sm text-slate-700 leading-relaxed">
            <h2 className="text-lg font-bold text-slate-900">3. Damaged or Incorrect Products</h2>
            <p>
              If you receive an incorrect product or an item damaged during transit, please inform Durga Medical Hall within 24 hours of pickup/delivery along with proof (photo or cash memo). We will arrange an immediate replacement or refund.
            </p>
          </section>

          <section className="space-y-3 text-sm text-slate-700 leading-relaxed">
            <h2 className="text-lg font-bold text-slate-900">4. Refund Processing</h2>
            <p>
              Eligible refunds will be processed according to the original method of payment (cash at counter or UPI) within 3 to 5 business days upon physical return and inspection of the goods at our Village Kubri counter.
            </p>
          </section>

          <div className="pt-6 border-t border-slate-100 text-xs text-slate-500">
            <p>
              <em>Important Note: This refund policy is a website template and should be reviewed and customized according to the actual business model and pharmacy licensing regulations before production use.</em>
            </p>
          </div>
        </div>
      </div>
    </div>
  );
}
