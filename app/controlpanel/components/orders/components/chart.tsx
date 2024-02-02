"use client"
import { LineChart } from "@mui/x-charts/LineChart";
import React, { useEffect, useState } from "react";

import {
  VictoryChart,
  VictoryLine,
  VictoryZoomContainer,
  VictoryBrushContainer,
  VictoryAxis,
} from "victory";

interface OrderTimeSeries {
  date: Date;
  order_count: number;
  input_count: number;
  output_count: number;
  controller_count: number;
}

interface ChartProps {
  data: OrderTimeSeries[];
  category: string;
}

const Chart: React.FC<ChartProps> = ( {data, category} ) => {
  const [numbers, setNumbers] = useState<number[]>([]);
  const [dates, setDates] = useState<number[]>([]);
  const [month, setMonth] = useState<string>('');

   useEffect(() => {
     const fetchData = async () => {
       try {
         // Run your functions here
         const datesDataPromise = getDates(data);
         const valuesDataPromise = getValues(data, category);

         // Wait for promises to resolve
         const datesData =  datesDataPromise;
         const valuesData = valuesDataPromise;

         // Set the state outside the functions
         setDates(datesData);
         setNumbers(valuesData);

       } catch (error) {
         console.error("Error fetching data:", error);
         // Handle errors if needed
       }
     };

     fetchData();
   }, [data, category]);


  
 const getDates =  (data: OrderTimeSeries[]) => {


    let dateStrings: string[] = [];
    let days: number[] = [];

    data.forEach((point) => {
      // Assuming point.date is a string
      if (typeof point.date === "string") {
        dateStrings.push(point.date);
      }
    });

    dateStrings.map((date)=>{
 
        days.push(parseInt(date.split("T")[0].split("-")[2]));

    });

    return days;
 };

  const getValues =(

    data: OrderTimeSeries[],
    category: string
   
  ) => {
    let counts: number[] = [];

    switch (category) {
      case "input":
        counts = data.map((point) => point.input_count);
        break;

      case "output":
        counts = data.map((point) => point.output_count);
        break;

      case "controller":
        counts = data.map((point) => point.controller_count);
        break;

      default:
        counts = data.map((point) => point.order_count);
        break;
    }
    return counts;
  };

  return (
    <>
      <div>
        <h1>{category} devices</h1>
      </div>
      <div>
        {dates.length > 0 ? (
          <LineChart
            xAxis={[
              {
                data: dates,
                id: "x-axis",
              },
            ]}
            series={[
              {
                // data: numbers,
                data: numbers,
              },
            ]}
            width={1000}
            height={500}
          />
        ) : (
          <LineChart
            xAxis={[
              {
                data: [1, 2, 3, 4, 5, 6, 7],
                id: "x-axis",
              },
            ]}
            series={[
              {
                // data: numbers,
                data: [0, 0, 0, 0, 0, 0, 0],
              },
            ]}
            width={1000}
            height={500}
          />
        )}
      </div>
    </>
  );
};

export default Chart;




