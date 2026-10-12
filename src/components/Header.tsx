'use client';

import React, { useState } from 'react';
import Link from 'next/link';
import { usePathname } from 'next/navigation';
import Logo from './Logo';
import {
  Phone,
  MessageCircle,
  Menu,
  X,
  FileUp,
  ShoppingBag,
  MapPin,
  Clock,
  ShieldCheck,
} from 'lucide-react';
import { useShopSettings } from '@/lib/store';
import { CONTACT_CONFIG, getWhatsAppUrl } from '@/lib/contact';
import ContactButtons from './ContactButtons';

export default function Header() {
  const pathname = usePathname();
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);
  const settings = useShopSettings();

  const navLinks = [
    { name: 'Home', href: '/' },
    { name: 'Medicines', href: '/medicines' },
    { name: 'Order Medicine', href: '/order-medicine' },
    { name: 'Upload Prescription', href: '/upload-prescription' },
    { name: 'About Us', href: '/about' },
    { name: 'Contact', href: '/contact' },
  ];

  const getWhatsAppLink = (text?: string) => {
    return getWhatsAppUrl(text);
  };

  const isCurrent = (href: string) => {
    if (href === '/') return pathname === '/';
    return pathname.startsWith(href);
  };

  return (
    <>
      {/* Top Notification / Community Announcement Bar */}
      <div className="bg-slate-900 text-slate-200 text-xs py-2 px-4 border-b border-slate-800">
        <div className="max-w-7xl mx-auto flex flex-col sm:flex-row justify-between items-center gap-2">
          <div className="flex items-center gap-4 flex-wrap text-center sm:text-left">
            <span className="flex items-center gap-1.5 text-teal-400 font-medium">
              <MapPin className="w-3.5 h-3.5 text-teal-400" />
              Village Kubri, Post Kubri, Makdiha, Giridih 825418
            </span>
            <span className="hidden md:flex items-center gap-1.5 text-slate-300">
              <Clock className="w-3.5 h-3.5 text-slate-400" />
              Store Timings: {settings.openingTime} – {settings.closingTime}
            </span>
          </div>

          <div className="flex items-center gap-3 text-slate-300">
            <a
              href={CONTACT_CONFIG.phoneHref}
              className="hidden sm:flex items-center gap-1.5 text-xs text-teal-300 hover:text-white transition-colors"
            >
              <Phone className="w-3.5 h-3.5 text-teal-400" />
              <span>{CONTACT_CONFIG.displayPhone}</span>
            </a>
            <span className="flex items-center gap-1 text-[11px] bg-slate-800/80 px-2 py-0.5 rounded text-teal-300 border border-teal-500/20">
              <ShieldCheck className="w-3.5 h-3.5 text-teal-400" />
              Verified Local Medical Store
            </span>
            <Link
              href="/admin"
              className="text-slate-400 hover:text-white text-[11px] underline ml-2 transition-colors"
            >
              Pharmacist Portal
            </Link>
          </div>
        </div>
      </div>

      {/* Main Sticky Navigation Bar */}
      <header className="sticky top-0 z-40 bg-white/95 backdrop-blur-md border-b border-slate-200 shadow-xs">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex items-center justify-between h-20">
            {/* Logo */}
            <div className="shrink-0">
              <Logo size="md" />
            </div>

            {/* Desktop Navigation Links */}
            <nav className="hidden lg:flex items-center gap-1 xl:gap-2">
              {navLinks.map((item) => {
                const active = isCurrent(item.href);
                return (
                  <Link
                    key={item.name}
                    href={item.href}
                    className={`px-3 py-2 rounded-lg text-sm font-medium transition-all ${
                      active
                        ? 'bg-teal-50 text-teal-800 font-semibold border border-teal-200/60 shadow-xs'
                        : 'text-slate-700 hover:text-teal-700 hover:bg-slate-50'
                    }`}
                  >
                    {item.name}
                  </Link>
                );
              })}
            </nav>

            {/* Right Action CTAs */}
            <div className="hidden md:flex items-center gap-3">
              <ContactButtons size="md" phoneLabel="Call Now" whatsAppLabel="WhatsApp Us" />
            </div>

            {/* Mobile Actions: Call + WhatsApp + Hamburger */}
            <div className="flex items-center gap-1.5 lg:hidden">
              <a
                href={CONTACT_CONFIG.phoneHref}
                className="p-2 rounded-lg text-teal-700 bg-teal-50 border border-teal-200 hover:bg-teal-100 transition-colors"
                aria-label={`Call Durga Medical Hall at ${CONTACT_CONFIG.displayPhone}`}
              >
                <Phone className="w-4 h-4" />
              </a>

              <a
                href={getWhatsAppLink()}
                target="_blank"
                rel="noopener noreferrer"
                className="p-2 rounded-lg text-emerald-700 bg-emerald-50 border border-emerald-200 hover:bg-emerald-100 transition-colors"
                aria-label="WhatsApp Us at Durga Medical Hall"
              >
                <MessageCircle className="w-4 h-4 fill-emerald-600/20" />
              </a>

              <button
                type="button"
                onClick={() => setMobileMenuOpen(!mobileMenuOpen)}
                className="p-2 rounded-lg text-slate-700 hover:bg-slate-100 focus-ring"
                aria-label="Toggle navigation menu"
              >
                {mobileMenuOpen ? <X className="w-6 h-6" /> : <Menu className="w-6 h-6" />}
              </button>
            </div>
          </div>
        </div>

        {/* Mobile Navigation Drawer */}
        {mobileMenuOpen && (
          <div className="lg:hidden bg-white border-b border-slate-200 px-4 pt-3 pb-6 shadow-xl animate-in slide-in-from-top duration-200">
            <div className="flex flex-col space-y-1">
              {navLinks.map((item) => {
                const active = isCurrent(item.href);
                return (
                  <Link
                    key={item.name}
                    href={item.href}
                    onClick={() => setMobileMenuOpen(false)}
                    className={`px-4 py-3 rounded-xl text-base font-medium flex items-center justify-between ${
                      active
                        ? 'bg-teal-50 text-teal-800 font-semibold border border-teal-200'
                        : 'text-slate-700 hover:bg-slate-50'
                    }`}
                  >
                    <span>{item.name}</span>
                  </Link>
                );
              })}
            </div>

            <div className="mt-5 pt-4 border-t border-slate-100 flex flex-col gap-2.5">
              <Link
                href="/order-medicine"
                onClick={() => setMobileMenuOpen(false)}
                className="w-full flex items-center justify-center gap-2 py-3 rounded-xl bg-teal-700 text-white font-medium shadow-md text-sm"
              >
                <ShoppingBag className="w-4 h-4" />
                <span>Order Medicine Now</span>
              </Link>
              <Link
                href="/upload-prescription"
                onClick={() => setMobileMenuOpen(false)}
                className="w-full flex items-center justify-center gap-2 py-3 rounded-xl bg-slate-100 text-slate-800 font-medium text-sm hover:bg-slate-200"
              >
                <FileUp className="w-4 h-4 text-teal-700" />
                <span>Upload Prescription Slip</span>
              </Link>
              <div className="grid grid-cols-2 gap-2 mt-2">
                <a
                  href={CONTACT_CONFIG.phoneHref}
                  className="flex items-center justify-center gap-1.5 py-2.5 rounded-lg bg-teal-700 text-white text-xs font-semibold hover:bg-teal-800 transition-colors"
                >
                  <Phone className="w-3.5 h-3.5" />
                  Call Now
                </a>
                <a
                  href={CONTACT_CONFIG.whatsAppHref}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="flex items-center justify-center gap-1.5 py-2.5 rounded-lg bg-emerald-600 text-white text-xs font-semibold hover:bg-emerald-700 transition-colors"
                >
                  <MessageCircle className="w-3.5 h-3.5" />
                  WhatsApp Us
                </a>
              </div>
            </div>
          </div>
        )}
      </header>
    </>
  );
}
