import { NextApiRequest, NextApiResponse } from 'next';
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

// eslint-disable-next-line import/no-anonymous-default-export
export default async (req: NextApiRequest, res: NextApiResponse) => {
  if (req.method === 'POST') {
    // Handle add logic
    const { phone_number, payments, user_name, total_price, latitude, longitude ,inputCount,outputCount,controllerCount } = req.body;



    try {
      // Create a new order in the 'orders' table
      const newOrder = await prisma.orders.create({
        data: {
          phone_number,
          payments,
          user_name,
          total_price,
          latitude,
          longitude,
        },
      });

      // Create or update the corresponding entry in the 'orders_time_series' table
      const currentDate = new Date();
      const formattedCurrentDate = currentDate.toISOString()

      try {
        const existingOrder = await prisma.orders_time_series.findUnique({
          where: {
            date: formattedCurrentDate,
          },
        });

        if (existingOrder) {

          const updatedOrder = await prisma.orders_time_series.update({
            where: {
              date: formattedCurrentDate,
            },
            data: {
              order_count: {
                increment: 1,
              },

              input_count: {
                increment: inputCount,
              },

              output_count: {
                increment: outputCount,
              },

              controller_count: {
                increment: controllerCount,
              },
            },
          });

        console.log("input count :",inputCount)
        console.log("output count :",outputCount)
        console.log("controller count :",controllerCount)
          // console.log('Order count updated for the current date:', updatedOrder);
        } else {
          // If the record doesn't exist, create a new record with order_count set to 1
          const newOrderTimeSeries = await prisma.orders_time_series.create({
            data: {
              date: formattedCurrentDate,
              order_count: 1,
              // Other fields...
            },
          });
        
          
        }

        // Respond with the created order
        res.status(201).json(newOrder);
      } catch (error) {
        console.error('Error adding order:', error);
        res.status(500).json({ message: 'Internal Server Error' });
      } finally {
        await prisma.$disconnect();
      }
    } catch (error) {
      console.error('Error creating order:', error);
      res.status(500).json({ message: 'Internal Server Error' });
    }
  } else {
    res.status(405).json({ message: 'Method not allowed' });
  }
};
