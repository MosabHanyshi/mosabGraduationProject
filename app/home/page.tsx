// Import statements
"use client"
import React, { useEffect, useState } from "react";
import Image from "next/image";
import styles from "./styles.module.css";
import ItemSlider from "../components/slider/page";
import NewsRotator from "./component/newsRotator/page";


interface HomeProps {
  userId : string ;
}

// Component definition
const Home: React.FC<HomeProps>=({userId = 2}) => {

  const [newProducts, setNewProducts] = useState([]);
  const [recommendedProducts , setRecommendedProducts] = useState([]);

  useEffect(() => {
    const fetchNewProducts = async () => {
      try {
        const response = await fetch("/api/newProducts");
        if (!response.ok) {
          throw new Error(`HTTP error! Status: ${response.status}`);
        }
        const data = await response.json();
        setNewProducts(data);
      } catch (error) {
        console.error("Error fetching new products:", error);
      }
    };

    fetchNewProducts();
  }, []);

  useEffect(()=> {
    const fetchRecommendedProducts = async () => {
      try {
        const response = await fetch(`/api/getRecommendedProducts/${userId}`);
        if (!response.ok) {
          throw new Error(`HTTP error! Status: ${response.status}`);
          console.log("hello");
        }
        const data = await response.json();
        console.log(data);
        setRecommendedProducts(data);

      }catch(error){
        console.error("Error fetching recommended products products:", error);
      }
    }

    fetchRecommendedProducts();
  },[])



  return (
    <div className={styles.page}>
      <div className={styles.leftColumn}>
        {/* New Products Section */}
        <div className={styles.newProducts}>
          <h1>New products in our store</h1>
          <ItemSlider products={newProducts} />
        </div>

        {/* User-Based Products Section */}
        <div className={styles.userBasedProducts}>
          <h1>We have these products in our website</h1>
          <ItemSlider products={recommendedProducts} />
        </div>
      </div>

      {/* Right Column with News Rotator */}
      <div className={styles.rightColumn}>
        <div className={styles.news}>
          <h1>News</h1>
          <NewsRotator />
        </div>

        <div className={styles.news}>
          <h1>News</h1>
          <h1>Some information about our site</h1>
        </div>
      </div>
    </div>
  );
}


export default Home ;
