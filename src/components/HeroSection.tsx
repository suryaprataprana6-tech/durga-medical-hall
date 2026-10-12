'use client';

import React from 'react';
import Link from 'next/link';
import dynamic from 'next/dynamic';
import {
  MapPin,
  Pill,
  LayoutGrid,
  FileUp,
  ShieldCheck,
  CheckCircle2,
  Sparkles,
  ArrowRight,
  Clock,
  MessageCircle,
} from 'lucide-react';
import SearchAutocomplete from '@/components/SearchAutocomplete';
import { useShopSettings } from '@/lib/store';
import { getWhatsAppUrl } from '@/lib/contact';

// Dynamically import the 3D Canvas component to prevent SSR errors
const Hero3DCanvas = dynamic(() => import('@/components/Hero3DCanvas'), {
  ssr: false,
  loading: () => (
    <div className="w-full h-full min-h-[380px] sm:min-h-[460px] lg:min-h-[520px] flex items-center justify-center">
      <div className="relative flex flex-col items-center justify-center gap-3">
        <div className="w-16 h-16 rounded-full border-2 border-emerald-200 border-t-emerald-600 animate-spin" />
        <span className="text-xs font-semibold text-emerald-800 tracking-wide uppercase">
          Loading 3D Scene...
        </span>
      </div>
    </div>
  ),
});

