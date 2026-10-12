'use client';

import React from 'react';
import Link from 'next/link';
import { Phone, MessageCircle, ShoppingBag, FileUp } from 'lucide-react';
import { CONTACT_CONFIG, getWhatsAppUrl } from '@/lib/contact';

export default function MobileQuickBar() {
  const whatsAppHref = getWhatsAppUrl();

  return (
    <nav
      aria-label="Mobile quick actions"
      className="fixed bottom-0 left-0 right-0 z-40 bg-white/98 backdrop-blur-md border-t border-slate-200/90 shadow-2xl p-2 sm:hidden print:hidden"
    >
      <div className="grid grid-cols-4 gap-1.5 max-w-md mx-auto">
        {/* Call Now */}
        <a
          href={CONTACT_CONFIG.phoneHref}
          aria-label={`Call Durga Medical Hall at ${CONTACT_CONFIG.displayPhone}`}
          className="flex flex-col items-center justify-center py-2 px-1 rounded-xl bg-teal-50/80 border border-teal-200 text-teal-900 active:bg-teal-100 focus-visible:outline-hidden focus-visible:ring-2 focus-visible:ring-teal-600 text-[10.5px] font-semibold transition-colors"
        >
          <Phone className="w-4 h-4 text-teal-700 mb-0.5" />
          <span>Call Now</span>
        </a>

        {/* WhatsApp Us */}
        <a
          href={whatsAppHref}
          target="_blank"
          rel="noopener noreferrer"
          aria-label="WhatsApp Us at Durga Medical Hall"
          className="flex flex-col items-center justify-center py-2 px-1 rounded-xl bg-emerald-50 border border-emerald-200 text-emerald-900 active:bg-emerald-100 focus-visible:outline-hidden focus-visible:ring-2 focus-visible:ring-emerald-600 text-[10.5px] font-semibold transition-colors"
        >
          <MessageCircle className="w-4 h-4 text-emerald-600 fill-emerald-600/20 mb-0.5" />
          <span>WhatsApp Us</span>
        </a>

        {/* Send Rx */}
        <Link
          href="/upload-prescription"
          aria-label="Upload prescription slip"
          className="flex flex-col items-center justify-center py-2 px-1 rounded-xl bg-slate-50 border border-slate-200 text-slate-800 active:bg-slate-200 focus-visible:outline-hidden focus-visible:ring-2 focus-visible:ring-slate-600 text-[10.5px] font-semibold transition-colors"
        >
          <FileUp className="w-4 h-4 text-blue-700 mb-0.5" />
          <span>Send Rx</span>
        </Link>

        {/* Order */}
        <Link
          href="/order-medicine"
          aria-label="Order medicines online"
          className="flex flex-col items-center justify-center py-2 px-1 rounded-xl bg-teal-700 text-white shadow-xs active:bg-teal-800 focus-visible:outline-hidden focus-visible:ring-2 focus-visible:ring-teal-700 text-[10.5px] font-semibold transition-colors"
        >
          <ShoppingBag className="w-4 h-4 text-white mb-0.5" />
          <span>Order</span>
        </Link>
      </div>
    </nav>
  );
}
