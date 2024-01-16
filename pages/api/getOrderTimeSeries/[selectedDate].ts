// pages/api/ordersTimeSeries.ts
import { NextApiRequest, NextApiResponse } from 'next';
import { PrismaClient } from '@prisma/client';
import { Dayjs } from 'dayjs';

const prisma = new PrismaClient();

// eslint-disable-next-line import/no-anonymous-default-export
export default async (req: NextApiRequest, res: NextApiResponse) => {
  if (req.method === 'GET') {
    try {
      const selectedDate = req.query.selectedDate as string | undefined;

      if (!selectedDate) {
        return res.status(400).json({ message: 'Parameter selectedDate is required.' });
      }

      // Extract year and month from selectedDate
      const [year, month] = selectedDate.split('-').map(Number);


      if (isNaN(year) || isNaN(month)) {
        return res.status(400).json({ message: 'Invalid selectedDate format. Use YYYY-MM.' });
      }

      const startDate = new Date(year, month-1, 1);
      const endDate = new Date(year, month, 1);  

      const ordersTimeSeries = await prisma.orders_time_series.findMany({
        where: {
          date: {
            gte: startDate,
            lte: endDate,
          },
        },
        orderBy: {
          date: 'asc',
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
