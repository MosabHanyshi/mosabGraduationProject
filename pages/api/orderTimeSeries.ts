// pages/api/ordersTimeSeries.ts
import { NextApiRequest, NextApiResponse } from 'next';
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

// eslint-disable-next-line import/no-anonymous-default-export
export default async (req: NextApiRequest, res: NextApiResponse) => {
  if (req.method === 'GET') {
    try {
      const ordersTimeSeries = await prisma.orders_time_series.findMany({
        orderBy: {
          date: 'asc', // Adjust the order as needed
        },
      });

      res.status(200).json(ordersTimeSeries);
    } catch (error) {
      console.error('Error fetching orders time series data:', error);
      res.status(500).json({ message: 'Internal Server Error' });
    } finally {
      await prisma.$disconnect();
    }
  } else {
    res.status(405).json({ message: 'Method not allowed' });
  }
};
