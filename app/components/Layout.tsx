// components/Layout.tsx
import Navbar from './navbar'; // Corrected import with capital 'N'
import { useRouter } from 'next/router';
import { ReactNode } from 'react';

interface LayoutProps {
  children: ReactNode;
}

const Layout = ({ children }: LayoutProps) => {


  return (
    <div>
     <Navbar message={""} />
      {children}
    </div>
  );
};

export default Layout;
