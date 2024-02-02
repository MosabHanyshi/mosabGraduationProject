// pages/api/login.ts

import { NextApiRequest, NextApiResponse } from 'next';
import { PrismaClient } from '@prisma/client';
import { comparePassword, generateToken } from '../../utils/auth'; // Import the generateToken function

const prisma = new PrismaClient();

export default async function handler(req: NextApiRequest, res: NextApiResponse) {
  if (req.method === 'POST') {
    const { email, password } = req.body;

    try {
      // Check if user with the provided email exists
      const user = await prisma.users.findFirst({
        where: {
          user_email: email,
        },
      });

      console.log(user);

      if (user) {
        // User found, now check the hashed password
        const passwordMatch = comparePassword(password, user.user_password);
        console.log("is Matched ", passwordMatch)

        if (await passwordMatch) {
          // Passwords match, generate a token and send it to the client
          const token = generateToken({ userId: user.user_id });
          console.log("the token is :", token)
          res.status(200).json({ message: 'Login successful', user, token });
        } else {
          // Passwords don't match, authentication failed
          res.status(401).json({ message: 'Invalid credentials' });
        }
      } else {
        // User not found, authentication failed
        res.status(401).json({ message: 'Invalid credentials' });
      }
    } catch (error) {
      console.error('Error during login:', error);
      res.status(500).json({ message: 'Internal Server Error' });
    } finally {
      // Disconnect Prisma client after use
      await prisma.$disconnect();
    }
  } else {
    // Method not allowed
    res.status(405).json({ message: 'Method not allowed' });
  }
}
