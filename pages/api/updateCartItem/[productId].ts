import { NextApiRequest, NextApiResponse } from 'next';
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

// eslint-disable-next-line import/no-anonymous-default-export
export default async (req: NextApiRequest, res: NextApiResponse) => {
  const { productId } = req.query;
 
  if (req.method === 'PUT') {
    const {cart_id, product_id ,quantity } = req.body;
    try {
      const updatedCartItem = await prisma.cart_item.update({
        where: { product_id: Number(productId) },
        data: {
         cart_id,
         product_id,
         quantity,
          // Update other fields as needed
        },
      });
      console

      res.status(200).json(updatedCartItem );
    } catch (error) {
      console.error('Error updating category:', error);
      res.status(500).json({ message: 'Internal Server Error' });
    } finally {
      await prisma.$disconnect();
    }
  } 
  
 else {
    res.status(405).json({ message: 'Method not allowed' });
  }
};
