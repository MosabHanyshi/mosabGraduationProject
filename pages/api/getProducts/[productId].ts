// import { PrismaClient } from "@prisma/client";
// import { NextApiRequest, NextApiResponse } from "next";

// const prisma = new PrismaClient();

// // eslint-disable-next-line import/no-anonymous-default-export
// export default async (req: NextApiRequest, res: NextApiResponse) => {

//   const {productId }= req.query ;
//   console.log(req.query);  

//   if (req.method === "GET") {

     
//     try {
//       const product = await prisma.products.findFirst( { where: {
//            product_id : productId
//         },});
      
//       res.status(200).json(product);

//     } catch (error) {
//       res.status(500).json({ message: "Internal Server Error" });
//     } finally {
//       await prisma.$disconnect();
//     }
//   } else {
//     res.status(405).json({ message: "Method not allowed" });
//   }
// };


import { PrismaClient } from "@prisma/client";
import { NextApiRequest, NextApiResponse } from "next";

const prisma = new PrismaClient();

// eslint-disable-next-line import/no-anonymous-default-export
export default async (req: NextApiRequest, res: NextApiResponse) => {
  const productId = typeof req.query.productId === 'string' ? req.query.productId : undefined;
  

  if (req.method === "GET") {
    try {
      const product = await prisma.products.findFirst({
        where: {
          product_id: parseInt(""+productId),
        },
      });

      res.status(200).json(product);
    } catch (error) {
      console.error("Error fetching product:", error);
      res.status(500).json({ message: "Internal Server Error" });
    } finally {
      await prisma.$disconnect();
    }
  } else {
    res.status(405).json({ message: "Method not allowed" });
  }
};
