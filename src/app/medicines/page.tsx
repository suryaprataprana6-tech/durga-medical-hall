'use client';

import React, { useState, useMemo, Suspense } from 'react';
import { useSearchParams } from 'next/navigation';
import Link from 'next/link';
import {
  Search,
  X,
  AlertCircle,
} from 'lucide-react';
import MedicineCard from '@/components/MedicineCard';
import { useCategories, useMedicines } from '@/lib/store';

function MedicinesContent() {
  const searchParams = useSearchParams();
  const initialQuery = searchParams.get('q') || '';
  const initialCategoryParam = searchParams.get('category') || 'all';

  const medicines = useMedicines();
  const categories = useCategories();

  const [searchQuery, setSearchQuery] = useState(initialQuery);
  const [selectedCategory, setSelectedCategory] = useState(initialCategoryParam);
  const [selectedRxFilter, setSelectedRxFilter] = useState<'all' | 'rx' | 'otc'>('all');
  const [selectedStockFilter, setSelectedStockFilter] = useState<'all' | 'instock'>('all');
  const [sortBy, setSortBy] = useState<'default' | 'price-asc' | 'price-desc' | 'name-asc'>('default');

  // Filtering & Sorting logic
  const filteredMedicines = useMemo(() => {
    return medicines
      .filter((med) => {
        // Query filter
        if (searchQuery.trim()) {
          const q = searchQuery.toLowerCase().trim();
          const match =
            med.name.toLowerCase().includes(q) ||
            med.brand.toLowerCase().includes(q) ||
            med.genericName.toLowerCase().includes(q) ||
            med.composition.toLowerCase().includes(q) ||
            med.categoryName.toLowerCase().includes(q);
          if (!match) return false;
        }

        // Category filter
        if (selectedCategory !== 'all') {
          const cat = categories.find((c) => c.slug === selectedCategory || c.id === selectedCategory);
          if (cat && med.categoryId !== cat.id && med.categoryName.toLowerCase() !== cat.name.toLowerCase()) {
            return false;
          }
        }

        // Rx filter
        if (selectedRxFilter === 'rx' && !med.prescriptionRequired) return false;
        if (selectedRxFilter === 'otc' && med.prescriptionRequired) return false;

        // Stock filter
        if (selectedStockFilter === 'instock' && med.stockQuantity <= 0) return false;

        return true;
      })
      .sort((a, b) => {
        if (sortBy === 'price-asc') return a.sellingPrice - b.sellingPrice;
        if (sortBy === 'price-desc') return b.sellingPrice - a.sellingPrice;
        if (sortBy === 'name-asc') return a.name.localeCompare(b.name);
        return 0;
      });
  }, [medicines, categories, searchQuery, selectedCategory, selectedRxFilter, selectedStockFilter, sortBy]);

  const clearAllFilters = () => {
    setSearchQuery('');
    setSelectedCategory('all');
    setSelectedRxFilter('all');
    setSelectedStockFilter('all');
    setSortBy('default');
  };

  const hasActiveFilters =
    Boolean(searchQuery) ||
    selectedCategory !== 'all' ||
    selectedRxFilter !== 'all' ||
    selectedStockFilter !== 'all' ||
    sortBy !== 'default';

  return (
    <div className="min-h-screen bg-slate-50 py-10">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        {/* Page Header */}
        <div className="mb-8">
          <div className="flex items-center gap-2 text-xs text-slate-500 mb-2">
            <Link href="/" className="hover:text-teal-700">
              Home
            </Link>
            <span>/</span>
            <span className="text-slate-800 font-semibold">Medicine Catalogue</span>
          </div>
          <h1 className="text-3xl font-extrabold text-slate-900 tracking-tight">
            Medicine Catalogue & Products
          </h1>
          <p className="text-slate-600 text-sm mt-1 max-w-2xl">
            Browse authentic medicines, daily healthcare essentials, and medical devices at Durga Medical Hall, Kubri. Prescription medicines require verification.
          </p>
        </div>

        {/* Search and Filters Bar */}
        <div className="bg-white rounded-2xl p-4 sm:p-6 border border-slate-200 shadow-xs mb-8 space-y-4">
          {/* Top Search Input */}
          <div className="relative">
            <Search className="absolute left-4 top-3.5 w-5 h-5 text-slate-400" />
            <input
              type="text"
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              placeholder="Search by medicine name, generic salt, brand (e.g. Paracetamol, Amoxicillin)..."
              className="w-full pl-12 pr-10 py-3 bg-slate-50 border border-slate-300 rounded-xl text-slate-800 placeholder-slate-400 text-sm focus:bg-white focus:border-teal-600 focus:ring-2 focus:ring-teal-600/20 outline-hidden transition-all"
            />
            {searchQuery && (
              <button
                type="button"
                onClick={() => setSearchQuery('')}
                className="absolute right-3.5 top-3.5 text-slate-400 hover:text-slate-600"
              >
                <X className="w-4 h-4" />
              </button>
            )}
          </div>

          {/* Filter Controls Row */}
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-3 pt-2 border-t border-slate-100">
            {/* Category Select */}
            <div>
              <label className="block text-[11px] font-semibold text-slate-500 uppercase tracking-wider mb-1">
                Category
              </label>
              <select
                value={selectedCategory}
                onChange={(e) => setSelectedCategory(e.target.value)}
                className="w-full py-2.5 px-3 bg-white border border-slate-300 rounded-xl text-slate-700 text-xs font-medium focus:border-teal-600 focus:ring-1 focus:ring-teal-600 outline-hidden"
              >
                <option value="all">All 28 Categories</option>
                {categories.map((c) => (
                  <option key={c.id} value={c.slug}>
                    {c.name}
                  </option>
                ))}
              </select>
            </div>

            {/* Prescription Filter */}
            <div>
              <label className="block text-[11px] font-semibold text-slate-500 uppercase tracking-wider mb-1">
                Prescription Requirement
              </label>
              <select
                value={selectedRxFilter}
                onChange={(e) => setSelectedRxFilter(e.target.value as 'all' | 'rx' | 'otc')}
                className="w-full py-2.5 px-3 bg-white border border-slate-300 rounded-xl text-slate-700 text-xs font-medium focus:border-teal-600 focus:ring-1 focus:ring-teal-600 outline-hidden"
              >
                <option value="all">All Medicines</option>
                <option value="rx">Prescription Required (Rx)</option>
                <option value="otc">General Healthcare / OTC</option>
              </select>
            </div>

            {/* Availability Filter */}
            <div>
              <label className="block text-[11px] font-semibold text-slate-500 uppercase tracking-wider mb-1">
                Stock Status
              </label>
              <select
                value={selectedStockFilter}
                onChange={(e) => setSelectedStockFilter(e.target.value as 'all' | 'instock')}
                className="w-full py-2.5 px-3 bg-white border border-slate-300 rounded-xl text-slate-700 text-xs font-medium focus:border-teal-600 focus:ring-1 focus:ring-teal-600 outline-hidden"
              >
                <option value="all">All Products</option>
                <option value="instock">Available in Stock</option>
              </select>
            </div>

            {/* Sort Order */}
            <div>
              <label className="block text-[11px] font-semibold text-slate-500 uppercase tracking-wider mb-1">
                Sort By
              </label>
              <select
                value={sortBy}
                onChange={(e) =>
                  setSortBy(e.target.value as 'default' | 'price-asc' | 'price-desc' | 'name-asc')
                }
                className="w-full py-2.5 px-3 bg-white border border-slate-300 rounded-xl text-slate-700 text-xs font-medium focus:border-teal-600 focus:ring-1 focus:ring-teal-600 outline-hidden"
              >
                <option value="default">Relevance / Default</option>
                <option value="price-asc">Price: Low to High</option>
                <option value="price-desc">Price: High to Low</option>
                <option value="name-asc">Product Name (A-Z)</option>
              </select>
            </div>
          </div>

          {/* Active Filters Summary & Reset */}
          {hasActiveFilters && (
            <div className="flex items-center justify-between pt-2 border-t border-slate-100 text-xs">
              <span className="text-slate-600">
                Found <strong className="text-teal-700">{filteredMedicines.length}</strong> matching{' '}
                {filteredMedicines.length === 1 ? 'medicine' : 'medicines'}
              </span>
              <button
                type="button"
                onClick={clearAllFilters}
                className="text-teal-700 hover:text-teal-900 font-semibold underline flex items-center gap-1"
              >
                <X className="w-3.5 h-3.5" />
                Reset all filters
              </button>
            </div>
          )}
        </div>

        {/* Results Grid or Empty State */}
        {filteredMedicines.length === 0 ? (
          <div className="bg-white rounded-3xl p-12 text-center border border-slate-200 max-w-xl mx-auto shadow-xs">
            <div className="w-16 h-16 rounded-full bg-slate-100 text-slate-400 flex items-center justify-center mx-auto mb-4">
              <AlertCircle className="w-8 h-8" />
            </div>
            <h3 className="text-lg font-bold text-slate-900">No Medicines Found</h3>
            <p className="text-sm text-slate-500 mt-1 max-w-md mx-auto">
              We couldn&apos;t find any medicine matching your criteria. You can still order or enquire about any required medicine directly with our Kubri counter.
            </p>
            <div className="mt-6 flex flex-wrap items-center justify-center gap-3">
              <button
                type="button"
                onClick={clearAllFilters}
                className="px-4 py-2 rounded-xl border border-slate-300 text-xs font-semibold text-slate-700 hover:bg-slate-50"
              >
                Clear Filters
              </button>
              <Link
                href={`/order-medicine?medicine=${encodeURIComponent(searchQuery || 'Enquiry')}`}
                className="px-4 py-2 rounded-xl bg-teal-700 text-white text-xs font-semibold hover:bg-teal-800"
              >
                Request Unlisted Medicine
              </Link>
            </div>
          </div>
        ) : (
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
            {filteredMedicines.map((med) => (
              <MedicineCard key={med.id} medicine={med} />
            ))}
          </div>
        )}

        {/* Pharmacy Disclaimer Banner */}
        <div className="mt-12 p-5 bg-white rounded-2xl border border-slate-200 text-xs text-slate-600 leading-relaxed shadow-xs">
          <p className="font-semibold text-slate-800 mb-1">
            Official Durga Medical Hall Catalogue Note:
          </p>
          Medicines displayed in this online catalogue are for identification and enquiry purposes only. Pricing, pack details, and batch availability may vary according to current stocks at our Village Kubri dispensary. Prescription medicines are dispensed solely upon presenting a valid prescription issued by a qualified registered medical practitioner.
        </div>
      </div>
    </div>
  );
}

export default function MedicinesPage() {
  return (
    <Suspense fallback={<div className="p-12 text-center text-slate-500">Loading medicines...</div>}>
      <MedicinesContent />
    </Suspense>
  );
}
