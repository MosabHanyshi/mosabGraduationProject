import { NextApiRequest, NextApiResponse } from 'next';
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

// eslint-disable-next-line import/no-anonymous-default-export
export default async (req: NextApiRequest, res: NextApiResponse) => {
 

  if (req.method === 'POST') {
    // Handle add logic
      const {category_id , category_name , category_description,  category_image_path } = req.body;
 
    try {
      const newCategory = await prisma.categories.create({
        data: {
         category_id , category_name , category_description , category_image_path
          // Add other fields as needed
        },
      });

      res.status(201).json(newCategory);
    } catch (error) {
      console.error('Error adding category:', error);
      res.status(500).json({ message: 'Internal Server Error' });
    } finally {
      await prisma.$disconnect();
    }
  } else {
    res.status(405).json({ message: 'Method not allowed' });
  }
};
