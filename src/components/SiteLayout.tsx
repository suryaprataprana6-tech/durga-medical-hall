'use client';

import React, { Suspense } from 'react';
import { usePathname } from 'next/navigation';
import Header from './Header';
import Footer from './Footer';
import MobileQuickBar from './MobileQuickBar';

function SiteLayoutInner({ children }: { children: React.ReactNode }) {
  const pathname = usePathname();
  const isAdminRoute = pathname?.startsWith('/admin');

  if (isAdminRoute) {
    return <main className="min-h-screen bg-slate-900 text-slate-100">{children}</main>;
  }

  return (
    <div className="flex flex-col min-h-screen">
      <Header />
      <main className="flex-1 pb-16 sm:pb-0">{children}</main>
      <Footer />
      <MobileQuickBar />
    </div>
  );
}

export default function SiteLayout({ children }: { children: React.ReactNode }) {
  return (
    <Suspense
      fallback={
        <div className="flex flex-col min-h-screen">
          <main className="flex-1 pb-16 sm:pb-0">{children}</main>
        </div>
      }
    >
      <SiteLayoutInner>{children}</SiteLayoutInner>
    </Suspense>
  );
}
