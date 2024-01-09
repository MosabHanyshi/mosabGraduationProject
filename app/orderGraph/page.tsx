"use client";
import React from "react";
import { Carousel } from "antd";
import { Image as AntImage } from "antd"; // Correct import

const contentStyle: React.CSSProperties = {
  display: "flex",
  justifyContent: "center",
  alignItems: "center",
  textAlign: "center",
};

const coloredDivStyle: React.CSSProperties = {
  ...contentStyle,
  height: "400px",
  background: "#364d79", // Add your desired background color here
};

const imageStyle: React.CSSProperties = {
  height: "200px",
};

const App: React.FC = () => (
  <div
    style={{
      height: "200px",
      width: "50%",
      background: "red",
      borderRadius: "10px",
    }}
  >
    <Carousel autoplay style={coloredDivStyle}>
      <div style={coloredDivStyle}>
        <AntImage
          src="/images/Arduino_Uno.jpg" // Updated path
          alt="Image 1"
          style={imageStyle}
        />
      </div>
      <div style={coloredDivStyle}>
        <AntImage
          src="/images/Arduino_Uno.jpg" // Updated path
          alt="Image 2"
          style={imageStyle}
        />
      </div>
      <div style={coloredDivStyle}>
        <AntImage
          src="/images/Arduino_Uno.jpg" // Updated path
          alt="Image 3"
          style={imageStyle}
        />
      </div>
      <div style={coloredDivStyle}>
        <AntImage
          src="/images/Arduino_Uno.jpg" // Updated path
          alt="Image 4"
          style={imageStyle}
        />
      </div>
    </Carousel>
  </div>
);

export default App;
