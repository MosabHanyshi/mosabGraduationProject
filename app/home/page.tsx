// Import statements
"use client"
import React, { useEffect, useState } from "react";
import Image from "next/image";
import styles from "./styles.module.css";
import ItemSlider from "../components/slider/page";
import NewsRotator from "./component/newsRotator/page";
import { checkAuth } from "@/utils/auth";
import  {useRouter} from "next/router";
import Layout from "../components/Layout";


interface HomeProps {
  userId : string ;
}

// Component definition
const Home: React.FC<HomeProps>=({userId = 2}) => {

  const [newProducts, setNewProducts] = useState([]);
  const [recommendedProducts , setRecommendedProducts] = useState([]);
  // const router = useRouter();

  // // const router = useRouter();
  // useEffect(() => {


  //    // Check authentication status with the API route
  //    const authResponse = await fetch('/api/auth');

  //    if (!authResponse.ok) {
  //      // If not authenticated, redirect to login page
  //      router.replace('/login');
  //      return;
  //    }

    
  //   const fetchNewProducts = async () => {
  //     try {
  //       const response = await fetch("/api/newProducts");
  //       if (!response.ok) {
  //         throw new Error(`HTTP error! Status: ${response.status}`);
  //       }
  //       const data = await response.json();
  //       setNewProducts(data);
  //     } catch (error) {
  //       console.error("Error fetching new products:", error);
  //     }
  //   };

  //   fetchNewProducts();
  // }, []);

  // useEffect(()=> {
  //   const fetchRecommendedProducts = async () => {
  //     try {
  //       const response = await fetch(`/api/getRecommendedProducts/${userId}`);
  //       if (!response.ok) {
  //         throw new Error(`HTTP error! Status: ${response.status}`);
  //         console.log("hello");
  //       }
  //       const data = await response.json();
  //       setRecommendedProducts(data);

  //     }catch(error){
  //       console.error("Error fetching recommended products products:", error);
  //     }
  //   }

  //   fetchRecommendedProducts();
  // },[])


  useEffect(() => {
    const fetchData = async () => {
      try {
        // Check authentication status with the API route
        const authResponse = await fetch('/api/auth');

        // if (!authResponse.ok) {
        //   // If not authenticated, redirect to login page
        //   router.replace('/login');
        //   return;
        // }

        // If authenticated, fetch other data
        const newProductsResponse = await fetch('/api/newProducts');
        const recommendedProductsResponse = await fetch(`/api/getRecommendedProducts/${userId}`);

        if (!newProductsResponse.ok || !recommendedProductsResponse.ok) {
          throw new Error('Error fetching data');
        }

        const newProductsData = await newProductsResponse.json();
        const recommendedProductsData = await recommendedProductsResponse.json();

        setNewProducts(newProductsData);
        setRecommendedProducts(recommendedProductsData);
      } catch (error) {
        console.error('Error:', error);
      } finally {
        // Set loading to false once data fetching is done
        setLoading(false);
      }
    };

    fetchData();
  }, [userId]);

  return (
    <>
    <Layout>
    <div className={styles.page}>
      <div className={styles.leftColumn}>
        {/* New Products Section */}
        <div className={styles.newProducts}>
          <h1>New products in our store</h1>
          <ItemSlider products={newProducts} type="new"/>
        </div>

        {/* User-Based Products Section */}
        <div className={styles.userBasedProducts}>
          <h1>Recommended products - content based</h1>
          <ItemSlider products={recommendedProducts} type="recommand" />
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
    </Layout>
    </>
  );
}


export default Home ;
function setLoading(arg0: boolean) {
  throw new Error("Function not implemented.");
}

