import { NextApiRequest, NextApiResponse } from 'next';
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

// eslint-disable-next-line import/no-anonymous-default-export
export default async (req: NextApiRequest, res: NextApiResponse) => {
  const { cartId } = req.query;
 
  if (req.method === 'PUT') {
    const { cart_id ,user_id  } = req.body;

    try {
      const updatedCategory = await prisma.cart.update({
        where: { cart_id: Number(cartId) },
        data: {

         cart_id,
         user_id, 
         
          // Update other fields as needed
        },
      });

      res.status(200).json(updatedCategory);
    } catch (error) {
      console.error('Error updating category:', error);
      res.status(500).json({ message: 'Internal Server Error' });
    } finally {
      await prisma.$disconnect();
    }
  } else if (req.method === 'DELETE') {
    try {
      const deletedCart = await prisma.cart.delete({
        where: { cart_id: Number(cartId)},
      });

      res.status(200).json(deletedCart);
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
