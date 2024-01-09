"use Client";
import * as React from "react";
import { LineChart } from "@mui/x-charts/LineChart";
import styles from "./styles.module.css";

export default function Profits() {
  return (
    <div className={styles.page}>
      <h1>Profits charts</h1>
      <div className={styles.container}>
        <div className={styles.input}>
          <h2>Input devices</h2>
          <LineChart
            xAxis={[{ data: [1, 2, 3, 5, 8, 10] }]}
            series={[
              {
                data: [2, 5.5, 2, 8.5, 1.5, 5],
              },
            ]}
            width={500}
            height={300}
          />
        </div>

        <div className={styles.output}>
          <h2>Output devices</h2>
          <LineChart
            xAxis={[{ data: [1, 2, 3, 5, 8, 10] }]}
            series={[
              {
                data: [2, 5.5, 2, 8.5, 1.5, 5],
              },
            ]}
            width={500}
            height={300}
          />
        </div>

        <div className={styles.control}>
          <h2>Control devices</h2>
          <LineChart
            xAxis={[{ data: [1, 2, 3, 5, 8, 10] }]}
            series={[
              {
                data: [2, 5.5, 2, 8.5, 1.5, 5],
              },
            ]}
            width={500}
            height={300}
          />
        </div>

        <div>
          <h2>motor devices</h2>
          <LineChart
            xAxis={[{ data: [1, 2, 3, 5, 8, 10] }]}
            series={[
              {
                data: [2, 5.5, 2, 8.5, 1.5, 5],
              },
            ]}
            width={500}
            height={300}
          />
        </div>
      </div>
    </div>
  );
}
