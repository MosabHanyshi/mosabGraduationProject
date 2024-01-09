// pages/api/getRecommendedProducts.ts
import { NextApiRequest, NextApiResponse } from 'next';
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

// eslint-disable-next-line import/no-anonymous-default-export
export default async (req: NextApiRequest, res: NextApiResponse) => {
  if (req.method === 'GET') {
    const { userId } = req.query;
    try {
      const userIdAsNumber = parseInt(userId as string, 10);

      // Fetch user behaviors for the specified user ID
      const userBehaviors = await prisma.user_behavior.findMany({
        where: {
          user_id: userIdAsNumber,
        },
      });

      // Implement your recommendation logic based on action_type
      const recommendedProducts = await recommendProducts(userBehaviors);

      // Send the retrieved recommended products as a JSON response
      res.status(200).json(recommendedProducts);
    } catch (error) {
      // Handle errors and send a 500 Internal Server Error response
      console.error('Error fetching/recommending products:', error);
      res.status(500).json({ message: 'Internal Server Error' });
    } finally {
      // Disconnect Prisma client to release the database connection
      await prisma.$disconnect();
    }
  } else {
    // Send a 405 Method Not Allowed response for non-GET requests
    res.status(405).json({ message: 'Method not allowed' });
  }
};

// Function to implement recommendation logic based on action_type
const recommendProducts = async (userBehaviors: any[]) => {
  // Sample logic: Recommend products based on dynamic ratio for each action_type
  const recommendedProducts: number[] = [];

  // Calculate dynamic ratios based on the counts of each action_type
  const actionTypeCounts: Record<string, number> = {};

  userBehaviors.forEach((behavior) => {
    const actionType = behavior.action_type;
    actionTypeCounts[actionType] = (actionTypeCounts[actionType] || 0) + 1;
  });

  const totalActions = userBehaviors.length;

  // Loop through each unique action_type and recommend products
  for (const [actionType, count] of Object.entries(actionTypeCounts)) {
    const ratio = count / totalActions;
    const productsForType = getRandomProducts(userBehaviors, actionType, ratio);
    recommendedProducts.push(...productsForType);
  }

  // Remove any undefined values from recommendedProducts array
  const filteredRecommendedProducts = recommendedProducts.filter((productId) => productId !== undefined);

  if (filteredRecommendedProducts.length === 0) {
    // Return an empty array or handle as needed
    return [];
  }

  // Fetch product details for the recommended product IDs
  const productsDetails = await prisma.products.findMany({
    where: {
      product_id: {
        in: filteredRecommendedProducts,
      },
    },
  });

  return productsDetails;
};

// Helper function to randomly select products based on ratio for a specific action_type
const getRandomProducts = (userBehaviors: any[], actionType: string, ratio: number): number[] => {
  const products = userBehaviors
    .filter((behavior) => behavior.action_type === actionType)
    .map((behavior) => behavior.product_id);

  const numToSelect = Math.floor(products.length * ratio);
  const shuffledProducts = products.sort(() => Math.random() - 0.5);
  return shuffledProducts.slice(0, numToSelect);
};

