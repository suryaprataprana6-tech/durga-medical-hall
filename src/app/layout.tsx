import type { Metadata } from 'next';
import { Geist, Geist_Mono } from 'next/font/google';
import './globals.css';
import SiteLayout from '@/components/SiteLayout';

const geistSans = Geist({
  variable: '--font-geist-sans',
  subsets: ['latin'],
});

const geistMono = Geist_Mono({
  variable: '--font-geist-mono',
  subsets: ['latin'],
});

const siteUrl = process.env.NEXT_PUBLIC_SITE_URL || 'https://durgamedicalhall.example.com';

export const metadata: Metadata = {
  title: 'Durga Medical Hall | Medical Store in Kubri, Giridih, Jharkhand',
  description:
    'Durga Medical Hall, Kubri, Giridih, Jharkhand – medicines, healthcare products, medicine enquiry, prescription upload and local pharmacy services.',
  keywords: [
    'Durga Medical Hall',
    'Kubri medical store',
    'Giridih pharmacy',
    'Makdiha chemist',
    'medicines Jharkhand',
    'order medicine Kubri',
    'prescription upload Giridih',
    'healthcare products 825418',
  ],
  authors: [{ name: 'Durga Medical Hall' }],
  metadataBase: new URL(siteUrl),
  alternates: {
    canonical: '/',
  },
  openGraph: {
    title: 'Durga Medical Hall | Medical Store in Kubri, Giridih, Jharkhand',
    description:
      'Durga Medical Hall, Kubri, Giridih, Jharkhand – medicines, healthcare products, medicine enquiry, prescription upload and local pharmacy services.',
    url: siteUrl,
    siteName: 'Durga Medical Hall',
    locale: 'en_IN',
    type: 'website',
  },
  twitter: {
    card: 'summary_large_image',
    title: 'Durga Medical Hall | Medical Store in Kubri, Giridih, Jharkhand',
    description:
      'Quality medicines & healthcare products at Durga Medical Hall, Village Kubri, Giridih, Jharkhand 825418.',
  },
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  // Schema Markup for LocalBusiness / Pharmacy / Organization
  const jsonLd = {
    '@context': 'https://schema.org',
    '@type': 'Pharmacy',
    name: 'Durga Medical Hall',
    description:
      'Local pharmacy & medical store providing genuine medicines, healthcare essentials, prescription verification, and local delivery in Kubri, Giridih, Jharkhand.',
    address: {
      '@type': 'PostalAddress',
      streetAddress: 'Village – Kubri, Post – Kubri, Panchayat – Makdiha',
      addressLocality: 'Giridih',
      addressRegion: 'Jharkhand',
      postalCode: '825418',
      addressCountry: 'IN',
    },
    geo: {
      '@type': 'GeoCoordinates',
      latitude: '24.18',
      longitude: '86.30',
    },
    url: 'https://durgamedicalhall.example.com',
    telephone: '+91-XXXXXXXXXX',
    priceRange: '₹',
    openingHoursSpecification: [
      {
        '@type': 'OpeningHoursSpecification',
        dayOfWeek: [
          'Monday',
          'Tuesday',
          'Wednesday',
          'Thursday',
          'Friday',
          'Saturday',
          'Sunday',
        ],
        opens: '08:00',
        closes: '21:00',
      },
    ],
  };

  return (
    <html
      lang="en"
      className={`${geistSans.variable} ${geistMono.variable} h-full antialiased`}
    >
      <head>
        <script
          type="application/ld+json"
          dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }}
        />
      </head>
      <body className="min-h-full flex flex-col bg-slate-50 text-slate-900 font-sans">
        <SiteLayout>{children}</SiteLayout>
      </body>
    </html>
  );
}
