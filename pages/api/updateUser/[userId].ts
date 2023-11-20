import { NextApiRequest, NextApiResponse } from 'next';
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

// eslint-disable-next-line import/no-anonymous-default-export
export default async (req: NextApiRequest, res: NextApiResponse) => {
  const { userId } = req.query;

  if (req.method === 'PUT') {
    const { user_name, user_email, user_password } = req.body;

    try {
      const updatedUser = await prisma.users.update({
        where: { user_id: Number(userId) },
        data: {
          user_name,
          user_email,
          user_password,
          // Update other fields as needed
        },
      });

      res.status(200).json(updatedUser);
    } catch (error) {
      console.error('Error updating user:', error);
      res.status(500).json({ message: 'Internal Server Error' });
    } finally {
      await prisma.$disconnect();
    }
  } else if (req.method === 'DELETE') {
    try {
      const deletedUser = await prisma.users.delete({
        where: { user_id: Number(userId) },
      });

      res.status(200).json(deletedUser);
    } catch (error) {
      console.error('Error deleting user:', error);
      res.status(500).json({ message: 'Internal Server Error' });
    } finally {
      await prisma.$disconnect();
    }
  } else if (req.method === 'POST') {
    // Handle add logic
    const { user_name, user_email, user_password } = req.body;

    try {
      const newUser = await prisma.users.create({
        data: {
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
