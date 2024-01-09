import React, { useState } from "react";
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

interface ChartState {
  selectedDomain?: { x: [Date, Date] };
  zoomDomain?: { x: [Date, Date] };
}

interface XYDomain {
  x: [Date, Date];
  y: [number, number];
}

const Chart: React.FC<ChartProps> = ( {data, category} ) => {
  const [chartState, setChartState] = useState<ChartState>({});

  const handleZoom = (domain: any) => {
    setChartState((prev) => ({ ...prev, selectedDomain: domain }));
  };

  const handleBrush = (domain: XYDomain) => {
    setChartState((prev) => ({ ...prev, zoomDomain: domain }));
  };



  const dateFormate = (x:Date) => {

    const date = new Date(x);
    const year = date.getFullYear().toString().slice(2);
    const month = (date.getMonth() + 1).toString().padStart(2, "0");
    const day = date.getDate().toString().padStart(2, "0");
    return `${year}/${month}/${day}`;

  }

  const renderDataForCategory = () => {
    switch (category) {
      case "input":
        return data.map((point) => ({
          x: point.date,
          y: point.input_count,
        }));
      case "output":
        // Handle other categories if needed
        return data.map((point) => ({
          x: point.date,
          y: point.output_count, // Update to the appropriate property for output category
        }));

      case "controller":
        // Handle other categories if needed
        return data.map((point) => ({
          x: point.date,
          y: point.controller_count, // Update to the appropriate property for output category
        }));

      default:
        return data.map((point) => ({
          x: point.date,
          y: point.order_count,
        }));
    }
  };

  return (
    <div>
      <VictoryChart
        width={550}
        height={300}
        scale={{ x: "time" }}
        containerComponent={
          <VictoryZoomContainer
            responsive={false}
            zoomDimension="x"
            zoomDomain={chartState.zoomDomain}
            onZoomDomainChange={handleZoom}
          />
        }
      >
        <VictoryLine
          style={{
            data: { stroke: "#39A7FF" },
          }}
          data={renderDataForCategory()}
        />
      </VictoryChart>

      <VictoryChart
        height={90}
        scale={{ x: "time" }}
        padding={{ top: 10, left: 0, right: 0, bottom: 30 }}
        containerComponent={
          <VictoryBrushContainer
            responsive={true}
            brushDimension="x"
            brushDomain={chartState.selectedDomain}
            onBrushDomainChange={handleBrush}
          />
        }
      >
        <VictoryAxis
          tickValues={data.map((point) => point.date)}
          tickFormat={(x) =>
            new Date(x).toLocaleDateString("en-US", { timeZone: "UTC" })
          }
        />
        <VictoryLine
          style={{
            data: { stroke: "#39A7FF" },
          }}
          data={renderDataForCategory()}
        />
      </VictoryChart>
    </div>
  );
};

export default Chart;
