'use client';

import React from 'react';
import Link from 'next/link';
import { Category } from '@/types';
import {
  Thermometer,
  Wind,
  Brain,
  Flame,
  Activity,
  ShieldAlert,
  Droplet,
  Heart,
  Sparkles,
  Pill,
  ShieldCheck,
  Smile,
  Sparkle,
  Eye,
  Headphones,
  SmilePlus,
  Baby,
  UserCheck,
  User,
  HeartHandshake,
  Zap,
  Crosshair,
  PlusSquare,
  Scissors,
  Cpu,
  Leaf,
  Sun,
  Shield,
  ArrowRight,
} from 'lucide-react';

const iconMap: Record<string, React.ElementType> = {
  Thermometer,
  Wind,
  Brain,
  Flame,
  Activity,
  ShieldAlert,
  Droplet,
  Heart,
  Sparkles,
  Pill,
  ShieldCheck,
  Smile,
  Sparkle,
  Eye,
  Headphones,
  SmilePlus,
  Baby,
  UserCheck,
  User,
  HeartHandshake,
  Zap,
  Crosshair,
  PlusSquare,
  Scissors,
  Cpu,
  Leaf,
  Sun,
  Shield,
};

interface CategoryCardProps {
  category: Category;
}

export default function CategoryCard({ category }: CategoryCardProps) {
  const IconComponent = iconMap[category.iconName] || Pill;

  return (
    <Link
      href={`/medicines/${category.slug}`}
      className="group bg-white rounded-2xl p-5 border border-slate-200 shadow-xs hover:shadow-md hover:border-teal-300 transition-all duration-200 flex flex-col justify-between"
    >
      <div>
        <div className="flex items-center justify-between mb-4">
          <div className="w-12 h-12 rounded-xl bg-teal-50 text-teal-700 flex items-center justify-center group-hover:bg-teal-700 group-hover:text-white transition-colors duration-200">
            <IconComponent className="w-6 h-6 transition-transform group-hover:scale-110" />
          </div>
          <span className="text-[11px] font-semibold text-slate-500 bg-slate-100 px-2 py-0.5 rounded-full">
            {category.productCount} Items
          </span>
        </div>

        <h3 className="text-base font-bold text-slate-900 group-hover:text-teal-700 transition-colors mb-1.5">
          {category.name}
        </h3>

        <p className="text-xs text-slate-500 line-clamp-2 leading-relaxed">
          {category.description}
        </p>
      </div>

      <div className="mt-4 pt-3 border-t border-slate-100 flex items-center justify-between text-xs font-semibold text-teal-700 group-hover:text-teal-800">
        <span>View Products</span>
        <ArrowRight className="w-4 h-4 transform group-hover:translate-x-1 transition-transform" />
      </div>
    </Link>
  );
}
