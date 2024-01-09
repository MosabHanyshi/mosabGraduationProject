"use Client";
import * as React from "react";
import { LineChart } from "@mui/x-charts/LineChart";
import styles from "./styles.module.css";
import { useEffect , useState } from "react";
import Chart from "../orders/components/chart";


interface OrderTimeSeries {
  date: Date;
  order_count: number;
  input_count: number;
  output_count: number;
  controller_count:number;
}

export default function Payments() {

    const [ordersTimeSeries, setOrdersTimeSeries] = useState<OrderTimeSeries[]>(
      []
    );
      const [error, setError] = useState<string | null>(null);



    useEffect(() => {

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

  return (
    <div className={styles.page}>
      <h1>Payments charts</h1>
      <div className={styles.container}>
        <div className={styles.input}>
          <h2>Input devices</h2>
          <Chart data={ordersTimeSeries} category="input" />
        </div>

        <div className={styles.output}>
          <h2>Output devices</h2>
          <Chart data={ordersTimeSeries} category="output" />
        </div>

        <div className={styles.control}>
          <h2>Control devices</h2>
          <Chart data={ordersTimeSeries} category="controller" />
        </div>
      </div>
    </div>
  );
}
