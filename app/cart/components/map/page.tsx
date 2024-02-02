// OrderForm.tsx
import React, { useEffect, useState } from 'react';
import styles from './styles.module.css';
import { LngLatLike } from 'mapbox-gl';
import mapboxgl from 'mapbox-gl';
import { Map, Marker } from "mapbox-gl";
import products from '@/pages/api/products';

interface Coordinates {
  lng: number;
  lat: number;
}

interface Order {
  phone_number: string;
  payments: string;
  user_name: string;
  total_price: number;
  latitude: number;
  longitude: number;
  inputCount: number;
  outputCount: number;
  controllerCount: number;
}

interface OrderFormProps {
  username: string; // or whatever type userId is
  payments: string;
  total_price : number;
  input_count : number;
  output_count : number;
  controller_count:number;
}

const OrderForm: React.FC<OrderFormProps> = ({
  username,
  payments,
  total_price,
  input_count,
  output_count,
  controller_count,
}) => {
  const [phoneNumber, setPhoneNumber] = useState<string>("");
  const [latitude, setLatitude] = useState<number>(0);
  const [longitude, setLongitude] = useState<number>(0);
  const [clickedCoordinates, setClickedCoordinates] =
    useState<Coordinates | null>(null);
  const [inputCount, setInputCount] = useState<number>(input_count);
  const [outputCount, setOutputCount] = useState<number>(output_count);
  const [controllerCount, setControllerCount] = useState<number>(controller_count);

  useEffect(() => {
    mapboxgl.accessToken =
      "pk.eyJ1IjoibW9zYWJoIiwiYSI6ImNscHdsdm00azBmcHIycW85MGI1dTRueDMifQ.iRciVCJToq-updYjXLaEYg";

    const map = new Map({
      container: "map", // container ID
      center: { lng: 35.3022, lat: 32.4603 }, // starting position [lng, lat]
      zoom: 9, // starting zoom
    });

    // Add click event listener to the map
    map.on(
      "click",
      (e: { preventDefault: () => void; lngLat: { lng: any; lat: any } }) => {
        e.preventDefault(); // Prevent the default map behavior

        const { lng, lat } = e.lngLat;

        // Set the clicked coordinates in state
        setClickedCoordinates({ lng, lat });
        setLatitude(lat);
        setLongitude(lng);
      }
    );

    // Cleanup when the component unmounts
    return () => {
      map.remove();
    };
  }, []);

  const createOrder = (
    editedData: Order,
    
  ) => {
    fetch(`/api/createOrder`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(editedData),
    })
      .then((response) => {
        if (!response.ok) {
          throw new Error(`HTTP error! Status: ${response.status}`);
        }
        // Handle success as needed
        return response.json();
      })
      .then((createdData) => {
        // Handle the created data
        // console.log("order created:", createdData);
      })
      .catch((error) => {
        // Handle errors
        console.error("Error creating Order:", error);
      });
  };

  return (
    <div className={styles.formContainer}>
      <form className={styles.form}>
        <div
          id="map"
          style={{
            width: "400px",
            height: "400px",
            borderRadius: "10px",
            margin: "10px",
          }}
        />
        <label className={styles.label} htmlFor="phoneNumber">
          Phone Number:
        </label>
        <input
          className={styles.inputField}
          type="tel"
          id="phoneNumber"
          name="phoneNumber"
          placeholder="Enter phone number"
          value={phoneNumber}
          onChange={(e) => setPhoneNumber(e.target.value)}
          required
        />

        <label className={styles.label} htmlFor="latitude">
          Latitude:
        </label>
        <input
          className={styles.inputField}
          type="text"
          id="latitude"
          name="latitude"
          placeholder="Enter latitude"
          value={latitude}
          onChange={(e) => setLatitude(parseFloat(e.target.value))}
          required
        />

        <label className={styles.label} htmlFor="longitude">
          Longitude:
        </label>
        <input
          className={styles.inputField}
          type="text"
          id="longitude"
          name="longitude"
          placeholder="Enter longitude"
          value={longitude}
          onChange={(e) => setLongitude(parseFloat(e.target.value))}
          required
        />

        <button
          className={styles.submitButton}
          type="button"
          onClick={() =>
            createOrder(
              {
                phone_number: phoneNumber,
                payments: payments,
                user_name: username,
                total_price: total_price,
                latitude: latitude,
                longitude: longitude,
                inputCount: input_count,
                outputCount: output_count,
                controllerCount: controller_count,
              },
  
            )
          }
        >
          Submit Order
        </button>
      </form>
    </div>
  );
};

export default OrderForm;