export default function HeroSection() {
  const settings = useShopSettings();

  const getWhatsAppLink = (customText?: string) => {
    return getWhatsAppUrl(
      customText ||
        'Hello Durga Medical Hall, I would like to enquire about medicines at your Kubri store.',
      settings.whatsapp
    );
  };

  return (
    <section className="relative overflow-hidden bg-gradient-to-b from-[#f6fcf8] via-[#eef9f2] to-white border-b border-emerald-100/60 pt-8 pb-16 sm:py-20 lg:py-24">
      {/* Background radial glow & subtle organic aura */}
      <div className="absolute inset-0 bg-[radial-gradient(circle_at_70%_20%,rgba(16,185,129,0.12),transparent_50%)] pointer-events-none" />
      <div className="absolute -top-32 -left-32 w-96 h-96 bg-teal-200/25 rounded-full blur-3xl pointer-events-none" />
      <div className="absolute top-1/2 right-0 w-[500px] h-[500px] bg-emerald-100/40 rounded-full blur-3xl pointer-events-none" />

      {/* Subtle fine grid texture for architectural clinical feel */}
      <div className="absolute inset-0 opacity-[0.035] bg-[radial-gradient(#059669_1px,transparent_1px)] [background-size:20px_20px] pointer-events-none" />

      <div className="relative max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="grid grid-cols-1 lg:grid-cols-12 gap-10 lg:gap-8 items-center">
          
          {/* ================= LEFT CONTENT ================= */}
          <div className="lg:col-span-6 space-y-6 text-center lg:text-left z-10">
            
            {/* 1. Location badge: Serving Kubri, Giridih, Jharkhand */}
            <div className="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-emerald-50/90 border border-emerald-200 text-emerald-900 text-xs sm:text-sm font-semibold shadow-xs backdrop-blur-xs">
              <span className="relative flex h-2 w-2">
                <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-emerald-400 opacity-75" />
                <span className="relative inline-flex rounded-full h-2 w-2 bg-emerald-600" />
              </span>
              <MapPin className="w-3.5 h-3.5 text-emerald-700" />
              <span>Serving Kubri, Giridih, Jharkhand</span>
            </div>

            {/* 2. Main Headline */}
            <div className="space-y-2">
              <h1 className="text-3xl sm:text-5xl lg:text-[54px] font-black tracking-tight text-emerald-950 leading-[1.12]">
                Your Everyday Healthcare,{' '}
                <span className="bg-gradient-to-r from-emerald-600 via-teal-600 to-emerald-700 bg-clip-text text-transparent">
                  Made Simple.
                </span>
              </h1>
            </div>

            {/* 3. Supporting Text */}
            <p className="text-base sm:text-lg text-slate-600 lg:text-emerald-950/80 font-normal max-w-xl mx-auto lg:mx-0 leading-relaxed">
              Explore medicines, healthcare essentials and everyday wellness products at Durga Medical Hall.
            </p>

            {/* 4. Action Buttons (Primary CTA & Secondary CTA) */}
            <div className="flex flex-wrap items-center justify-center lg:justify-start gap-3 sm:gap-4 pt-1">
              <Link
                href="/medicines"
                className="px-6 py-3.5 rounded-2xl bg-gradient-to-r from-emerald-700 via-teal-700 to-emerald-800 hover:from-emerald-800 hover:to-teal-900 text-white font-bold text-sm sm:text-base shadow-lg shadow-emerald-900/15 hover:shadow-emerald-900/25 transition-all hover:-translate-y-0.5 flex items-center gap-2 group"
              >
                <Pill className="w-4 h-4 text-emerald-300 group-hover:rotate-45 transition-transform" />
                <span>Explore Medicines</span>
                <ArrowRight className="w-4 h-4 group-hover:translate-x-0.5 transition-transform" />
              </Link>

              <a
                href="#categories"
                className="px-5 py-3.5 rounded-2xl bg-white hover:bg-emerald-50/80 text-emerald-900 font-bold text-sm sm:text-base border border-emerald-200/90 shadow-xs hover:border-emerald-300 transition-all hover:-translate-y-0.5 flex items-center gap-2"
              >
                <LayoutGrid className="w-4 h-4 text-emerald-700" />
                <span>Browse Categories</span>
              </a>

              <a
                href={getWhatsAppLink()}
                target="_blank"
                rel="noopener noreferrer"
                className="px-4 py-3.5 rounded-2xl bg-emerald-100/70 hover:bg-emerald-200/70 text-emerald-900 font-semibold text-sm transition-all flex items-center gap-1.5"
                title="Direct enquiry on WhatsApp"
              >
                <MessageCircle className="w-4 h-4 text-emerald-700" />
                <span>WhatsApp</span>
              </a>
            </div>

            {/* 5. Integrated Instant Search Input */}
            <div className="pt-2 max-w-xl mx-auto lg:mx-0">
              <div className="flex items-center justify-between pb-1.5 px-1">
                <span className="text-[11px] font-bold uppercase tracking-wider text-emerald-800">
                  Instant Medicine Search
                </span>
                <span className="text-[10px] text-slate-500">
                  Check Kubri Counter Stock
                </span>
              </div>
              <div className="bg-white/95 rounded-2xl p-1.5 shadow-md shadow-emerald-950/5 border border-emerald-100">
                <SearchAutocomplete placeholder="Search medicine, salt, brand or healthcare item..." />
              </div>
            </div>

            {/* 6. Prescription Slip Quick Assist Card */}
            <div className="max-w-xl mx-auto lg:mx-0 p-3.5 rounded-2xl bg-gradient-to-r from-white/90 via-emerald-50/50 to-white/90 border border-emerald-200/70 shadow-xs flex flex-col sm:flex-row sm:items-center justify-between gap-3 text-left">
              <div className="flex items-center gap-3">
                <div className="w-10 h-10 rounded-xl bg-emerald-700 text-white flex items-center justify-center shrink-0 shadow-xs">
                  <FileUp className="w-5 h-5" />
                </div>
                <div>
                  <h4 className="text-xs sm:text-sm font-bold text-emerald-950">
                    Have a Doctor&apos;s Prescription?
                  </h4>
                  <p className="text-[11px] text-slate-500">
                    Upload slip online or bring to our Kubri counter for pharmacist review.
                  </p>
                </div>
              </div>
              <Link
                href="/upload-prescription"
                className="px-3.5 py-2 rounded-xl bg-emerald-800 hover:bg-emerald-900 text-white text-xs font-bold shrink-0 text-center shadow-xs transition-colors flex items-center justify-center gap-1"
              >
                <span>Upload Slip</span>
                <ArrowRight className="w-3.5 h-3.5" />
              </Link>
            </div>

            {/* 7. Clinical Trust Badges */}
            <div className="pt-2 border-t border-emerald-200/60 grid grid-cols-2 sm:grid-cols-3 gap-2 text-xs font-medium text-emerald-950/80">
              <span className="flex items-center gap-1.5">
                <CheckCircle2 className="w-4 h-4 text-emerald-600 shrink-0" />
                100% Authentic Stock
              </span>
              <span className="flex items-center gap-1.5">
                <ShieldCheck className="w-4 h-4 text-emerald-600 shrink-0" />
                Pharmacist Verified
              </span>
              <span className="flex items-center gap-1.5 col-span-2 sm:col-span-1">
                <Sparkles className="w-4 h-4 text-emerald-600 shrink-0" />
                Village Counter Pickup
              </span>
            </div>

          </div>

          {/* ================= RIGHT 3D SCENE ================= */}
          <div className="lg:col-span-6 relative flex items-center justify-center">
            
            {/* Ambient soft glow backdrop behind 3D composition */}
            <div className="absolute w-72 h-72 sm:w-96 sm:h-96 rounded-full bg-gradient-to-tr from-emerald-200/50 via-teal-100/40 to-emerald-300/30 blur-2xl pointer-events-none" />

            {/* The 3D Canvas Composition */}
            <div className="relative w-full aspect-square max-w-[540px] flex items-center justify-center">
              <Hero3DCanvas />

              {/* Floating Glassmorphic Micro-Card 1: Top Right */}
              <div className="absolute top-2 right-2 sm:top-6 sm:right-4 z-20 pointer-events-none select-none">
                <div className="flex items-center gap-2 px-3.5 py-2 rounded-2xl bg-white/85 border border-emerald-100/80 shadow-lg shadow-emerald-950/5 backdrop-blur-md">
                  <div className="w-6 h-6 rounded-lg bg-emerald-100 text-emerald-700 flex items-center justify-center">
                    <ShieldCheck className="w-3.5 h-3.5" />
                  </div>
                  <div className="text-left">
                    <span className="text-[10px] uppercase tracking-wider font-bold text-emerald-700 block leading-tight">
                      Verified Pharmacy
                    </span>
                    <span className="text-xs font-bold text-slate-800 block">
                      Kubri, Giridih
                    </span>
                  </div>
                </div>
              </div>

              {/* Floating Glassmorphic Micro-Card 2: Bottom Left */}
              <div className="absolute bottom-4 left-2 sm:bottom-6 sm:left-4 z-20 select-none">
                <Link
                  href="/medicines"
                  className="flex items-center gap-2.5 px-3.5 py-2.5 rounded-2xl bg-white/90 border border-emerald-100/80 shadow-lg shadow-emerald-950/5 backdrop-blur-md hover:border-emerald-300 hover:bg-white transition-all group pointer-events-auto"
                >
                  <div className="w-7 h-7 rounded-xl bg-gradient-to-tr from-emerald-600 to-teal-500 text-white flex items-center justify-center shadow-xs">
                    <Pill className="w-4 h-4 group-hover:rotate-45 transition-transform" />
                  </div>
                  <div className="text-left">
                    <span className="text-xs font-extrabold text-slate-900 block group-hover:text-emerald-700 transition-colors">
                      28 Health Categories
                    </span>
                    <span className="text-[11px] font-medium text-slate-500 block">
                      190+ Verified Medicines
                    </span>
                  </div>
                  <ArrowRight className="w-3.5 h-3.5 text-slate-400 group-hover:text-emerald-700 group-hover:translate-x-0.5 transition-all ml-1" />
                </Link>
              </div>

              {/* Floating Micro-Card 3: Bottom Right (Store Hours) */}
              <div className="hidden sm:flex absolute bottom-4 right-2 sm:bottom-6 sm:right-4 z-20 pointer-events-none select-none items-center gap-2 px-3 py-1.5 rounded-xl bg-white/80 border border-slate-100 text-slate-600 text-[11px] font-medium shadow-xs backdrop-blur-xs">
                <Clock className="w-3.5 h-3.5 text-emerald-600" />
                <span>Open: 8:00 AM – 9:00 PM</span>
              </div>

            </div>

          </div>

        </div>
      </div>
    </section>
  );
}
