import { NextApiRequest, NextApiResponse } from 'next';
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

// eslint-disable-next-line import/no-anonymous-default-export
export default async (req: NextApiRequest, res: NextApiResponse) => {
  const { productId } = req.query;

  if (req.method === 'PUT') {
    const { product_name , product_price , product_count ,  product_category , product_img_path , product_description } = req.body;

    try {
      const updatedProduct = await prisma.products.update({
        where: { product_id: Number(productId) },
        data: {
        product_name,
        product_price, 
        product_count : { set: parseInt(product_count) },
        product_category,
        product_img_path,
        product_description,
          // Update other fields as needed
        },
      });

      res.status(200).json(updatedProduct);
    } catch (error) {
      console.error('Error updating product:', error);
      res.status(500).json({ message: 'Internal Server Error' });
    } finally {
      await prisma.$disconnect();
    }
  } else if (req.method === 'DELETE') {
    try {
      const deletedProduct = await prisma.products.delete({
        where: { product_id: Number(productId) },
      });

      res.status(200).json(deletedProduct);
    } catch (error) {
      console.error('Error deleting product:', error);
      res.status(500).json({ message: 'Internal Server Error' });
    } finally {
      await prisma.$disconnect();
    }
  } 
  
  
  
  else if (req.method === 'POST') {
    // Handle add logic
    const { product_name , product_price , product_count ,  product_category , product_img_path , product_description } = req.body;
    
    const profit = 0
    const discount_percentage = 0.0
    try {
      const newProduct = await prisma.products.create({
        data: {
        product_name , product_price , product_count ,  product_category , product_img_path , product_description , discount_percentage , profit
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
