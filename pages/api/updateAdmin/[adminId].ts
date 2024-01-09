import { NextApiRequest, NextApiResponse } from 'next';
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

// eslint-disable-next-line import/no-anonymous-default-export
export default async (req: NextApiRequest, res: NextApiResponse) => {
  const { adminId } = req.query;
 
  if (req.method === 'PUT') {
    const { admin_id, admin_name, admin_email,admin_specialists,admin_photo, admin_password } = req.body;

    try {
      const updatedAdmin = await prisma.admins.update({
        where: { admin_id: Number(adminId) },
        data: {
          admin_id,
          admin_name,
          admin_email,
          admin_specialists,
          admin_photo,
          admin_password,
          // Update other fields as needed
        },
      });

      res.status(200).json(updatedAdmin);
    } catch (error) {
      console.error('Error updating admin:', error);
      res.status(500).json({ message: 'Internal Server Error' });
    } finally {
      await prisma.$disconnect();
    }
  } else if (req.method === 'DELETE') {
    try {
      const deletedAdmin = await prisma.admins.delete({
        where: { admin_id: Number(adminId)},
      });

      res.status(200).json({deletedAdmin,revalidate: 0.1});
    } catch (error) {
      console.error('Error deleting admin:', error);
      res.status(500).json({ message: 'Internal Server Error' });
    } finally {
      await prisma.$disconnect();
    }
  } 
  
   else {
    res.status(405).json({ message: 'Method not allowed' });
  }
};
