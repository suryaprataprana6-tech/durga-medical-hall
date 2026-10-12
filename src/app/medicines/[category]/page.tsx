'use client';

import React from 'react';
import Link from 'next/link';
import { useParams } from 'next/navigation';
import { useCategories, useMedicines } from '@/lib/store';
import MedicineCard from '@/components/MedicineCard';
import { ArrowLeft, Tag, AlertCircle } from 'lucide-react';

function CategoryMedicinesContent() {
  const params = useParams();
  const categorySlug = params?.category as string;

  const categories = useCategories();
  const medicines = useMedicines();

  const currentCategory = categories.find(
    (c) => c.slug === categorySlug || c.id === categorySlug
  );

  const categoryMedicines = medicines.filter((m) => {
    if (!currentCategory) return false;
    return (
      m.categoryId === currentCategory.id ||
      m.categoryName.toLowerCase() === currentCategory.name.toLowerCase()
    );
  });

  return (
    <div className="min-h-screen bg-slate-50 py-10">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        {/* Breadcrumb Navigation */}
        <div className="flex items-center gap-2 text-xs text-slate-500 mb-6">
          <Link href="/" className="hover:text-teal-700">
            Home
          </Link>
          <span>/</span>
          <Link href="/medicines" className="hover:text-teal-700">
            Medicines
          </Link>
          <span>/</span>
          <span className="text-slate-800 font-semibold">
            {currentCategory?.name || 'Category'}
          </span>
        </div>

        {/* Back Link */}
        <div className="mb-4">
          <Link
            href="/medicines"
            className="inline-flex items-center gap-1.5 text-xs font-semibold text-teal-700 hover:text-teal-900"
          >
            <ArrowLeft className="w-4 h-4" />
            <span>Back to All Categories</span>
          </Link>
        </div>

        {/* Category Header Card */}
        <div className="bg-white rounded-3xl p-6 sm:p-8 border border-slate-200 shadow-xs mb-8">
          <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
            <div>
              <div className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-teal-50 text-teal-800 text-xs font-semibold border border-teal-200 mb-2">
                <Tag className="w-3.5 h-3.5 text-teal-600" />
                <span>Health Category</span>
              </div>
              <h1 className="text-2xl sm:text-3xl font-extrabold text-slate-900">
                {currentCategory ? currentCategory.name : 'Category Medicines'}
              </h1>
              <p className="text-sm text-slate-600 mt-2 max-w-2xl leading-relaxed">
                {currentCategory?.description ||
                  'Explore products and medicines under this healthcare classification.'}
              </p>
            </div>

            <div className="bg-slate-50 p-4 rounded-2xl border border-slate-100 text-center shrink-0">
              <span className="text-2xl font-black text-teal-700 block">
                {categoryMedicines.length}
              </span>
              <span className="text-xs text-slate-500 font-medium">Catalogued Items</span>
            </div>
          </div>
        </div>

        {/* Products Grid or Category Empty State */}
        {categoryMedicines.length === 0 ? (
          <div className="bg-white rounded-3xl p-12 text-center border border-slate-200 max-w-xl mx-auto shadow-xs">
            <div className="w-16 h-16 rounded-full bg-teal-50 text-teal-600 flex items-center justify-center mx-auto mb-4">
              <AlertCircle className="w-8 h-8" />
            </div>
            <h3 className="text-lg font-bold text-slate-900">
              No Demo Products in {currentCategory?.name || 'this category'}
            </h3>
            <p className="text-sm text-slate-500 mt-2">
              Our store in Village Kubri maintains supplies for this category. You can enquire about availability or upload your prescription directly.
            </p>
            <div className="mt-6 flex flex-wrap items-center justify-center gap-3">
              <Link
                href={`/order-medicine?category=${encodeURIComponent(
                  currentCategory?.name || ''
                )}`}
                className="px-4 py-2.5 rounded-xl bg-teal-700 text-white text-xs font-semibold hover:bg-teal-800"
              >
                Enquire for {currentCategory?.name || 'Medicines'}
              </Link>
              <Link
                href="/medicines"
                className="px-4 py-2.5 rounded-xl border border-slate-300 text-xs font-semibold text-slate-700 hover:bg-slate-50"
              >
                Browse All Medicines
              </Link>
            </div>
          </div>
        ) : (
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
            {categoryMedicines.map((med) => (
              <MedicineCard key={med.id} medicine={med} />
            ))}
          </div>
        )}
      </div>
    </div>
  );
}

export default function CategoryMedicinesPage() {
  return (
    <React.Suspense fallback={<div className="p-12 text-center text-slate-500">Loading category...</div>}>
      <CategoryMedicinesContent />
    </React.Suspense>
  );
}
