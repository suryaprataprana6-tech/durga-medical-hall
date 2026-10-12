'use client';

import React from 'react';
import Link from 'next/link';
import Logo from './Logo';
import {
  MapPin,
  Phone,
  MessageCircle,
  Clock,
  ShieldCheck,
  AlertCircle,
  ExternalLink,
} from 'lucide-react';
import { useShopSettings } from '@/lib/store';
import { CONTACT_CONFIG } from '@/lib/contact';
import ContactButtons from './ContactButtons';

export default function Footer() {
  const settings = useShopSettings();

  return (
    <footer className="bg-slate-950 text-slate-300 border-t border-slate-800">
      {/* Upper Pre-footer Compliance / Safety Notice */}
      <div className="bg-slate-900 border-b border-slate-800/80 py-4 px-4 sm:px-6">
        <div className="max-w-7xl mx-auto flex flex-col md:flex-row items-center justify-between gap-3 text-xs text-slate-400">
          <div className="flex items-center gap-2 text-amber-400">
            <AlertCircle className="w-4 h-4 shrink-0" />
            <span className="font-medium">
              Medical Disclaimer: Information on this website is for product catalogue and identification only. Consult a registered medical practitioner before taking any medicine.
            </span>
          </div>
          <div className="flex items-center gap-1.5 text-teal-400 shrink-0">
            <ShieldCheck className="w-4 h-4" />
            <span>Prescription Drugs Verified by Qualified Pharmacist</span>
          </div>
        </div>
      </div>

      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12 lg:py-16">
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-10">
          {/* Col 1: Brand & Physical Shop Address */}
          <div className="space-y-4">
            <Logo size="md" light={true} />
            <p className="text-sm text-slate-400 leading-relaxed">
              Your dependable neighborhood medical store in Village Kubri, Giridih. Providing accessible genuine medicines, healthcare essentials, and customer-first guidance.
            </p>

            <div className="pt-2 border-t border-slate-800 text-xs space-y-2 text-slate-400">
              <div className="flex items-start gap-2">
                <MapPin className="w-4 h-4 text-teal-400 shrink-0 mt-0.5" />
                <address className="not-italic">
                  <strong className="text-slate-200">Durga Medical Hall</strong>
                  <br />
                  Village – Kubri, Post – Kubri
                  <br />
                  Panchayat – Makdiha, District – Giridih
                  <br />
                  Jharkhand – 825418, India
                </address>
              </div>

              <div className="flex items-center gap-2 pt-1 text-slate-400">
                <Clock className="w-4 h-4 text-teal-400 shrink-0" />
                <span>
                  Hours: {settings.openingTime} – {settings.closingTime}
                </span>
              </div>
            </div>
          </div>

          {/* Col 2: Quick Links */}
          <div>
            <h3 className="text-sm font-semibold uppercase tracking-wider text-white mb-4">
              Explore Store
            </h3>
            <ul className="space-y-2.5 text-sm">
              <li>
                <Link href="/" className="hover:text-teal-400 transition-colors">
                  Home
                </Link>
              </li>
              <li>
                <Link href="/medicines" className="hover:text-teal-400 transition-colors">
                  Medicine Catalogue
                </Link>
              </li>
              <li>
                <Link href="/order-medicine" className="hover:text-teal-400 transition-colors">
                  Order Medicine
                </Link>
              </li>
              <li>
                <Link href="/upload-prescription" className="hover:text-teal-400 transition-colors">
                  Upload Prescription
                </Link>
              </li>
              <li>
                <Link href="/about" className="hover:text-teal-400 transition-colors">
                  About Durga Medical Hall
                </Link>
              </li>
              <li>
                <Link href="/contact" className="hover:text-teal-400 transition-colors">
                  Contact & Store Location
                </Link>
              </li>
            </ul>
          </div>

          {/* Col 3: Regulatory & Legal Policies */}
          <div>
            <h3 className="text-sm font-semibold uppercase tracking-wider text-white mb-4">
              Policies & Legal
            </h3>
            <ul className="space-y-2.5 text-sm">
              <li>
                <Link href="/privacy-policy" className="hover:text-teal-400 transition-colors">
                  Privacy Policy
                </Link>
              </li>
              <li>
                <Link href="/terms" className="hover:text-teal-400 transition-colors">
                  Terms & Conditions
                </Link>
              </li>
              <li>
                <Link href="/refund-policy" className="hover:text-teal-400 transition-colors">
                  Refund & Cancellation Policy
                </Link>
              </li>
              <li>
                <Link href="/shipping-policy" className="hover:text-teal-400 transition-colors">
                  Delivery & Shipping Policy
                </Link>
              </li>
              <li>
                <Link href="/disclaimer" className="hover:text-teal-400 transition-colors">
                  Medical Disclaimer
                </Link>
              </li>
              <li>
                <Link href="/admin" className="text-teal-400 hover:text-teal-300 transition-colors flex items-center gap-1">
                  Pharmacist / Admin Access
                  <ExternalLink className="w-3 h-3" />
                </Link>
              </li>
            </ul>
          </div>

          {/* Col 4: Contact & Pharmacist/Chemist Details */}
          <div>
            <h3 className="text-sm font-semibold uppercase tracking-wider text-white mb-4">
              Connect With Us
            </h3>
            <div className="space-y-3 text-sm">
              <div className="flex items-center gap-2.5">
                <Phone className="w-4 h-4 text-teal-400 shrink-0" />
                <span className="text-slate-300">
                  Call:{' '}
                  <a
                    href={CONTACT_CONFIG.phoneHref}
                    className="text-teal-300 hover:text-white hover:underline font-mono text-xs transition-colors"
                  >
                    {CONTACT_CONFIG.displayPhone}
                  </a>
                </span>
              </div>

              <div className="flex items-center gap-2.5">
                <MessageCircle className="w-4 h-4 text-emerald-400 shrink-0" />
                <span className="text-slate-300">
                  WhatsApp:{' '}
                  <a
                    href={CONTACT_CONFIG.whatsAppHref}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="text-emerald-300 hover:text-white hover:underline font-mono text-xs transition-colors"
                  >
                    {CONTACT_CONFIG.displayWhatsApp}
                  </a>
                </span>
              </div>

              <div className="pt-2">
                <ContactButtons size="sm" />
              </div>

              <div className="pt-3 border-t border-slate-800">
                <span className="text-xs font-semibold text-teal-300 block mb-1">
                  {CONTACT_CONFIG.pharmacistChemistTitle}
                </span>
                <span className="text-xs text-slate-400 block mb-1">
                  Drug License / GST:
                </span>
                <span className="text-xs font-mono text-slate-400 block">
                  {settings.drugLicenseNumber}
                </span>
                <span className="text-xs font-mono text-slate-400 block">
                  GST: {settings.gstNumber}
                </span>
              </div>
            </div>
          </div>
        </div>

        {/* Bottom copyright line */}
        <div className="mt-12 pt-8 border-t border-slate-800 text-xs text-slate-500 flex flex-col sm:flex-row justify-between items-center gap-4">
          <p>
            © 2026 Durga Medical Hall. Village Kubri, Makdiha, Giridih, Jharkhand – 825418. All rights reserved.
          </p>
          <div className="flex items-center gap-4">
            <Link href="/privacy-policy" className="hover:text-slate-400">
              Privacy
            </Link>
            <span>•</span>
            <Link href="/terms" className="hover:text-slate-400">
              Terms
            </Link>
            <span>•</span>
            <Link href="/disclaimer" className="hover:text-slate-400">
              Medical Disclaimer
            </Link>
          </div>
        </div>
      </div>
    </footer>
  );
}
