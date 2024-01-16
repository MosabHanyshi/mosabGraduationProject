"use client"
import { useEffect, useState } from "react";
import io from "socket.io-client";
import styles from "./styles.module.css";
import Chart from "./components/chart";
import dayjs, { Dayjs } from "dayjs";
import { DemoContainer } from "@mui/x-date-pickers/internals/demo";
import { AdapterDayjs } from "@mui/x-date-pickers/AdapterDayjs";
import { LocalizationProvider } from "@mui/x-date-pickers/LocalizationProvider";
import { DatePicker } from "@mui/x-date-pickers/DatePicker";
import React from "react";

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
  const [selectedDate, setSelectedDate] = React.useState<Dayjs>(dayjs("2023-12"));
  const [orders, setOrders] = useState<Order[]>([]);
  const [ordersTimeSeries, setOrdersTimeSeries] = useState<OrderTimeSeries[]>(
    []
  );
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

  }, []);

  useEffect(() => {
    const fetchOrdersTimeSeries = async () => {
      try {
        const response = await fetch(
          `/api/getOrderTimeSeries/${selectedDate.format("YYYY-MM")}`
        );

        if (!response.ok) {
          throw new Error(`Failed to fetch data. Status: ${response.status}`);
        }

        const result = await response.json();
        setOrdersTimeSeries(result);
        setLoading(false);
      } catch (err: unknown) {
        if (err instanceof Error) {
          setError(err.message);
        } else {
          setError("An error occurred while fetching data.");
        }
        setLoading(false);
      }
    };

    fetchOrdersTimeSeries();
  }, [selectedDate]); // Ensure the effect runs only once on component mount

  const handleDateChange = (date: Dayjs | null) => {
    if (date) {
      setSelectedDate(date);
    }
  };

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


  return (
    <div>
      <h1>Orders</h1>

      <div className={styles.calenderContainer}>
        <LocalizationProvider dateAdapter={AdapterDayjs}>
          <DemoContainer components={["DatePicker"]}>
            <DatePicker
              defaultValue={selectedDate}
              views={["year", "month"]}
              onChange={handleDateChange}
            />
          </DemoContainer>
        </LocalizationProvider>
        <h1>{selectedDate.format("YYYY-MM")}</h1>
      </div>

      <div>
        <div style={{ width: "80%", margin: "auto" }}>
          <Chart data={ordersTimeSeries} category={"order"} />
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
