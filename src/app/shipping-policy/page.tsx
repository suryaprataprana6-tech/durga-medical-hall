import React from 'react';
import Link from 'next/link';
import type { Metadata } from 'next';
export const metadata: Metadata = {
  title: 'Delivery & Shipping Policy | Durga Medical Hall',
  description: 'Delivery and store pickup policy for medicines and healthcare products in Kubri, Giridih.',
};

export default function ShippingPolicyPage() {
  return (
    <div className="min-h-screen bg-slate-50 py-10">
      <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex items-center gap-2 text-xs text-slate-500 mb-6">
          <Link href="/" className="hover:text-teal-700">Home</Link>
          <span>/</span>
          <span className="text-slate-800 font-semibold">Delivery Policy</span>
        </div>

        <div className="bg-white rounded-3xl p-6 sm:p-10 border border-slate-200 shadow-xs space-y-8">
          <div className="border-b border-slate-100 pb-6">
            <span className="text-xs font-bold uppercase tracking-wider text-teal-700 bg-teal-50 px-3 py-1 rounded-full border border-teal-200">
              Fulfillment Services
            </span>
            <h1 className="text-3xl font-extrabold text-slate-900 mt-3">Delivery & Shipping Policy</h1>
            <p className="text-xs text-slate-500 mt-1">
              Durga Medical Hall • Village Kubri, Post Kubri, Panchayat Makdiha, District Giridih, Jharkhand – 825418
            </p>
          </div>

          <section className="space-y-3 text-sm text-slate-700 leading-relaxed">
            <h2 className="text-lg font-bold text-slate-900">1. Fulfillment Modes</h2>
            <p>Durga Medical Hall offers two primary fulfillment options:</p>
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-4 pt-1">
              <div className="p-4 rounded-2xl bg-teal-50/50 border border-teal-200 space-y-1">
                <strong className="text-teal-900 font-bold block text-sm">A. In-Store Counter Pickup</strong>
                <p className="text-xs text-teal-800">
                  Customers can collect their verified and packed medicines directly at our Village Kubri shop counter with zero wait time.
                </p>
              </div>

              <div className="p-4 rounded-2xl bg-blue-50/50 border border-blue-200 space-y-1">
                <strong className="text-blue-900 font-bold block text-sm">B. Local Home Delivery</strong>
                <p className="text-xs text-blue-800">
                  Provided to local residences in Village Kubri, Makdiha Panchayat, and adjacent localities within accessible service limits.
                </p>
              </div>
            </div>
          </section>

          <section className="space-y-3 text-sm text-slate-700 leading-relaxed">
            <h2 className="text-lg font-bold text-slate-900">2. Service Eligibility Conditions</h2>
            <p>Delivery of medicines and healthcare products is strictly subject to:</p>
            <ul className="list-disc list-inside space-y-1.5 pl-2">
              <li><strong>Service Area Feasibility:</strong> Verified accessibility within Kubri and surrounding rural roads.</li>
              <li><strong>Product & Batch Availability:</strong> Real-time in-stock availability at the Kubri store.</li>
              <li><strong>Prescription Verification:</strong> Mandatory pharmacist authorization for Schedule H and prescription items.</li>
              <li><strong>Address Accuracy:</strong> Precise landmark, village tola, and accessible customer phone number.</li>
              <li><strong>Delivery Personnel Availability:</strong> Local rider availability during store working hours.</li>
            </ul>
          </section>

          <section className="space-y-3 text-sm text-slate-700 leading-relaxed">
            <h2 className="text-lg font-bold text-slate-900">3. Delivery Timelines & Charges</h2>
            <ul className="list-disc list-inside space-y-1.5 pl-2">
              <li>Orders placed for Kubri central areas are typically prepared within 1 to 3 hours during normal store hours.</li>
              <li>Delivery charges (if applicable for peripheral villages) are communicated transparently before final order dispatch.</li>
              <li>Customers will always have the option to pick up their order at the counter free of any handling or delivery fee.</li>
            </ul>
          </section>

          <section className="space-y-3 text-sm text-slate-700 leading-relaxed">
            <h2 className="text-lg font-bold text-slate-900">4. Verification at Delivery Point</h2>
            <p>
              For prescription medications delivered to your doorstep, the original physical doctor prescription slip must be presented for verification and stamping by the delivery agent if requested by the pharmacist.
            </p>
          </section>

          <div className="pt-6 border-t border-slate-100 text-xs text-slate-500">
            <p>
              <em>Important Note: Delivery policies are subject to local road and weather conditions in Giridih district. Configurable in admin settings.</em>
            </p>
          </div>
        </div>
      </div>
    </div>
  );
}
