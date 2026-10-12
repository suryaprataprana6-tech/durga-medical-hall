import React from 'react';
import Link from 'next/link';
import { Home, Pill, Phone, AlertCircle } from 'lucide-react';

export default function NotFound() {
  return (
    <div className="min-h-screen bg-slate-50 flex items-center justify-center p-4">
      <div className="bg-white rounded-3xl p-8 sm:p-12 border border-slate-200 text-center max-w-lg shadow-sm space-y-6">
        <div className="w-20 h-20 rounded-3xl bg-teal-50 text-teal-700 flex items-center justify-center mx-auto shadow-inner">
          <AlertCircle className="w-10 h-10" />
        </div>

        <div className="space-y-2">
          <span className="text-xs font-bold uppercase tracking-wider text-teal-700 bg-teal-50 px-3 py-1 rounded-full border border-teal-200">
            Error 404
          </span>
          <h1 className="text-3xl font-extrabold text-slate-900 tracking-tight">
            Page Not Found
          </h1>
          <p className="text-sm text-slate-600 max-w-sm mx-auto leading-relaxed">
            Sorry, the page you&apos;re looking for could not be found. It may have been moved or the URL might be mistyped.
          </p>
        </div>

        {/* Buttons requested in Requirement #39 */}
        <div className="flex flex-col sm:flex-row gap-3 pt-2">
          <Link
            href="/"
            className="flex-1 py-3 px-4 rounded-xl bg-teal-700 hover:bg-teal-800 text-white font-bold text-xs flex items-center justify-center gap-2 shadow-xs transition-colors"
          >
            <Home className="w-4 h-4" />
            <span>Go Home</span>
          </Link>

          <Link
            href="/medicines"
            className="flex-1 py-3 px-4 rounded-xl border border-slate-300 text-slate-700 font-semibold text-xs hover:bg-slate-50 flex items-center justify-center gap-2 transition-colors"
          >
            <Pill className="w-4 h-4 text-teal-700" />
            <span>Browse Medicines</span>
          </Link>

          <Link
            href="/contact"
            className="flex-1 py-3 px-4 rounded-xl border border-slate-300 text-slate-700 font-semibold text-xs hover:bg-slate-50 flex items-center justify-center gap-2 transition-colors"
          >
            <Phone className="w-4 h-4 text-teal-700" />
            <span>Contact Us</span>
          </Link>
        </div>

        <div className="pt-4 border-t border-slate-100 text-xs text-slate-400">
          Durga Medical Hall • Village Kubri, Giridih, Jharkhand 825418
        </div>
      </div>
    </div>
  );
}
