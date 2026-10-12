'use client';

import React from 'react';
import { Phone, MessageCircle } from 'lucide-react';
import { CONTACT_CONFIG, getWhatsAppUrl } from '@/lib/contact';

interface ContactButtonsProps {
  className?: string;
  size?: 'sm' | 'md' | 'lg';
  customWhatsAppMessage?: string;
  showPhoneText?: boolean;
  phoneLabel?: string;
  whatsAppLabel?: string;
}

export default function ContactButtons({
  className = '',
  size = 'md',
  customWhatsAppMessage,
  showPhoneText = true,
  phoneLabel = 'Call Now',
  whatsAppLabel = 'WhatsApp Us',
}: ContactButtonsProps) {
  const whatsAppHref = getWhatsAppUrl(customWhatsAppMessage);

  const sizeClasses = {
    sm: {
      btn: 'px-3 py-1.5 text-xs rounded-lg gap-1.5',
      icon: 'w-3.5 h-3.5',
    },
    md: {
      btn: 'px-3.5 py-2 text-xs font-semibold rounded-lg gap-2',
      icon: 'w-4 h-4',
    },
    lg: {
      btn: 'px-5 py-3 text-sm font-bold rounded-xl gap-2.5',
      icon: 'w-5 h-5',
    },
  }[size];

  return (
    <div className={`inline-flex items-center gap-2.5 ${className}`}>
      {/* WhatsApp Us Button */}
      <a
        href={whatsAppHref}
        target="_blank"
        rel="noopener noreferrer"
        aria-label={`WhatsApp Durga Medical Hall at ${CONTACT_CONFIG.displayPhone}`}
        className={`inline-flex items-center justify-center font-semibold bg-emerald-600 hover:bg-emerald-700 active:bg-emerald-800 text-white shadow-xs transition-colors focus-visible:outline-hidden focus-visible:ring-2 focus-visible:ring-emerald-500 focus-visible:ring-offset-2 ${sizeClasses.btn}`}
      >
        <MessageCircle className={`${sizeClasses.icon} shrink-0`} />
        <span>{whatsAppLabel}</span>
      </a>

      {/* Call Now Button */}
      <a
        href={CONTACT_CONFIG.phoneHref}
        aria-label={`Call Durga Medical Hall at ${CONTACT_CONFIG.displayPhone}`}
        className={`inline-flex items-center justify-center font-semibold bg-teal-700 hover:bg-teal-800 active:bg-teal-900 text-white shadow-xs transition-colors focus-visible:outline-hidden focus-visible:ring-2 focus-visible:ring-teal-500 focus-visible:ring-offset-2 ${sizeClasses.btn}`}
      >
        <Phone className={`${sizeClasses.icon} shrink-0`} />
        <span>
          {phoneLabel}
          {showPhoneText && size === 'lg' ? `: ${CONTACT_CONFIG.displayPhone}` : ''}
        </span>
      </a>
    </div>
  );
}
