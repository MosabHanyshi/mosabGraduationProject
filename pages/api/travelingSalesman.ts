// pages/api/travelingSalesman.ts

import type { NextApiRequest, NextApiResponse } from 'next';

interface Order {
  order_id: number;
  phone_number: string;
  payments: string;
  user_name: string;
  total_price: number;
  latitude: number;
  longitude: number;
  created_at: Date;
  value: number;
}

class TravelingSalesman {
  private points: Order[];

  constructor(points: Order[]) {
    this.points = points;
  }

  private calculateDistance(point1: Order, point2: Order): number {

    const lat1 = point1.latitude;
    const lon1 = point1.longitude;
    const lat2 = point2.latitude;
    const lon2 = point2.longitude;

    const R = 6371; // Earth radius in kilometers
    const dLat = this.degToRad(lat2 - lat1);
    const dLon = this.degToRad(lon2 - lon1);
    const a =
      Math.sin(dLat / 2) * Math.sin(dLat / 2) +
      Math.cos(this.degToRad(lat1)) * Math.cos(this.degToRad(lat2)) * Math.sin(dLon / 2) * Math.sin(dLon / 2);
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    const distance = R * c;

    return distance;
    
  }

  private degToRad(deg: number): number {
   return deg * (Math.PI / 180);
  }

  private findNearestNeighbor(currentIndex: number, unvisited: Set<number>): number {
    let minDistance = Number.MAX_VALUE;
    let nearestNeighbor = -1;

    for (const nextIndex of unvisited) {
      const distance = this.calculateDistance(this.points[currentIndex], this.points[nextIndex]);
      if (distance < minDistance) {
        minDistance = distance;
        nearestNeighbor = nextIndex;
      }
    }

    return nearestNeighbor;
  }

  findShortestPath(): Order[] {
     const n = this.points.length;
    const unvisited = new Set([...Array(n).keys()]);
    const path: Order[] = [];
    let currentIndex = 0;

    while (unvisited.size > 0) {
      path.push(this.points[currentIndex]);
      unvisited.delete(currentIndex);

      const nearestNeighbor = this.findNearestNeighbor(currentIndex, unvisited);
      currentIndex = nearestNeighbor;
    }

    path.push(path[0]); // Complete the loop

    return path;
  }
}

export default async function handler(req: NextApiRequest, res: NextApiResponse) {
  if (req.method === 'POST') {
    const points: Order[] = req.body.points; // Assuming points are passed in the request body
    const salesman = new TravelingSalesman(points);
    const shortestPath = salesman.findShortestPath();

    res.status(200).json({ shortestPath });
  } else {
    res.status(405).json({ message: 'Method not allowed' });
  }
}
