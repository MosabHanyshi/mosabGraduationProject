// // pages/api/createRequest.ts
import { NextApiRequest, NextApiResponse } from 'next';
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

export default async function handler(req: NextApiRequest, res: NextApiResponse) {
  if (req.method !== 'POST') {
    return res.status(405).json({ message: 'Method Not Allowed' });
  }

  const { componentName, description} = JSON.parse(req.body);

  const Component_name =componentName
  const Description =description

  try {
    const newRequest = await prisma.requests.create({
      data: {
        Component_name: componentName,
        Description: description,
      },
    });

    res.status(201).json({ success: true, data: newRequest });
  } catch (error) {
    console.error(error);
    res.status(500).json({ success: false, error: 'Internal Server Error' });
  }
}

