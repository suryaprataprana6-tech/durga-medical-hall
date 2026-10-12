'use client';

import React, { useState, useEffect, useRef } from 'react';
import { useRouter } from 'next/navigation';
import { Search, X, Pill, ArrowRight } from 'lucide-react';
import { useMedicines } from '@/lib/store';
import Link from 'next/link';

interface SearchAutocompleteProps {
  placeholder?: string;
  className?: string;
}

export default function SearchAutocomplete({
  placeholder = 'Search medicine, generic name, brand or composition...',
  className = '',
}: SearchAutocompleteProps) {
  const [query, setQuery] = useState('');
  const [isOpen, setIsOpen] = useState(false);
  const medicines = useMedicines();
  const containerRef = useRef<HTMLDivElement>(null);
  const router = useRouter();

  // Close dropdown on outside click
  useEffect(() => {
    function handleClickOutside(e: MouseEvent) {
      if (containerRef.current && !containerRef.current.contains(e.target as Node)) {
        setIsOpen(false);
      }
    }
    document.addEventListener('mousedown', handleClickOutside);
    return () => document.removeEventListener('mousedown', handleClickOutside);
  }, []);

  const trimmed = query.trim().toLowerCase();

  const filteredResults = trimmed
    ? medicines.filter(
        (m) =>
          m.name.toLowerCase().includes(trimmed) ||
          m.brand.toLowerCase().includes(trimmed) ||
          m.genericName.toLowerCase().includes(trimmed) ||
          m.composition.toLowerCase().includes(trimmed) ||
          m.categoryName.toLowerCase().includes(trimmed)
      ).slice(0, 6)
    : [];

  const handleKeyDown = (e: React.KeyboardEvent<HTMLInputElement>) => {
    if (e.key === 'Enter') {
      e.preventDefault();
      setIsOpen(false);
      router.push(`/medicines?q=${encodeURIComponent(query)}`);
    }
  };

  return (
    <div ref={containerRef} className={`relative w-full ${className}`}>
      <div className="relative flex items-center">
        <Search className="absolute left-4 w-5 h-5 text-slate-400 pointer-events-none" />
        <input
          type="text"
          value={query}
          onChange={(e) => {
            setQuery(e.target.value);
            setIsOpen(true);
          }}
          onFocus={() => setIsOpen(true)}
          onKeyDown={handleKeyDown}
          placeholder={placeholder}
          className="w-full pl-12 pr-12 py-3.5 sm:py-4 bg-white border border-slate-300 rounded-2xl text-slate-800 placeholder-slate-400 text-sm sm:text-base focus:border-teal-600 focus:ring-2 focus:ring-teal-600/20 shadow-xs outline-hidden transition-all"
        />
        {query && (
          <button
            type="button"
            onClick={() => {
              setQuery('');
              setIsOpen(false);
            }}
            className="absolute right-4 p-1 text-slate-400 hover:text-slate-600 rounded-full"
            aria-label="Clear search query"
          >
            <X className="w-4 h-4" />
          </button>
        )}
      </div>

      {/* Instant Dropdown Suggestions */}
      {isOpen && query.trim().length > 1 && (
        <div className="absolute left-0 right-0 top-full mt-2 bg-white rounded-2xl border border-slate-200 shadow-xl overflow-hidden z-50 animate-in fade-in slide-in-from-top-1 duration-150">
          <div className="p-3 bg-slate-50 border-b border-slate-100 flex items-center justify-between text-xs text-slate-500 font-medium">
            <span>Matching Medicines ({filteredResults.length})</span>
            <Link
              href={`/medicines?q=${encodeURIComponent(query)}`}
              onClick={() => setIsOpen(false)}
              className="text-teal-700 hover:underline flex items-center gap-1"
            >
              See all results <ArrowRight className="w-3 h-3" />
            </Link>
          </div>

          {filteredResults.length === 0 ? (
            <div className="p-6 text-center">
              <p className="text-sm font-medium text-slate-700">No medicine found for &quot;{query}&quot;</p>
              <p className="text-xs text-slate-500 mt-1">
                You can still submit a custom request or prescription to Durga Medical Hall.
              </p>
              <div className="mt-3 flex items-center justify-center gap-2">
                <Link
                  href={`/order-medicine?medicine=${encodeURIComponent(query)}`}
                  onClick={() => setIsOpen(false)}
                  className="px-3 py-1.5 rounded-lg bg-teal-700 text-white text-xs font-semibold"
                >
                  Order &quot;{query}&quot;
                </Link>
              </div>
            </div>
          ) : (
            <div className="divide-y divide-slate-100 max-h-80 overflow-y-auto">
              {filteredResults.map((item) => (
                <Link
                  key={item.id}
                  href={`/product/${item.slug}`}
                  onClick={() => setIsOpen(false)}
                  className="p-3.5 hover:bg-teal-50/50 flex items-center justify-between gap-3 transition-colors"
                >
                  <div className="flex items-center gap-3">
                    <div className="w-9 h-9 rounded-lg bg-teal-100/60 text-teal-800 flex items-center justify-center shrink-0">
                      <Pill className="w-4 h-4 text-teal-700" />
                    </div>
                    <div>
                      <h4 className="text-sm font-bold text-slate-900 line-clamp-1">{item.name}</h4>
                      <p className="text-xs text-slate-500 line-clamp-1">
                        {item.genericName} • {item.packSize}
                      </p>
                    </div>
                  </div>

                  <div className="text-right shrink-0">
                    <span className="text-sm font-bold text-slate-900">
                      ₹{item.sellingPrice.toFixed(2)}
                    </span>
                    <span className="block text-[10px] text-slate-400">
                      {item.prescriptionRequired ? 'Rx Required' : 'OTC'}
                    </span>
                  </div>
                </Link>
              ))}
            </div>
          )}

          <div className="p-2.5 bg-slate-50 border-t border-slate-100 text-center">
            <Link
              href={`/medicines?q=${encodeURIComponent(query)}`}
              onClick={() => setIsOpen(false)}
              className="text-xs font-semibold text-teal-700 hover:text-teal-800"
            >
              Search complete catalogue for &quot;{query}&quot; →
            </Link>
          </div>
        </div>
      )}
    </div>
  );
}
