import { NextApiRequest, NextApiResponse } from 'next';
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

// eslint-disable-next-line import/no-anonymous-default-export
export default async (req: NextApiRequest, res: NextApiResponse) => {
 

  if (req.method === 'POST') {
    // Handle add logic
    const { admin_id, admin_name, admin_email,admin_specialists,admin_photo, admin_password } = req.body;

   

    try {
      const newAdmin = await prisma.admins.create({
        data: {
          admin_id,
          admin_name,
          admin_email,
          admin_specialists,
          admin_photo,
          admin_password,
          // Add other fields as needed
        },
      });

      res.status(201).json(newAdmin);
    } catch (error) {
      console.error('Error adding admin:', error);
      res.status(500).json({ message: 'Internal Server Error' });
    } finally {
      await prisma.$disconnect();
    }
  } else {
    res.status(405).json({ message: 'Method not allowed' });
  }
};
