// utils/auth.ts
import { sign, verify } from 'jsonwebtoken';
import { hash, compare } from 'bcrypt';
import { useRouter } from 'next/router';

const secretKey: string = 'your-secret-key';

export const generateToken = (payload: any): string => sign(payload, secretKey, { expiresIn: '1h' });

export const verifyToken = (token: string): any => verify(token, secretKey);

export const hashPassword = async (password: string): Promise<string> => hash(password, 10);

export const comparePassword = async (password: string, hashedPassword: string): Promise<boolean> =>
  compare(password, hashedPassword);



  export const checkAuth = async () => {
    const token = localStorage.getItem('yourTokenKey'); // Replace 'yourTokenKey' with the actual key you use
  
    if (!token) {
      return false; // No token found, user is not authenticated
    }
  
    try {
      const decodedToken = await verifyToken(token);
      return true; // User is authenticated
    } catch (error) {
      return false; // User is not authenticated
    }
  };
  
  export const redirectToLogin = () => {
    const router = useRouter();
    router.push('/login'); // Update with your login page route
  };
