import { PrismaClient } from "@prisma/client";
import { NextApiRequest, NextApiResponse } from "next";

const prisma = new PrismaClient();

// eslint-disable-next-line import/no-anonymous-default-export
export default async (req: NextApiRequest, res: NextApiResponse) => {
  if (req.method === "GET") {
    try {
      
      const users = await prisma.users.findMany( {select: {
         user_id: true,
         user_name: true,
         user_email: true,
         user_password:true
    // Add other fields you want to select
  },});
      res.status(200).json(users);
      // console.log(res.json(users));

    } catch (error) {
      res.status(500).json({ message: "Internal Server Error" });
    } finally {
      await prisma.$disconnect();
    }
  } if(req.method ==="PUT"){

    try {
      const { user_id, user_name, user_email, user_password } = req.body;

      // Perform validation on the received data if needed

      // Update the user in the database
      const updatedUser = await prisma.users.update({
        where: { user_id: user_id },
        data: {
          user_name: user_name,
          user_email: user_email,
          user_password: user_password,
          // Update other fields as needed
        },
      });

      res.status(200).json(updatedUser);
    } catch (error) {
      console.error("Error updating user:", error);
      res.status(500).json({ message: "Internal Server Error" });
    } finally {
      await prisma.$disconnect();
    }
  } else {
    res.status(405).json({ message: "Method not allowed" });
  }


};
