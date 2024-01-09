"use Client"
import type { Metadata } from 'next'
import { Inter } from 'next/font/google'
import './globals.css'
import Link from 'next/link'
// import { ClerkProvider ,auth } from "@clerk/nextjs";
import NavComponent from './components/navbar';
import { StateProvider } from './context/StateContext';




const inter  = Inter({ subsets: ['latin'] })

export const metadata: Metadata = {
  title: 'Create Next App',
  description: 'Generated by create next app',
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    // <ClerkProvider>
      <html lang="en">
        <body
          className={inter.className}
          style={{
            width: "100%",
            height: "100%",
            background: "white",
          }}
        >
       
            <NavComponent message={""} />

            {children}
        </body>
      </html>
    // </ClerkProvider>
  );
}
