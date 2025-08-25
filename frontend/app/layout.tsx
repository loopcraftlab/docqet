import type { Metadata } from 'next';
import { Inter } from 'next/font/google';
import './globals.css';

const inter = Inter({ subsets: ['latin'] });

export const metadata: Metadata = {
  title: 'Docqet - Secure Document Sharing with AI',
  description: 'A modern platform for secure document sharing with AI-powered analysis and insights.',
  keywords: ['document sharing', 'AI', 'security', 'collaboration'],
  authors: [{ name: 'Docqet Team' }],
  viewport: 'width=device-width, initial-scale=1',
  robots: 'index, follow',
  openGraph: {
    title: 'Docqet - Secure Document Sharing with AI',
    description: 'A modern platform for secure document sharing with AI-powered analysis and insights.',
    type: 'website',
    locale: 'en_US',
  },
  twitter: {
    card: 'summary_large_image',
    title: 'Docqet - Secure Document Sharing with AI',
    description: 'A modern platform for secure document sharing with AI-powered analysis and insights.',
  },
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body className={inter.className}>
        <div className="min-h-screen bg-gray-50">
          {children}
        </div>
      </body>
    </html>
  );
} 