"use Client";
import * as React from "react";
import { LineChart } from "@mui/x-charts/LineChart";
import styles from "./styles.module.css";
import { useEffect , useState } from "react";
import Chart from "../orders/components/chart";
import dayjs, { Dayjs } from "dayjs";
import { DatePicker, LocalizationProvider } from "@mui/x-date-pickers";
import { AdapterDayjs } from "@mui/x-date-pickers/AdapterDayjs";
import { DemoContainer } from "@mui/x-date-pickers/internals/demo";


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
  const [selectedDate, setSelectedDate] = React.useState<Dayjs>(
    dayjs("2023-12")
  );

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
  }, [selectedDate]); 


   const handleDateChange = (date: Dayjs | null) => {
     if (date) {
       setSelectedDate(date);
     }
   };

  return (
    <div className={styles.page}>
      <div className={styles.header}>
        <h1>Payments charts</h1>

        <div className={styles.calenderContainer}>
          <LocalizationProvider dateAdapter={AdapterDayjs}>
            <DemoContainer components={["DatePicker"]}>
              <DatePicker
                defaultValue={selectedDate}
                views={["year", "month"]}
                onChange={handleDateChange}
                className={styles.customDatePicker}
              />
            </DemoContainer>
          </LocalizationProvider>
        </div>
      </div>

      <div className={styles.container}>
        <div className={styles.input}>
          <Chart data={ordersTimeSeries} category="input" />
        </div>

        <div className={styles.output}>
          <Chart data={ordersTimeSeries} category="output" />
        </div>

        <div className={styles.control}>
          <Chart data={ordersTimeSeries} category="controller" />
        </div>
      </div>
    </div>
  );
}
function setLoading(arg0: boolean) {
  throw new Error("Function not implemented.");
}

