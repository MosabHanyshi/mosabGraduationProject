import { NextApiRequest, NextApiResponse } from 'next';
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

// eslint-disable-next-line import/no-anonymous-default-export
export default async (req: NextApiRequest, res: NextApiResponse) => {
 

  if (req.method === 'POST') {
    // Handle add logic
    const { cart_id , user_id } = req.body;

    try {
      const newCart = await prisma.cart.create({
        data: {
        cart_id , user_id 
        },
      });

      res.status(201).json(newCart);
    } catch (error) {
      console.error('Error adding Product:', error);
      res.status(500).json({ message: 'Internal Server Error' });
    } finally {
      await prisma.$disconnect();
    }
  } else {
    res.status(405).json({ message: 'Method not allowed' });
  }
};
