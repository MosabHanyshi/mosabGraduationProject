import { NextApiRequest, NextApiResponse } from 'next';
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

// eslint-disable-next-line import/no-anonymous-default-export
export default async (req: NextApiRequest, res: NextApiResponse) => {
  const { categoryId } = req.query;
  console.log(categoryId);
 
  if (req.method === 'PUT') {
    const { category_name , category_description,  category_image_path } = req.body;

    try {
      const updatedCategory = await prisma.categories.update({
        where: { category_id: Number(categoryId) },
        data: {
         category_name,
         category_description, 
         category_image_path,
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
      const deletedCategory = await prisma.categories.delete({
        where: { category_id: Number(categoryId)},
      });

      res.status(200).json(deletedCategory);
    } catch (error) {
      console.error('Error deleting category:', error);
      res.status(500).json({ message: 'Internal Server Error' });
    } finally {
      await prisma.$disconnect();
    }
  } 
  
  
  
  else if (req.method === 'POST') {
    // Handle add logic
    const { category_name , category_description,  category_image_path } = req.body;

    try {
      const newCategory = await prisma.categories.create({
        data: {
         category_name , category_description , category_image_path
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
