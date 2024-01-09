import { PrismaClient } from "@prisma/client";
import { NextApiRequest, NextApiResponse } from "next";

const prisma = new PrismaClient();

// eslint-disable-next-line import/no-anonymous-default-export
export default async (req: NextApiRequest, res: NextApiResponse) => {
  if (req.method === "GET") {
    try {   
        
    const orders = await prisma.orders.findMany( {select: {

    order_id: true,
    phone_number: true,
    payments:true,
    user_name:true, 
    total_price:true,
    latitude: true,
    longitude:true,
    created_at:true
    // Add other fields you want to select
  },});
      res.status(200).json(orders);
      
    } catch (error) {
      res.status(500).json({ message: "Internal Server Error" });
    } finally {
      await prisma.$disconnect();
    }
  } else {
    res.status(405).json({ message: "Method not allowed" });
  }
};
