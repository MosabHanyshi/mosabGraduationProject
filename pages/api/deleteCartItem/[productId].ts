import { NextApiRequest, NextApiResponse } from 'next';
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

// eslint-disable-next-line import/no-anonymous-default-export
export default async (req: NextApiRequest, res: NextApiResponse) => {
  const { productId } = req.query;
 
   if (req.method === 'DELETE') {
    try {
      const deletedCartItem = await prisma.cart_item.delete({
        where: { product_id: Number(productId)},
      });
      console.log('deleted');
      res.status(200).json(deletedCartItem);
    } catch (error) {
      console.error('Error deleting category:', error);
      res.status(500).json({ message: 'Internal Server Error' });
    } finally {
      await prisma.$disconnect();
    }
  } 
  
 else {
    res.status(405).json({ message: 'Method not allowed' });
  }
};
