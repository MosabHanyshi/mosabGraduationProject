// pages/api/user-behavior.ts
import { NextApiRequest, NextApiResponse } from 'next';
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

// eslint-disable-next-line import/no-anonymous-default-export
export default async (req: NextApiRequest, res: NextApiResponse) => {
  if (req.method === 'POST') {
    // Handle add logic
    const {behavior_id, user_id, page_name, action_type, timestamp , product_id } = req.body;

    try {
      const newUserBehavior = await prisma.user_behavior.create({
        data: {
          behavior_id,
          user_id,
          page_name,
          action_type,
          timestamp,
          product_id
        },
      });

      res.status(201).json(newUserBehavior);
    } catch (error) {
      console.error('Error adding user behavior:', error);
      res.status(500).json({ message: 'Internal Server Error' });
    } finally {
      await prisma.$disconnect();
    }
  } else {
    res.status(405).json({ message: 'Method not allowed' });
  }
};
