
"use client";
import React from "react";
import styles from "./styles.module.css";
import logo from "/public/images/cpu.png";
import Image from "next/image";


interface ComponentProps {
  onPageClick: (PageName: string) => void;
}


const Sidebar: React.FC<ComponentProps> = ({ onPageClick }) => {
  return (
    <div className={styles.sidebar}>
      <h2 className={styles.title}>Kabatocia Store</h2>
      <div className={styles.logo}>
        <Image
          src={logo}
          alt="logo"
          style={{
            display: "flex",
            width: "100px",
            height: "100px",
            justifyContent: "center",
            alignItems: "center",
          }}
        />
      </div>
      <ul className={styles.nav}>
        <li onClick={() => onPageClick("Admins")}>Admins</li>
        <li onClick={() => onPageClick("Users")}>Users</li>
        <li onClick={() => onPageClick("Categories")}>Categories</li>
        <li onClick={() => onPageClick("Products")}>Products</li>
        <li onClick={() => onPageClick("Orders")}>Orders</li>
        <li onClick={() => onPageClick("Profits")}>Profits</li>
        <li onClick={() => onPageClick("Payments")}>Payments</li>
        <li onClick={() => onPageClick("Requests")}>Requests</li>
        <li onClick={() => onPageClick("Campaigns")}>Campaigns</li>
      </ul>
    </div>
  );
};

export default Sidebar;
