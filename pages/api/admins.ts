import { PrismaClient } from "@prisma/client";
import { NextApiRequest, NextApiResponse } from "next";

const prisma = new PrismaClient();

// eslint-disable-next-line import/no-anonymous-default-export
export default async (req: NextApiRequest, res: NextApiResponse) => {
  if (req.method === "GET") {
   
    try {
       
      const admins = await prisma.admins.findMany( {select: {
         admin_id: true,
         admin_name: true,
         admin_email: true,
         admin_specialists: true,
         admin_photo: true,
         admin_password:true
    // Add other fields you want to select
  },});
      res.status(200).json(admins);
      
      

    } catch (error) {
      res.status(500).json({ message: "Internal Server Error" });
      
    } finally {
      await prisma.$disconnect();
    }

  } if(req.method ==="PUT"){

    try {
      const { admin_id, admin_name, admin_email,admin_specialists,admin_photo, admin_password } = req.body;

      // Perform validation on the received data if needed

      // Update the admin in the database
      const updatedAdmin = await prisma.admins.update({
        where: { admin_id: admin_id },
        data: {
          admin_name: admin_name,
          admin_email: admin_email,
          admin_specialists:admin_specialists,
          admin_photo:admin_photo,
          admin_password:admin_password,
        },
      });

      res.status(200).json(updatedAdmin);
    } catch (error) {
      console.error("Error updating admin:", error);
      res.status(500).json({ message: "Internal Server Error" });
    } finally {
      await prisma.$disconnect();
    }
  } else {
    res.status(405).json({ message: "Method not allowed" });
  }

};
