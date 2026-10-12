'use client';

import React, { useState } from 'react';
import Link from 'next/link';
import {
  MapPin,
  Phone,
  MessageCircle,
  Clock,
  Send,
  CheckCircle2,
} from 'lucide-react';
import { useShopSettings, createEnquiry } from '@/lib/store';
import { submitEnquiryAction } from '@/app/actions/enquiries';
import { CONTACT_CONFIG } from '@/lib/contact';
import ContactButtons from '@/components/ContactButtons';

export default function ContactPage() {
  const settings = useShopSettings();
  const [formData, setFormData] = useState({
    name: '',
    mobile: '',
    email: '',
    medicineInterested: '',
    message: '',
  });
  const [submitted, setSubmitted] = useState(false);
  const [loading, setLoading] = useState(false);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!formData.name.trim() || !formData.mobile.trim() || !formData.message.trim()) {
      alert('Please fill in your Name, Mobile, and Message.');
      return;
    }

    setLoading(true);
    try {
      const res = await submitEnquiryAction({
        customerName: formData.name.trim(),
        mobile: formData.mobile.trim(),
        email: formData.email.trim() || undefined,
        medicineInterested: formData.medicineInterested.trim() || undefined,
        message: formData.message.trim(),
      });

      if (!res.success) {
        alert(res.error || 'Failed to submit enquiry.');
        setLoading(false);
        return;
      }

      createEnquiry({
        customerName: formData.name.trim(),
        mobile: formData.mobile.trim(),
        email: formData.email.trim() || undefined,
        medicineInterested: formData.medicineInterested.trim() || undefined,
        message: formData.message.trim(),
      });
      setSubmitted(true);
    } catch (err) {
      console.error(err);
      alert('Failed to send message. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-slate-50 py-10">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        {/* Breadcrumb */}
        <div className="flex items-center gap-2 text-xs text-slate-500 mb-6">
          <Link href="/" className="hover:text-teal-700">
            Home
          </Link>
          <span>/</span>
          <span className="text-slate-800 font-semibold">Contact Us</span>
        </div>

        {/* Page Header */}
        <div className="mb-10 text-center max-w-2xl mx-auto">
          <h1 className="text-3xl sm:text-4xl font-extrabold text-slate-900 tracking-tight">
            Contact Durga Medical Hall
          </h1>
          <p className="text-sm text-slate-600 mt-2">
            We are here to help customers in Village Kubri and surrounding panchayats. Reach out for medicine inquiries, prescription checks, or store visits.
          </p>
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-12 gap-8 mb-12">
          {/* Left Col: Shop Address & Contact Details */}
          <div className="lg:col-span-5 space-y-6">
            <div className="bg-white rounded-3xl p-6 sm:p-8 border border-slate-200 shadow-xs space-y-6">
              <div>
                <span className="text-xs font-bold uppercase tracking-wider text-teal-700 block mb-1">
                  Physical Store
                </span>
                <h2 className="text-xl font-bold text-slate-900">Durga Medical Hall</h2>
              </div>

              {/* Exact Shop Address */}
              <div className="p-4 rounded-2xl bg-slate-50 border border-slate-200 text-sm text-slate-800 space-y-1 font-mono">
                <p className="font-bold text-slate-900">Village – Kubri</p>
                <p>Post – Kubri</p>
                <p>Panchayat – Makdiha</p>
                <p>District – Giridih</p>
                <p>Jharkhand – 825418</p>
                <p>India</p>
              </div>

              {/* Contact Information */}
              <div className="space-y-4 pt-2">
                <div className="flex items-start gap-3">
                  <div className="w-10 h-10 rounded-xl bg-teal-50 text-teal-700 flex items-center justify-center shrink-0">
                    <Phone className="w-5 h-5" />
                  </div>
                  <div>
                    <span className="text-xs font-semibold text-slate-500 block">Phone Call</span>
                    <a
                      href={CONTACT_CONFIG.phoneHref}
                      className="text-sm font-bold text-slate-900 font-mono hover:text-teal-700 transition-colors"
                    >
                      {CONTACT_CONFIG.displayPhone}
                    </a>
                    <div className="mt-1">
                      <a
                        href={CONTACT_CONFIG.phoneHref}
                        className="inline-flex items-center gap-1 text-xs font-semibold text-teal-700 hover:text-teal-900"
                      >
                        Call Now →
                      </a>
                    </div>
                  </div>
                </div>

                <div className="flex items-start gap-3">
                  <div className="w-10 h-10 rounded-xl bg-emerald-50 text-emerald-700 flex items-center justify-center shrink-0">
                    <MessageCircle className="w-5 h-5" />
                  </div>
                  <div>
                    <span className="text-xs font-semibold text-slate-500 block">WhatsApp Chat</span>
                    <a
                      href={CONTACT_CONFIG.whatsAppHref}
                      target="_blank"
                      rel="noopener noreferrer"
                      className="text-sm font-bold text-slate-900 font-mono hover:text-emerald-700 transition-colors"
                    >
                      {CONTACT_CONFIG.displayWhatsApp}
                    </a>
                    <div className="mt-1">
                      <a
                        href={CONTACT_CONFIG.whatsAppHref}
                        target="_blank"
                        rel="noopener noreferrer"
                        className="inline-flex items-center gap-1 text-xs font-semibold text-emerald-700 hover:text-emerald-900"
                      >
                        WhatsApp Us →
                      </a>
                    </div>
                  </div>
                </div>

                {/* Pharmacist / Chemist Information */}
                <div className="p-3.5 rounded-2xl bg-teal-50/70 border border-teal-200/80">
                  <span className="text-xs font-semibold text-teal-800 block">
                    {CONTACT_CONFIG.pharmacistChemistTitle}
                  </span>
                  <p className="text-[11px] text-slate-600 mt-0.5">
                    Responsible dispensing and verification at Durga Medical Hall, Village Kubri.
                  </p>
                </div>

                <div className="flex items-start gap-3">
                  <div className="w-10 h-10 rounded-xl bg-amber-50 text-amber-700 flex items-center justify-center shrink-0">
                    <Clock className="w-5 h-5" />
                  </div>
                  <div>
                    <span className="text-xs font-semibold text-slate-500 block">Opening Hours</span>
                    <span className="text-sm font-bold text-slate-900">
                      {settings.openingTime} – {settings.closingTime}
                    </span>
                    <span className="block text-xs text-slate-500 mt-0.5">
                      Schedule: {settings.weeklyHoliday}
                    </span>
                  </div>
                </div>
              </div>

              {/* Action Buttons */}
              <div className="pt-4 border-t border-slate-100">
                <ContactButtons
                  size="md"
                  phoneLabel="Call Now"
                  whatsAppLabel="WhatsApp Us"
                  className="w-full justify-stretch grid grid-cols-2"
                />
              </div>
            </div>
          </div>

          {/* Right Col: Send Message / General Enquiry */}
          <div className="lg:col-span-7">
            <div className="bg-white rounded-3xl p-6 sm:p-8 border border-slate-200 shadow-xs">
              <h2 className="text-xl font-bold text-slate-900 mb-1">Send a Message / Medicine Query</h2>
              <p className="text-xs text-slate-500 mb-6">
                Fill this enquiry form and our counter team will respond as soon as possible.
              </p>

              {submitted ? (
                <div className="p-8 bg-emerald-50 rounded-2xl border border-emerald-200 text-center space-y-3">
                  <CheckCircle2 className="w-12 h-12 text-emerald-600 mx-auto" />
                  <h3 className="text-lg font-bold text-emerald-950">Thank you for contacting us!</h3>
                  <p className="text-xs text-emerald-800 max-w-sm mx-auto">
                    Your inquiry has been received. Durga Medical Hall will reach out to you on{' '}
                    <strong>{formData.mobile}</strong> shortly.
                  </p>
                  <button
                    type="button"
                    onClick={() => {
                      setSubmitted(false);
                      setFormData({
                        name: '',
                        mobile: '',
                        email: '',
                        medicineInterested: '',
                        message: '',
                      });
                    }}
                    className="mt-3 px-4 py-2 rounded-xl bg-teal-700 text-white text-xs font-semibold"
                  >
                    Send Another Message
                  </button>
                </div>
              ) : (
                <form onSubmit={handleSubmit} className="space-y-4">
                  <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                    <div>
                      <label className="block text-xs font-semibold text-slate-700 mb-1">
                        Your Name <span className="text-rose-500">*</span>
                      </label>
                      <input
                        type="text"
                        required
                        value={formData.name}
                        onChange={(e) => setFormData({ ...formData, name: e.target.value })}
                        placeholder="e.g. Ramesh Verma"
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
                  </div>

                  <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                    <div>
                      <label className="block text-xs font-semibold text-slate-700 mb-1">
                        Email Address (Optional)
                      </label>
                      <input
                        type="email"
                        value={formData.email}
                        onChange={(e) => setFormData({ ...formData, email: e.target.value })}
                        placeholder="e.g. name@example.com"
                        className="w-full py-2.5 px-3.5 bg-slate-50 border border-slate-300 rounded-xl text-slate-800 text-sm focus:bg-white focus:border-teal-600 focus:ring-1 focus:ring-teal-600 outline-hidden"
                      />
                    </div>

                    <div>
                      <label className="block text-xs font-semibold text-slate-700 mb-1">
                        Medicine / Product of Interest
                      </label>
                      <input
                        type="text"
                        value={formData.medicineInterested}
                        onChange={(e) => setFormData({ ...formData, medicineInterested: e.target.value })}
                        placeholder="e.g. Diabetes strips, ORS, etc."
                        className="w-full py-2.5 px-3.5 bg-slate-50 border border-slate-300 rounded-xl text-slate-800 text-sm focus:bg-white focus:border-teal-600 focus:ring-1 focus:ring-teal-600 outline-hidden"
                      />
                    </div>
                  </div>

                  <div>
                    <label className="block text-xs font-semibold text-slate-700 mb-1">
                      Your Message / Inquiry <span className="text-rose-500">*</span>
                    </label>
                    <textarea
                      required
                      rows={4}
                      value={formData.message}
                      onChange={(e) => setFormData({ ...formData, message: e.target.value })}
                      placeholder="Write your question or request here..."
                      className="w-full py-2.5 px-3.5 bg-slate-50 border border-slate-300 rounded-xl text-slate-800 text-sm focus:bg-white focus:border-teal-600 focus:ring-1 focus:ring-teal-600 outline-hidden"
                    />
                  </div>

                  <button
                    type="submit"
                    disabled={loading}
                    className="w-full py-3 px-6 rounded-xl bg-teal-700 hover:bg-teal-800 text-white font-bold text-sm shadow-md shadow-teal-700/20 text-center flex items-center justify-center gap-2 transition-all disabled:opacity-50"
                  >
                    <Send className="w-4 h-4" />
                    <span>{loading ? 'Submitting...' : 'Submit Message'}</span>
                  </button>
                </form>
              )}
            </div>
          </div>
        </div>

        {/* Location Section & Google Map Container (Requirement #16) */}
        <div className="bg-white rounded-3xl p-6 sm:p-8 border border-slate-200 shadow-xs overflow-hidden">
          <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 mb-6">
            <div>
              <h2 className="text-xl font-bold text-slate-900">Store Directions & Map</h2>
              <p className="text-xs text-slate-500 mt-1">
                Village Kubri, Post Kubri, Panchayat Makdiha, District Giridih, Jharkhand 825418
              </p>
            </div>
            <a
              href={settings.googleMapsUrl}
              target="_blank"
              rel="noopener noreferrer"
              className="inline-flex items-center gap-2 px-4 py-2 rounded-xl bg-teal-700 hover:bg-teal-800 text-white text-xs font-semibold shadow-xs"
            >
              <MapPin className="w-4 h-4" />
              <span>Get Directions on Google Maps</span>
            </a>
          </div>

          <div className="w-full h-72 sm:h-80 bg-slate-100 rounded-2xl border border-slate-200 flex flex-col items-center justify-center p-6 text-center">
            <div className="w-12 h-12 rounded-full bg-teal-50 text-teal-700 flex items-center justify-center mb-2">
              <MapPin className="w-6 h-6" />
            </div>
            <h3 className="font-bold text-slate-900 text-sm">Durga Medical Hall</h3>
            <p className="text-xs text-slate-600 max-w-sm mt-1">
              Village Kubri, Post Kubri, Panchayat Makdiha, District Giridih, Jharkhand 825418
            </p>
            <span className="text-[11px] text-slate-400 mt-3">
              Configurable Map Link in Pharmacist Admin Settings: {settings.googleMapsUrl}
            </span>
          </div>
        </div>
      </div>
    </div>
  );
}
