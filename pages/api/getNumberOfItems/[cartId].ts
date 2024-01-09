import { PrismaClient } from "@prisma/client";
import { NextApiRequest, NextApiResponse } from "next";

const prisma = new PrismaClient();

// eslint-disable-next-line import/no-anonymous-default-export
export default async (req: NextApiRequest, res: NextApiResponse) => {
  const { cartId } = req.query;
  
  if (req.method === "GET") {
    try {
      // Check if cartId is a valid integer
      const parsedCartId = parseInt(cartId as string, 10);

      if (isNaN(parsedCartId)) {
        // Handle the case where cartId is not a valid integer
        res.status(400).json({ message: "Invalid cartId" });
        return;
      }

      const cartItemCount = await prisma.cart_item.count({
        where: {
          cart_id: parsedCartId,
        },
      });

      res.status(200).json({ cartItemCount });
    } catch (error) {
      console.error("Error:", error);
      res.status(500).json({ message: "Internal Server Error" });
    } finally {
      await prisma.$disconnect();
    }
  } else {
    res.status(405).json({ message: "Method Not Allowed" });
  }
};
