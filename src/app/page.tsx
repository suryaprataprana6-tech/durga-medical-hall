'use client';

import React from 'react';
import Link from 'next/link';
import {
  ShoppingBag,
  FileUp,
  MessageCircle,
  Phone,
  MapPin,
  ShieldCheck,
  HeartPulse,
  HelpCircle,
  ArrowRight,
  AlertTriangle,
  Building2,
  ChevronRight,
} from 'lucide-react';
import SearchAutocomplete from '@/components/SearchAutocomplete';
import MedicineCard from '@/components/MedicineCard';
import CategoryCard from '@/components/CategoryCard';
import HeroSection from '@/components/HeroSection';
import { useCategories, useMedicines, useShopSettings } from '@/lib/store';
import { CONTACT_CONFIG, getWhatsAppUrl } from '@/lib/contact';

export default function HomePage() {
  const categories = useCategories();
  const medicines = useMedicines();
  const settings = useShopSettings();

  const featuredMedicines = medicines.slice(0, 6);
  const popularCategories = categories.slice(0, 8);

  const getWhatsAppLink = (customText?: string) => {
    return getWhatsAppUrl(customText);
  };

  const getPhoneLink = () => {
    return CONTACT_CONFIG.phoneHref;
  };

  return (
    <div className="min-h-screen bg-slate-50 flex flex-col">
      {/* 1. HERO SECTION */}
      <HeroSection />

      {/* 2. QUICK ACTION CARDS */}
      <section className="-mt-8 relative z-20 max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="grid grid-cols-2 md:grid-cols-4 gap-3 sm:gap-5">
          <Link
            href="/order-medicine"
            className="group bg-white p-5 rounded-2xl border border-slate-200 shadow-md hover:shadow-xl hover:border-teal-400 transition-all flex flex-col justify-between"
          >
            <div className="w-12 h-12 rounded-xl bg-teal-50 text-teal-700 flex items-center justify-center mb-3 group-hover:scale-110 transition-transform">
              <ShoppingBag className="w-6 h-6" />
            </div>
            <div>
              <h3 className="font-bold text-slate-900 group-hover:text-teal-700 text-sm sm:text-base">
                Order Medicine
              </h3>
              <p className="text-xs text-slate-500 mt-1">Submit names & quantity for quick processing</p>
            </div>
            <div className="mt-3 flex items-center text-xs font-semibold text-teal-700">
              <span>Start Order</span>
              <ChevronRight className="w-4 h-4 ml-1" />
            </div>
          </Link>

          <Link
            href="/upload-prescription"
            className="group bg-white p-5 rounded-2xl border border-slate-200 shadow-md hover:shadow-xl hover:border-teal-400 transition-all flex flex-col justify-between"
          >
            <div className="w-12 h-12 rounded-xl bg-blue-50 text-blue-700 flex items-center justify-center mb-3 group-hover:scale-110 transition-transform">
              <FileUp className="w-6 h-6" />
            </div>
            <div>
              <h3 className="font-bold text-slate-900 group-hover:text-teal-700 text-sm sm:text-base">
                Upload Prescription
              </h3>
              <p className="text-xs text-slate-500 mt-1">Send your doctor slip for verified dispensing</p>
            </div>
            <div className="mt-3 flex items-center text-xs font-semibold text-blue-700">
              <span>Upload Slip</span>
              <ChevronRight className="w-4 h-4 ml-1" />
            </div>
          </Link>

          <a
            href={getWhatsAppLink()}
            target="_blank"
            rel="noopener noreferrer"
            className="group bg-white p-5 rounded-2xl border border-slate-200 shadow-md hover:shadow-xl hover:border-emerald-400 transition-all flex flex-col justify-between"
          >
            <div className="w-12 h-12 rounded-xl bg-emerald-50 text-emerald-700 flex items-center justify-center mb-3 group-hover:scale-110 transition-transform">
              <MessageCircle className="w-6 h-6" />
            </div>
            <div>
              <h3 className="font-bold text-slate-900 group-hover:text-emerald-700 text-sm sm:text-base">
                WhatsApp Us
              </h3>
              <p className="text-xs text-slate-500 mt-1">Chat directly for quick availability check</p>
            </div>
            <div className="mt-3 flex items-center text-xs font-semibold text-emerald-700">
              <span>Chat Now</span>
              <ChevronRight className="w-4 h-4 ml-1" />
            </div>
          </a>

          <a
            href={getPhoneLink()}
            className="group bg-white p-5 rounded-2xl border border-slate-200 shadow-md hover:shadow-xl hover:border-teal-400 transition-all flex flex-col justify-between"
          >
            <div className="w-12 h-12 rounded-xl bg-slate-100 text-slate-800 flex items-center justify-center mb-3 group-hover:scale-110 transition-transform">
              <Phone className="w-6 h-6 text-teal-700" />
            </div>
            <div>
              <h3 className="font-bold text-slate-900 group-hover:text-teal-700 text-sm sm:text-base">
                Call Now
              </h3>
              <p className="text-xs text-slate-500 mt-1">Speak directly with our counter staff</p>
            </div>
            <div className="mt-3 flex items-center text-xs font-semibold text-teal-700">
              <span>Call Now</span>
              <ChevronRight className="w-4 h-4 ml-1" />
            </div>
          </a>
        </div>
      </section>

      {/* 3. MEDICINE SEARCH SECTION */}
      <section className="py-16 max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 w-full">
        <div className="bg-gradient-to-r from-teal-50 via-slate-50 to-blue-50 rounded-3xl p-6 sm:p-10 border border-teal-100 shadow-sm text-center">
          <span className="text-xs uppercase font-extrabold tracking-wider text-teal-800 bg-teal-100/60 px-3 py-1 rounded-full">
            Medicine Catalogue & Search
          </span>
          <h2 className="text-2xl sm:text-3xl font-bold text-slate-900 mt-3 mb-2">
            Find Medicines & Healthcare Products
          </h2>
          <p className="text-sm text-slate-600 max-w-xl mx-auto mb-6">
            Search across {categories.length} specialized health categories, salts, generic brands and devices.
          </p>

          <div className="max-w-2xl mx-auto">
            <SearchAutocomplete placeholder="Search medicine, product or category..." />
          </div>

          <div className="mt-4 flex flex-wrap items-center justify-center gap-2 text-xs text-slate-500">
            <span className="font-semibold text-slate-700">Popular searches:</span>
            <Link href="/medicines?q=Paracetamol" className="hover:text-teal-700 underline">
              Paracetamol
            </Link>
            <span>•</span>
            <Link href="/medicines?q=Multivitamin" className="hover:text-teal-700 underline">
              Multivitamin
            </Link>
            <span>•</span>
            <Link href="/medicines?q=ORS" className="hover:text-teal-700 underline">
              ORS Sachet
            </Link>
            <span>•</span>
            <Link href="/medicines?q=BP" className="hover:text-teal-700 underline">
              Blood Pressure Monitor
            </Link>
          </div>
        </div>
      </section>

      {/* 4. POPULAR HEALTH CATEGORIES */}
      <section id="categories" className="py-8 max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 w-full scroll-mt-24">
        <div className="flex flex-col sm:flex-row sm:items-end justify-between mb-8 gap-4">
          <div>
            <span className="text-xs font-bold uppercase tracking-wider text-teal-700 block mb-1">
              Organized Health Care
            </span>
            <h2 className="text-2xl sm:text-3xl font-extrabold text-slate-900">
              Browse by Health Category
            </h2>
            <p className="text-sm text-slate-600 mt-1">
              Easy navigation across {categories.length} therapeutic & daily wellness segments.
            </p>
          </div>
          <Link
            href="/medicines"
            className="inline-flex items-center gap-1 text-sm font-bold text-teal-700 hover:text-teal-800 shrink-0"
          >
            <span>View All 28 Categories</span>
            <ArrowRight className="w-4 h-4" />
          </Link>
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 sm:gap-6">
          {popularCategories.map((cat) => (
            <CategoryCard key={cat.id} category={cat} />
          ))}
        </div>
      </section>

      {/* 5. HEALTHCARE PRODUCTS (SAMPLE CATALOGUE) */}
      <section className="py-16 bg-white border-y border-slate-200">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex flex-col sm:flex-row sm:items-end justify-between mb-8 gap-4">
            <div>
              <div className="flex items-center gap-2 mb-1">
                <span className="text-xs font-bold uppercase tracking-wider text-teal-700">
                  Featured Catalogue
                </span>
                <span className="text-[10px] font-bold uppercase tracking-wider bg-slate-100 text-slate-600 px-2 py-0.5 rounded">
                  Demo Products
                </span>
              </div>
              <h2 className="text-2xl sm:text-3xl font-extrabold text-slate-900">
                Healthcare Products & Medicines
              </h2>
              <p className="text-sm text-slate-600 mt-1">
                Demo catalogue for store identification. Actual availability confirmed upon order request.
              </p>
            </div>
            <Link
              href="/medicines"
              className="inline-flex items-center gap-1 text-sm font-bold text-teal-700 hover:text-teal-800 shrink-0"
            >
              <span>Explore Entire Catalogue</span>
              <ArrowRight className="w-4 h-4" />
            </Link>
          </div>

          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
            {featuredMedicines.map((med) => (
              <MedicineCard key={med.id} medicine={med} />
            ))}
          </div>

          {/* Compliance Disclaimer Notice Under Products */}
          <div className="mt-10 p-4 rounded-2xl bg-amber-50/60 border border-amber-200 text-xs text-amber-900 flex items-start gap-3">
            <AlertTriangle className="w-5 h-5 text-amber-600 shrink-0 mt-0.5" />
            <div>
              <strong className="font-semibold block mb-0.5">Medicine Dispensing Notice:</strong>
              Medicines shown are safe sample demonstration products. Durga Medical Hall dispenses prescription medicines strictly in accordance with applicable pharmacy laws and upon verification of a valid prescription from a registered medical practitioner.
            </div>
          </div>
        </div>
      </section>

      {/* 6. HOW IT WORKS */}
      <section className="py-16 max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 w-full">
        <div className="text-center max-w-2xl mx-auto mb-12">
          <span className="text-xs font-bold uppercase tracking-wider text-teal-700 block mb-1">
            Simple & Transparent
          </span>
          <h2 className="text-2xl sm:text-3xl font-extrabold text-slate-900">
            How Medicine Ordering Works
          </h2>
          <p className="text-sm text-slate-600 mt-2">
            Safe 5-step process ensuring medicine authenticity and professional pharmacist review.
          </p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-5 gap-4 relative">
          {[
            {
              step: '01',
              title: 'Search / Select Medicine',
              desc: 'Browse our catalogue or enter the medicine name and quantity.',
            },
            {
              step: '02',
              title: 'Submit Order / Prescription',
              desc: 'Submit your request or upload your doctor prescription slip.',
            },
            {
              step: '03',
              title: 'Pharmacy Verification',
              desc: 'Our qualified staff verifies stock, dosage and doctor authorization.',
            },
            {
              step: '04',
              title: 'Order Confirmation',
              desc: 'We confirm total cost and preparation time via phone or WhatsApp.',
            },
            {
              step: '05',
              title: 'Pickup / Delivery',
              desc: 'Pick up at our Kubri counter or receive local delivery if eligible.',
            },
          ].map((item, idx) => (
            <div
              key={item.step}
              className="bg-white rounded-2xl p-5 border border-slate-200 shadow-xs relative flex flex-col justify-between"
            >
              <div>
                <span className="text-3xl font-black text-teal-100 block mb-2 font-mono">
                  {item.step}
                </span>
                <h3 className="text-sm font-bold text-slate-900 mb-2">{item.title}</h3>
                <p className="text-xs text-slate-500 leading-relaxed">{item.desc}</p>
              </div>
              <div className="mt-4 pt-3 border-t border-slate-100 flex items-center text-[11px] font-semibold text-teal-700">
                <span>Step {idx + 1} of 5</span>
              </div>
            </div>
          ))}
        </div>
      </section>

      {/* 7. WHY CHOOSE DURGA MEDICAL HALL */}
      <section className="py-16 bg-slate-900 text-white">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center max-w-2xl mx-auto mb-12">
            <span className="text-xs font-bold uppercase tracking-wider text-teal-400 block mb-1">
              Why Customers Count On Us
            </span>
            <h2 className="text-2xl sm:text-3xl font-extrabold text-white">
              Why Choose Durga Medical Hall
            </h2>
            <p className="text-sm text-slate-400 mt-2">
              Dedicated to serving Village Kubri and neighboring panchayats with genuine care.
            </p>
          </div>

          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
            {[
              {
                title: 'Wide Range of Medicines',
                desc: 'Comprehensive inventory of essential therapeutic drugs, daily maintenance tablets, and acute health remedies.',
                icon: HeartPulse,
              },
              {
                title: 'Healthcare Products',
                desc: 'From blood pressure monitors and glucose strips to first-aid, infant care, and mother care essentials.',
                icon: ShieldCheck,
              },
              {
                title: 'Easy Medicine Enquiry',
                desc: 'Simple web form and instant WhatsApp connectivity to check medicine availability without traveling.',
                icon: HeartPulse,
              },
              {
                title: 'WhatsApp Support',
                desc: 'Send medicine pictures, prescription slips, or product questions directly to our phone via WhatsApp.',
                icon: MessageCircle,
              },
              {
                title: 'Local Customer Service',
                desc: 'Friendly, personalized neighborhood service from people who know and respect the Kubri community.',
                icon: HelpCircle,
              },
              {
                title: 'Convenient Location',
                desc: 'Easily accessible central medical store in Kubri, Makdiha Panchayat, saving trips to distant town centers.',
                icon: MapPin,
              },
            ].map((feature) => {
              const Icon = feature.icon;
              return (
                <div
                  key={feature.title}
                  className="bg-slate-800/80 p-6 rounded-2xl border border-slate-700/80 flex flex-col justify-between"
                >
                  <div>
                    <div className="w-12 h-12 rounded-xl bg-teal-500/10 text-teal-400 flex items-center justify-center mb-4 border border-teal-500/20">
                      <Icon className="w-6 h-6" />
                    </div>
                    <h3 className="text-base font-bold text-white mb-2">{feature.title}</h3>
                    <p className="text-xs text-slate-400 leading-relaxed">{feature.desc}</p>
                  </div>
                </div>
              );
            })}
          </div>
        </div>
      </section>

      {/* 8. ABOUT DURGA MEDICAL HALL */}
      <section className="py-16 max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 w-full">
        <div className="bg-white rounded-3xl p-8 sm:p-12 border border-slate-200 shadow-sm grid grid-cols-1 lg:grid-cols-12 gap-8 items-center">
          <div className="lg:col-span-8 space-y-4">
            <span className="text-xs font-bold uppercase tracking-wider text-teal-700">
              About Our Store
            </span>
            <h2 className="text-2xl sm:text-3xl font-extrabold text-slate-900">
              Serving the Healthcare Needs of Kubri & Giridih
            </h2>
            <p className="text-slate-600 text-sm sm:text-base leading-relaxed">
              Durga Medical Hall is a local medical store located in Village Kubri, District Giridih, Jharkhand. Our goal is to make medicines and healthcare products easily accessible to customers while providing convenient and customer-friendly service.
            </p>
            <p className="text-slate-600 text-sm leading-relaxed">
              Whether you need routine maintenance tablets, baby hygiene supplies, first-aid bandages, or need to verify a prescription with an attentive local pharmacist, Durga Medical Hall is here to assist your family.
            </p>

            <div className="pt-2 flex flex-wrap gap-4">
              <Link
                href="/about"
                className="px-5 py-2.5 rounded-xl bg-teal-700 hover:bg-teal-800 text-white font-semibold text-xs sm:text-sm shadow-xs transition-colors"
              >
                Read More About Us
              </Link>
              <Link
                href="/contact"
                className="px-5 py-2.5 rounded-xl border border-slate-300 text-slate-700 font-semibold text-xs sm:text-sm hover:bg-slate-50 transition-colors"
              >
                Store Directions
              </Link>
            </div>
          </div>

          <div className="lg:col-span-4 bg-teal-50 rounded-2xl p-6 border border-teal-100 space-y-4 text-xs text-teal-950">
            <div className="flex items-center gap-2 font-bold text-sm text-teal-900">
              <Building2 className="w-4 h-4 text-teal-700" />
              <span>Durga Medical Hall Address</span>
            </div>
            <address className="not-italic space-y-1 text-slate-700 leading-normal">
              <p className="font-semibold text-slate-900">Village – Kubri</p>
              <p>Post – Kubri</p>
              <p>Panchayat – Makdiha</p>
              <p>District – Giridih</p>
              <p>Jharkhand – 825418, India</p>
            </address>

            <div className="pt-3 border-t border-teal-200/80">
              <span className="block text-slate-500 font-medium mb-1">Standard Timings:</span>
              <span className="font-semibold text-slate-900">
                {settings.openingTime} – {settings.closingTime}
              </span>
            </div>

            <div className="pt-3 border-t border-teal-200/80">
              <span className="text-slate-500 block text-[11px] font-medium mb-0.5">Dispensing Supervision:</span>
              <span className="font-semibold text-teal-900 block text-xs">
                {CONTACT_CONFIG.pharmacistChemistTitle}
              </span>
            </div>
          </div>
        </div>
      </section>

      {/* 9. STORE LOCATION & MAP */}
      <section className="py-12 bg-slate-100 border-t border-slate-200">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center max-w-xl mx-auto mb-8">
            <span className="text-xs font-bold uppercase tracking-wider text-teal-700 block mb-1">
              Store Location
            </span>
            <h2 className="text-2xl font-bold text-slate-900">
              Find Durga Medical Hall
            </h2>
            <p className="text-xs text-slate-500 mt-1">
              Village Kubri, Post Kubri, Panchayat Makdiha, District Giridih, Jharkhand 825418
            </p>
          </div>

          <div className="bg-white rounded-3xl overflow-hidden border border-slate-200 shadow-md">
            {/* Map Frame / Placeholder */}
            <div className="w-full h-72 sm:h-96 bg-slate-200 relative flex flex-col items-center justify-center p-6 text-center">
              <div className="w-16 h-16 rounded-full bg-teal-100 text-teal-700 flex items-center justify-center mb-3 shadow-xs">
                <MapPin className="w-8 h-8" />
              </div>
              <h3 className="text-lg font-bold text-slate-900">Durga Medical Hall - Kubri</h3>
              <p className="text-xs text-slate-600 max-w-md mt-1">
                Village Kubri, Post Kubri, Panchayat Makdiha, District Giridih, Jharkhand – 825418
              </p>

              <div className="mt-4 flex flex-wrap items-center justify-center gap-3">
                <a
                  href={settings.googleMapsUrl}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="px-4 py-2 rounded-xl bg-teal-700 text-white font-semibold text-xs shadow-xs hover:bg-teal-800 transition-colors flex items-center gap-1.5"
                >
                  <MapPin className="w-4 h-4" />
                  <span>Open in Google Maps</span>
                </a>
                <Link
                  href="/contact"
                  className="px-4 py-2 rounded-xl bg-white border border-slate-300 text-slate-700 font-semibold text-xs hover:bg-slate-50 transition-colors"
                >
                  View Contact Details
                </Link>
              </div>

              <span className="absolute bottom-3 text-[10px] text-slate-400">
                Configurable Google Maps URL in Pharmacist/Admin Settings
              </span>
            </div>
          </div>
        </div>
      </section>

      {/* 10. CONTACT CTA SECTION */}
      <section className="py-16 bg-gradient-to-r from-teal-800 to-emerald-900 text-white">
        <div className="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8 text-center space-y-6">
          <span className="text-xs font-bold uppercase tracking-wider text-teal-200 bg-teal-700/50 px-3 py-1 rounded-full border border-teal-400/20">
            Need a Medicine?
          </span>
          <h2 className="text-3xl sm:text-4xl font-extrabold text-white">
            Contact Durga Medical Hall Today
          </h2>
          <p className="text-teal-100 max-w-xl mx-auto text-sm sm:text-base leading-relaxed">
            Have a prescription to verify or need to enquire about stock in Village Kubri? Reach out via WhatsApp or call our store directly.
          </p>

          <div className="flex flex-wrap items-center justify-center gap-4 pt-2">
            <a
              href={getWhatsAppLink()}
              target="_blank"
              rel="noopener noreferrer"
              aria-label="WhatsApp Us at Durga Medical Hall"
              className="px-6 py-3.5 rounded-xl bg-emerald-500 hover:bg-emerald-400 text-emerald-950 font-bold text-sm shadow-lg transition-transform hover:scale-105 flex items-center gap-2"
            >
              <MessageCircle className="w-5 h-5" />
              <span>WhatsApp Us</span>
            </a>

            <a
              href={getPhoneLink()}
              aria-label={`Call Now at ${CONTACT_CONFIG.displayPhone}`}
              className="px-6 py-3.5 rounded-xl bg-white hover:bg-teal-50 text-teal-900 font-bold text-sm shadow-lg transition-transform hover:scale-105 flex items-center gap-2"
            >
              <Phone className="w-5 h-5 text-teal-700" />
              <span>Call Now: {CONTACT_CONFIG.displayPhone}</span>
            </a>

            <Link
              href="/order-medicine"
              className="px-6 py-3.5 rounded-xl bg-teal-950/60 hover:bg-teal-950 border border-teal-400/30 text-white font-semibold text-sm transition-colors flex items-center gap-2"
            >
              <ShoppingBag className="w-5 h-5" />
              <span>Submit Web Request</span>
            </Link>
          </div>
        </div>
      </section>
    </div>
  );
}
