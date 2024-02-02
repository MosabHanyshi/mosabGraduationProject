"use Client";
import * as React from "react";
import { LineChart } from "@mui/x-charts/LineChart";
import styles from "./styles.module.css";
import { useEffect, useState } from "react";

interface Request {

  Component_name : string;
  Description:string;

}

export default function requests() {

  const [requests,setRequests] = useState<Request[]>([])
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    // Fetch orders
    fetch("/api/getRequests")
      .then((response) => {
        if (!response.ok) {
          throw new Error(`Network response was not ok: ${response.status}`);
        }
        return response.json();
      })
      .then((data) => {
        if (Array.isArray(data)) {
          setRequests(data);
        } else {
          setError("Data received is not an array");
        }
      })
      .catch((error) => {
        console.error("Error fetching orders:", error);
        setError("Error fetching data");
      });

  }, []);

  return (
    <div className={styles.page}>
      <h1>Requests</h1>
      <div className={styles.container}>

      {requests.map((request, index) => (
        
        <div className={styles.requests}>
            <p>{`Component Name : ${request.Component_name}`}</p>
            <p>{`Description : ${request.Description}`}</p>
          </div>
        ))}
        </div>
      </div>
  );
}
