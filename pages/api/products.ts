import { PrismaClient } from "@prisma/client";
import { NextApiRequest, NextApiResponse } from "next";

const prisma = new PrismaClient();

// eslint-disable-next-line import/no-anonymous-default-export
export default async (req: NextApiRequest, res: NextApiResponse) => {
  if (req.method === "GET") {
    try {

      console.log('reach');
      
      const products = await prisma.products.findMany( {select: {

    product_id: true,
    product_name: true,
    product_price: true,
    product_count:true,
    product_category:true,
    product_img_path:true, 
    product_description:true,
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
