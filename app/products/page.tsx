"use client";
import * as React from "react";
import Image from "next/image";
import Photo from "../product_images/LCD16x2.jpg";
import styles from "./styles.module.css";
import { useEffect, useState } from "react";


interface Product {
  product_id: number;
  product_name: string;
  product_price: number;
  product_count: number;
  product_category: string;
  product_img_path: string;
  product_description: string;
}

const ProductsList: React.FC = () => {
  const [products, setProducts] = useState<Product[]>([]);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    fetch("/api/products")
      .then((response) => {
        if (!response.ok) {
          throw new Error(`Network response was not ok: ${response.status}`);
        }
        return response.json();
      })
      .then((data) => {
        if (Array.isArray(data)) {
          setProducts(data);
        } else {
          setError("Data received is not an array");
        }
      })
      .catch((error) => {
        console.error("Error fetching users:", error);
        setError("Error fetching data");
      });
  }, []);

  if (error) {
    return <div>Error: {error}</div>;
  }

  return (
    <div className={styles.productsContainer}>
      {products.map((product) => (
        <div className={styles.productItem} key={product.product_id}>
          <div className={styles.productCard}>
            <Image
              src={product.product_img_path}
              alt=""
              width={300}
              height={300}
              // className={styles.productImage}
            />
            <h2 className={styles.productTitle}>{product.product_name}</h2>
            <p className={styles.productDescription}>
              {product.product_description}
            </p>
            <div className={styles.productDetails}>
              <span className={styles.productPrice}>
                ${product.product_price}
              </span>
              <button className={styles.productButton}>Add to Cart</button>
            </div>
          </div>
        </div>
      ))}
    </div>
  );
};

export default ProductsList;
