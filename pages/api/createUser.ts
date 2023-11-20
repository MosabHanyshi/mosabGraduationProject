import { NextApiRequest, NextApiResponse } from 'next';
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

// eslint-disable-next-line import/no-anonymous-default-export
export default async (req: NextApiRequest, res: NextApiResponse) => {
 

  if (req.method === 'POST') {
    // Handle add logic
    const { user_id, user_name, user_email, user_password } = req.body;

   

    try {
      const newUser = await prisma.users.create({
        data: {
          user_id,
          user_name,
          user_email,
          user_password,
          // Add other fields as needed
        },
      });

      res.status(201).json(newUser);
    } catch (error) {
      console.error('Error adding user:', error);
      res.status(500).json({ message: 'Internal Server Error' });
    } finally {
      await prisma.$disconnect();
    }
  } else {
    res.status(405).json({ message: 'Method not allowed' });
  }
};
