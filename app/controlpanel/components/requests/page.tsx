"use Client";
import * as React from "react";
import { LineChart } from "@mui/x-charts/LineChart";
import styles from "./styles.module.css";

export default function Profits() {
  return (
    <div className={styles.page}>
      <h1>Requests</h1>
      <div className={styles.container}>

        <div className={styles.requests}>the first request</div>

        <div className={styles.requests}>the second request</div>

        <div className={styles.requests}>the third request</div>

      </div>
    </div>
  );
}
