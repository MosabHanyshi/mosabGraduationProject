"use client";
import * as React from "react";
import Image from "next/image";
import Photo from "../product_images/LCD16x2.jpg";
import styles from "./styles.module.css";
import { useEffect, useState } from "react";
import NavComponent from "../components/navbar";

interface Category {
  category_id: number;
  category_name: string;
  category_description: string;
  category_image_path: string;
}

const ProductsList: React.FC = () => {
  const [categories, setCategories] = useState<Category[]>([]);
  const [error, setError] = useState<string | null>(null);
  const [searchTerm, setSearchTerm] = useState<string>("");

  useEffect(() => {
    fetch("/api/categories")
      .then((response) => {
        if (!response.ok) {
          throw new Error(`Network response was not ok: ${response.status}`);
        }
        return response.json();
      })
      .then((data) => {
        if (Array.isArray(data)) {
          setCategories(data);
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

  // Filter products based on the search term
  const filteredCategories = categories.filter((category) =>
    category.category_name.toLowerCase().includes(searchTerm.toLowerCase())
  );

  return (
    <>
      <div className={styles.searchBar}>
        <input
          type="text"
          placeholder="Search products..."
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)}
        />
      </div>
      
      <div className={styles.productsContainer}>
        {filteredCategories.map((category) => (
          <div className={styles.productItem} key={category.category_id}>
            <div className={styles.productCard}>
              <Image
                src={category.category_image_path}
                alt=""
                width={300}
                height={300}
              />
              <h2 className={styles.productTitle}>{category.category_name}</h2>
              <p className={styles.productDescription}>
                {category.category_description}
              </p>
            </div>
          </div>
        ))}
      </div>
    </>
  );
};

export default ProductsList;
