"use client"
// pages/profits.tsx
import { useEffect, useState } from "react";
import io from "socket.io-client";
// import { Line } from "react-chartjs-2";
import styles from "./styles.module.css";
import Chart from "./components/chart";

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


interface OrderTimeSeries {
  date: Date;
  order_count: number;
  input_count: number;
  output_count: number;
  controller_count: number;
}

export default function Profits() {
  const [orders, setOrders] = useState<Order[]>([]);
  const [ordersTimeSeries, setOrdersTimeSeries] = useState<OrderTimeSeries[]>([]);
  const [shortestPath, setShortestPath] = useState<Order[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    // Fetch orders
    fetch("/api/orders/")
      .then((response) => {
        if (!response.ok) {
          throw new Error(`Network response was not ok: ${response.status}`);
        }
        return response.json();
      })
      .then((data) => {
        if (Array.isArray(data)) {
          setOrders(data);
        } else {
          setError("Data received is not an array");
        }
      })
      .catch((error) => {
        console.error("Error fetching orders:", error);
        setError("Error fetching data");
      });

    // Fetch order_time_series
    const fetchData = async () => {
      try {
        const response = await fetch("/api/orderTimeSeries");
        const data = await response.json();
        setOrdersTimeSeries(data);
      } catch (error) {
        console.error("Error fetching data:", error);
      }
    };

    fetchData();
  }, []);


   const calculateShortestPath = async (points: Order[]) => {
     try {
       setLoading(true);
       const response = await fetch("/api/travelingSalesman", {
         method: "POST",
         headers: {
           "Content-Type": "application/json",
         },
         body: JSON.stringify({ points }),
       });

       if (response.ok) {
         const data = await response.json();
         setShortestPath(data.shortestPath);
       } else {
         console.error("Failed to calculate shortest path");
       }
     } catch (error) {
       console.error("Error:", error);
     } finally {
       setLoading(false);
     }
   };

    const handleCalculate = () => {
    calculateShortestPath(orders);
  };




  function haversineDistance(
    lat1: number,
    lon1: number,
    lat2: number,
    lon2: number
  ): number {
    // Convert latitude and longitude from degrees to radians
    const toRadians = (angle: number) => (angle * Math.PI) / 180;
    const dLat = toRadians(lat2 - lat1);
    const dLon = toRadians(lon2 - lon1);

    // Haversine formula
    const a =
      Math.sin(dLat / 2) * Math.sin(dLat / 2) +
      Math.cos(toRadians(lat1)) *
        Math.cos(toRadians(lat2)) *
        Math.sin(dLon / 2) *
        Math.sin(dLon / 2);

    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

    // Radius of the Earth in kilometers (mean value)
    const R = 6371;

    // Calculate the distance
    const distance = R * c;

    return distance;
  }






  // Prepare data for Chart.js
const chartData = {
  labels: ordersTimeSeries.map((order) => {
    const dateObject = new Date(order.date);
    return dateObject.toLocaleDateString();
  }),
  datasets: [
    {
      label: "Order Count",
      data: ordersTimeSeries.map((order) => order.order_count),
      fill: false,
      borderColor: "rgb(75, 192, 192)",
      tension: 0.1,
    },
  ],
};

const chartOptions = {
  scales: {
    y: {
      min: 0,
    },
  },
};

  return (
    <div>
      <h1>Orders</h1>
      <h2>Location of store : 32.407967548166255 , 35.272159931126055</h2>

      <div>
        {/* Display live chart using ordersTimeSeries data */}
        <div style={{ width: "80%", margin: "auto" }}>
          {/* <Line data={chartData} options={chartOptions} /> */}
          <Chart data={ordersTimeSeries} category={"input"} />
        </div>
      </div>

      <button onClick={handleCalculate} disabled={loading}>
        Calculate Shortest Path
      </button>

      <div className={styles.container}>
        {shortestPath.map((point, index) => (
          <div key={index} className={styles.orders}>
            <p>{`name : ${point.user_name}`}</p>
            <p>{`phone : ${point.phone_number}`}</p>
            <p>{`order_id : ${point.order_id}`}</p>
            {/* <p>{`value : ${point.latitude}`}</p> */}
          </div>
        ))}
      </div>
    </div>
  );
}
