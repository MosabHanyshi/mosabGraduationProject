import { NextApiRequest, NextApiResponse } from 'next';
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

// eslint-disable-next-line import/no-anonymous-default-export
export default async (req: NextApiRequest, res: NextApiResponse) => {
  if (req.method === 'POST') {
    // Handle add logic
    const { cart_id, product_id, quantity } = req.body;

    try {
      // Check if the product ID already exists in the cart
      const existingCartItem = await prisma.cart_item.findUnique({
        where: {
          product_id
        },
      });

      res.status(201).json(existingCartItem);

      if (!existingCartItem) {
          // If the product ID does not exist, create a new cart item.
        const newCartItem = await prisma.cart_item.create({
          data: {
            cart_id,
            product_id,
            quantity,
          },
        });

        res.status(201).json(newCartItem);
      } else {
     
      }
    } catch (error) {
      console.error('Error adding CartItem:', error);
      res.status(500).json({ message: 'Internal Server Error' });
    } finally {
      await prisma.$disconnect();
    }
  } else {
    res.status(405).json({ message: 'Method not allowed' });
  }
};
