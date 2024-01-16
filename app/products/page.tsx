"use client";
import * as React from "react";
import Image from "next/image";
import Photo from "../product_images/LCD16x2.jpg";
import styles from "./styles.module.css";
import { useEffect, useState } from "react";
import NavComponent from "../components/navbar";
import { useStateValue } from "../context/StateContext";
import CategoriesList from "../components/CategoriesList/CategoriesList";
import SearchAndCategories from "../components/CategoriesList/CategoriesList";


interface Product {

  product_id: number;
  product_name: string;
  product_price: number;
  product_count: number;
  product_category: string;
  product_img_path: string;
  product_description: string;
  discount_percentage: number ;
  profit: number ;

}


interface CartItem {

  cart_id: number;
  product_id: number;
  quantity: number;

}

interface ProductsListProps {
  userId: number;
}

const ProductsList: React.FC<ProductsListProps> = ({userId=2}) => {
  const [products, setProducts] = useState<Product[]>([]);
  const [categories, setCategories] = useState<string[]>([]);
  const [selectedCategory, setSelectedCategory] = useState<string | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [searchTerm, setSearchTerm] = useState<string>("");

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

  const addToCartButton = (addedItem: CartItem, productCategory: string) => {
    fetch(`/api/createCartItem`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(addedItem),
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
        console.log("Item Added:", createdData);

        // // After successfully adding to the cart, log the user behavior
        logUserBehavior({
          user_id: userId,
          page_name: "product page",
          action_type: productCategory,
          timestamp: new Date(),
          product_id: addedItem.product_id
        });
      })
      .catch((error) => {
        // Handle errors
        console.error("Error creating user:", error);
      });
  };
  

  const logUserBehavior = (logData: {user_id: number , page_name : string , action_type: string , timestamp: Date , product_id:number}) => {
    fetch(`/api/createUserBehavior`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(logData),
    })
      .then((response) => {
        if (!response.ok) {
          throw new Error(`HTTP error! Status: ${response.status}`);
        }
        // Handle success as needed

        return response.json();
      })
      .then((loggedData) => {
        // Handle the logged data
        console.log("User behavior logged:", loggedData);
      })
      .catch((error) => {
        // Handle errors
        console.error("Error logging user behavior:", error);
      });
  };

  // Filter products based on the search term
  const filteredProducts = products.filter((product) => {
    const productNameMatches = product.product_name
      .toLowerCase()
      .includes(searchTerm.toLowerCase());

    const categoryMatches =
      !selectedCategory || product.product_category === selectedCategory;

    return productNameMatches && categoryMatches;
  });

  return (
    <>
      <div className={styles.top}>
        <SearchAndCategories
          onSearchTerm={setSearchTerm}
          onSelectCategory={setSelectedCategory}
        />
      </div>

      <div className={styles.productsContainer}>
        {filteredProducts.map((product) => (
          <div className={styles.productItem} key={product.product_id}>
            <div className={styles.productCard}>
              <div className={styles.imageContainer}>
                <img
                  src={product.product_img_path}
                  style={{ width: "100%", height: "100%" }}
                />
              </div>
              <h2 className={styles.productTitle}>{product.product_name}</h2>
              <p className={styles.productDescription}>
                {product.product_description}
              </p>
              <div className={styles.productDetails}>
                <span className={styles.productPriceAfterDis}>
                  ${product.product_price}
                </span>
                <span className={styles.productPrice}>
                  $
                  {product.product_price -
                    product.discount_percentage * product.product_price}
                </span>
                <button
                  className={styles.productButton}
                  onClick={() =>
                    addToCartButton(
                      {
                        cart_id: 2,
                        product_id: product.product_id,
                        quantity: 1,
                      },
                      product.product_category
                    )
                  }
                >
                  Add to Cart
                </button>
              </div>
            </div>
          </div>
        ))}
      </div>
    </>
  );
};

export default ProductsList;
