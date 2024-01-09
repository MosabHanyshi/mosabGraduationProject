"use client"
import React, { useEffect, useState } from "react";
import Link from "next/link";
// import { UserButton } from "@clerk/nextjs";
// import { useUser } from "@clerk/nextjs";
import SupervisedUserCircleRoundedIcon from "@mui/icons-material/SupervisedUserCircleRounded";
import HomeRoundedIcon from "@mui/icons-material/HomeRounded";
import CategoryRoundedIcon from '@mui/icons-material/CategoryRounded';
import ContactPageRoundedIcon from "@mui/icons-material/ContactPageRounded";
import InfoIcon from "@mui/icons-material/Info";
import ShoppingCartRoundedIcon from "@mui/icons-material/ShoppingCartRounded";
import { useStateValue } from "../context/StateContext";


import styles from './styles.module.css';
import { StateProvider } from "../context/StateContext";



interface NavComponentProps {
  message: string;
}

function NavComponent({ message }: NavComponentProps): React.JSX.Element {

const [count , setCount] = useState(0);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await fetch(`/api/getNumberOfItems/${2}`);

        if (!response.ok) {
          throw new Error(`Network response was not ok: ${response.status}`);
        }

        const data = await response.json();

        if (data && data.cartItemCount !== undefined) {

          const numberWithinResponse = data.cartItemCount;
          setCount(data.cartItemCount);
          // Do something with the numberWithinResponse
        } else {
          setError("Unexpected data structure in the response");
        }
      } catch (error) {
        console.error("Error fetching data:", error);
        setError("Error fetching data");
      }
    };

    fetchData();
    // const intervalId = setInterval(fetchData, 100);

  }, []);

  
 

  var admin: boolean = false;

  if(message===""){
   admin = true;
  }
  return (
    
    <div style={{margin:'10px'}}>
      <p>{message}</p>
      <nav
        style={{
          width: "100%",
          background: "#39A7FF",
          fontSize: "20px",
          display: "flex",
          color: "white",
          margin: "5px",
          borderRadius: "5px",
        }}
      >
        <ul style={{ listStyle: "none", margin: 0, padding: 0, width: "100%" }}>
          {admin ? (
            <li style={{ marginRight: "10px", float: "left" }}>
              <Link style={{ margin: "5px" }} href="./controlpanel">
                <SupervisedUserCircleRoundedIcon /> Control panel
              </Link>
            </li>
          ) : null}

          <li style={{ marginRight: "10px", float: "left" }}>
            <Link style={{ margin: "5px" }} href="./home">
              <HomeRoundedIcon /> Home
            </Link>
          </li>

          <li style={{ marginRight: "10px", float: "left" }}>
            <Link style={{ margin: "5px" }} href="./categories">
              <CategoryRoundedIcon /> Categories
            </Link>
          </li>

          <li style={{ marginRight: "10px", float: "left" }}>
            <Link style={{ margin: "5px" }} href="./products">
              <CategoryRoundedIcon />
              Products
            </Link>
          </li>

          <li style={{ marginRight: "10px", float: "left" }}>
            <Link style={{ margin: "5px" }} href="./about">
              <InfoIcon />
              About
            </Link>
          </li>

          <li style={{ marginRight: "10px", float: "left" }}>
            <Link style={{ margin: "5px" }} href="./contact">
              <ContactPageRoundedIcon /> Contact
            </Link>
          </li>

          <li style={{ marginRight: "10px", float: "left" }}>
            <Link style={{ margin: "5px" }} href="./requests">
              Requests
            </Link>
          </li>

          <li style={{ marginRight: "10px", float: "left" }}>
            <Link style={{ margin: "5px" }} href="./cart">
              <ShoppingCartRoundedIcon /> Your Cart
              <a href="#" className={styles.notification}>
                <span className={styles.badge}>{count}</span>
              </a>
            </Link>
          </li>

          <li style={{ float: "right" }}>
            {/* <UserButton afterSignOutUrl="/" /> */}
          </li>
        </ul>
      </nav>
    </div>
  );
};

export default NavComponent;
function setError(arg0: string) {
  throw new Error("Function not implemented.");
}

