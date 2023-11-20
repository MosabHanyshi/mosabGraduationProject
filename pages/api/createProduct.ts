import { NextApiRequest, NextApiResponse } from 'next';
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

// eslint-disable-next-line import/no-anonymous-default-export
export default async (req: NextApiRequest, res: NextApiResponse) => {
 

  if (req.method === 'POST') {
    // Handle add logic
    const { product_name , product_price , product_count ,  product_category , product_img_path , product_description } = req.body;

    try {
      const newProduct = await prisma.products.create({
        data: {
        product_name , product_price , product_count ,  product_category , product_img_path , product_description
          // Add other fields as needed
        },
      });

      res.status(201).json(newProduct);
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
