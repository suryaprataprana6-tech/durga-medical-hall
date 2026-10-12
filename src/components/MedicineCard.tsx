'use client';

import React from 'react';
import Link from 'next/link';
import { Medicine } from '@/types';
import {
  FileCheck2,
  ShoppingBag,
  ExternalLink,
  ShieldCheck,
  CheckCircle2,
  AlertCircle,
  Pill,
} from 'lucide-react';

interface MedicineCardProps {
  medicine: Medicine;
}

export default function MedicineCard({ medicine }: MedicineCardProps) {
  const isOutOfStock = medicine.stockQuantity <= 0;
  const discountPercent =
    medicine.mrp > medicine.sellingPrice
      ? Math.round(((medicine.mrp - medicine.sellingPrice) / medicine.mrp) * 100)
      : 0;

  return (
    <div className="bg-white rounded-2xl border border-slate-200 shadow-xs hover:shadow-md transition-all duration-200 flex flex-col justify-between overflow-hidden group hover:border-teal-200">
      {/* Top Banner / Badges */}
      <div className="p-4 sm:p-5 pb-3">
        <div className="flex items-center justify-between gap-2 mb-3">
          {/* Rx Badge vs OTC Badge */}
          {medicine.prescriptionRequired ? (
            <span className="inline-flex items-center gap-1 text-[11px] font-bold px-2 py-0.5 rounded-full bg-rose-50 text-rose-700 border border-rose-200">
              <FileCheck2 className="w-3 h-3 text-rose-600" />
              Prescription Required (Rx)
            </span>
          ) : (
            <span className="inline-flex items-center gap-1 text-[11px] font-semibold px-2 py-0.5 rounded-full bg-emerald-50 text-emerald-700 border border-emerald-200">
              <ShieldCheck className="w-3 h-3 text-emerald-600" />
              General Healthcare / OTC
            </span>
          )}

          {/* Safe Demo Data Badge */}
          {medicine.isDemo && (
            <span className="text-[10px] uppercase font-bold tracking-wider px-1.5 py-0.5 rounded bg-slate-100 text-slate-500 border border-slate-200">
              Demo Product
            </span>
          )}
        </div>

        {/* Visual Pill / Pack Art Header */}
        <div className="h-28 rounded-xl bg-gradient-to-tr from-slate-50 to-teal-50/40 border border-slate-100 flex items-center justify-center relative mb-4 group-hover:scale-[1.01] transition-transform">
          <div className="flex flex-col items-center justify-center text-teal-700/80">
            <div className="w-12 h-12 rounded-full bg-white shadow-xs border border-teal-100 flex items-center justify-center mb-1">
              <Pill className="w-6 h-6 text-teal-600" />
            </div>
            <span className="text-[11px] font-medium text-slate-500">{medicine.packSize}</span>
          </div>

          {discountPercent > 0 && (
            <span className="absolute top-2 right-2 text-[10px] font-extrabold bg-teal-600 text-white px-2 py-0.5 rounded-full shadow-xs">
              {discountPercent}% OFF
            </span>
          )}
        </div>

        {/* Medicine Name & Category */}
        <div className="mb-2">
          <span className="text-[11px] font-semibold text-teal-700 uppercase tracking-wider block mb-1">
            {medicine.categoryName}
          </span>
          <Link
            href={`/product/${medicine.slug}`}
            className="text-base font-bold text-slate-900 group-hover:text-teal-700 transition-colors line-clamp-1 block"
            title={medicine.name}
          >
            {medicine.name}
          </Link>
          <span className="text-xs text-slate-500 font-medium block">
            Brand: <strong className="text-slate-700 font-normal">{medicine.brand}</strong>
          </span>
        </div>

        {/* Composition / Generic */}
        <p className="text-xs text-slate-600 line-clamp-2 bg-slate-50 p-2 rounded-lg border border-slate-100 font-mono text-[11px] leading-relaxed mb-3">
          <span className="font-semibold text-slate-700">Salt:</span> {medicine.composition}
        </p>
      </div>

      {/* Bottom Pricing & Actions */}
      <div className="p-4 sm:p-5 pt-0 mt-auto">
        <div className="flex items-baseline justify-between mb-3 pt-3 border-t border-slate-100">
          <div>
            <span className="text-lg font-extrabold text-slate-900">
              ₹{medicine.sellingPrice.toFixed(2)}
            </span>
            {medicine.mrp > medicine.sellingPrice && (
              <span className="ml-2 text-xs text-slate-400 line-through">
                MRP ₹{medicine.mrp.toFixed(2)}
              </span>
            )}
            <span className="block text-[10px] text-slate-400">Inclusive of all taxes</span>
          </div>

          {/* Stock availability */}
          {isOutOfStock ? (
            <span className="inline-flex items-center gap-1 text-[11px] font-semibold text-amber-700 bg-amber-50 px-2 py-0.5 rounded-full">
              <AlertCircle className="w-3 h-3" />
              Check Availability
            </span>
          ) : (
            <span className="inline-flex items-center gap-1 text-[11px] font-semibold text-emerald-700 bg-emerald-50 px-2 py-0.5 rounded-full">
              <CheckCircle2 className="w-3 h-3" />
              Available
            </span>
          )}
        </div>

        <div className="grid grid-cols-2 gap-2">
          <Link
            href={`/product/${medicine.slug}`}
            className="flex items-center justify-center gap-1 py-2 px-3 rounded-xl border border-slate-200 text-xs font-semibold text-slate-700 hover:bg-slate-50 hover:text-teal-700 transition-colors"
          >
            <span>Details</span>
            <ExternalLink className="w-3.5 h-3.5" />
          </Link>

          <Link
            href={`/order-medicine?medicine=${encodeURIComponent(medicine.name)}`}
            className="flex items-center justify-center gap-1.5 py-2 px-3 rounded-xl bg-teal-700 hover:bg-teal-800 text-white text-xs font-semibold shadow-xs transition-colors"
          >
            <ShoppingBag className="w-3.5 h-3.5" />
            <span>Enquire / Order</span>
          </Link>
        </div>
      </div>
    </div>
  );
}
