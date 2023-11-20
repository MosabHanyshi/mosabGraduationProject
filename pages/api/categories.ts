import { PrismaClient } from "@prisma/client";
import { NextApiRequest, NextApiResponse } from "next";

const prisma = new PrismaClient();

// eslint-disable-next-line import/no-anonymous-default-export
export default async (req: NextApiRequest, res: NextApiResponse) => {
  if (req.method === "GET") {
    try {

  
      
      const products = await prisma.categories.findMany( {select: {

    category_id: true,
    category_name: true,
    category_description: true,
    category_image_path:true,
    
    // Add other fields you want to select
  },});
      res.status(200).json(products);
      // console.log(res.json(users));

    } catch (error) {
      res.status(500).json({ message: "Internal Server Error" });
    } finally {
      await prisma.$disconnect();
    }
  } else {
    res.status(405).json({ message: "Method not allowed" });
  }
};
