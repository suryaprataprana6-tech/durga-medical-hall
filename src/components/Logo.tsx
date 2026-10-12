'use client';

import React from 'react';
import Link from 'next/link';

interface LogoProps {
  size?: 'sm' | 'md' | 'lg';
  showSubtitle?: boolean;
  className?: string;
  light?: boolean;
}

export default function Logo({
  size = 'md',
  showSubtitle = true,
  className = '',
  light = false,
}: LogoProps) {
  const iconSize = size === 'sm' ? 32 : size === 'lg' ? 48 : 40;
  const titleClass =
    size === 'sm'
      ? 'text-lg font-bold'
      : size === 'lg'
      ? 'text-2xl font-extrabold'
      : 'text-xl font-bold';

  return (
    <Link href="/" className={`inline-flex items-center gap-3 group focus-ring rounded-lg ${className}`}>
      {/* Professional Medical Cross + Pill Emblem */}
      <div
        className="relative flex items-center justify-center rounded-xl bg-gradient-to-br from-teal-600 to-emerald-700 text-white shadow-md shadow-teal-700/20 group-hover:scale-105 transition-transform"
        style={{ width: iconSize, height: iconSize }}
      >
        <svg
          viewBox="0 0 40 40"
          className="w-4/5 h-4/5 text-white"
          fill="none"
          xmlns="http://www.w3.org/2000/svg"
        >
          {/* Medical Cross Base */}
          <rect x="16" y="6" width="8" height="28" rx="2" fill="white" opacity="0.95" />
          <rect x="6" y="16" width="28" height="8" rx="2" fill="white" opacity="0.95" />

          {/* Capsule / Healthcare Motif Accent in Center */}
          <circle cx="20" cy="20" r="4.5" fill="#0d9488" />
          <path
            d="M18 19L22 21"
            stroke="white"
            strokeWidth="1.5"
            strokeLinecap="round"
          />
        </svg>
      </div>

      <div className="flex flex-col leading-tight">
        <span
          className={`tracking-tight uppercase font-sans ${titleClass} ${
            light ? 'text-white' : 'text-slate-900 group-hover:text-teal-700'
          }`}
        >
          Durga Medical Hall
        </span>
        {showSubtitle && (
          <span
            className={`text-[10px] tracking-widest uppercase font-semibold ${
              light ? 'text-teal-200' : 'text-teal-700'
            }`}
          >
            Village Kubri • Giridih
          </span>
        )}
      </div>
    </Link>
  );
}
