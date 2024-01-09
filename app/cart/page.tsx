"use client";
import React, { useEffect, useState , useRef } from "react";
import styles from "./styles.module.css";
import axios from "axios";
import Image from "next/image";
import MapComponent from "./components/map/page";
import ShoppingCartRoundedIcon from "@mui/icons-material/ShoppingCartRounded";

interface Item {
  cart_id: number;
  product_id: number;
  quantity: number;
}


interface ItemCard {
  product_id: number;
  product_name: string;
  product_price: number;
  product_count: number;
  product_category: string;
  product_img_path: string;
  product_description: string;
  quantity: number;
}

interface Product {
  product_id: number;
  product_name: string;
  product_price: number;
  product_count: number;
  product_category: string;
  product_img_path: string;
  product_description: string;
}

interface CardListProps {
  numberOfCards: number;
}

const CardList: React.FC = () => {
  const [items, setItems] = useState<Item[]>([]);
  const [products, setProducts] = useState<Product[]>([]);
  const [error, setError] = useState<string | null>(null);
  const [total, setTotal] = useState(0);
  const [payments, setPayments] = useState("");
  const [inputCount, setInputCount] = useState<number>(0);
  const [outputCount, setOutputCount] = useState<number>(0);
  const [controllerCount, setControllerCount] = useState<number>(0);

  //first effect ( is Done )
  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await axios.get(`/api/getCartItems/${2}`);
        setItems(response.data);
      } catch (error) {
        console.error("Error fetching data:", error);
        setError("Error fetching data");
      }
    };
    fetchData();
  }, []);

  //second effect

  useEffect(() => {
    const fetchDataForAllCards = async () => {
      try {
        const Products = Promise.all(
          items.map(async (item) => {
            const additionalData = await fetchAdditionalData(item.product_id);
            return additionalData;
          })
        );

        setProducts(await Products); // Filter out undefined values
      } catch (error) {
        console.error("Error fetching additional data for all cards:", error);
      }
    };

    fetchDataForAllCards();
  }, [items]);

  const fetchAdditionalData = async (productId: number) => {
    try {
      const response = await fetch(`/api/getProducts/${productId}`, {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
        },
      });

      if (!response.ok) {
        throw new Error(`HTTP error! Status: ${response.status}`);
      }

      const data = await response.json();

      return data;
    } catch (error) {
      console.error("Error fetching data:", error);
      throw error; // Re-throw the error if you want to handle it outside of this function
    }
  };

  // Function to get a specific product by product_id
  const getProductById = (productId: number): Product => {
    const product = products.find(
      (product) => product.product_id === productId
    );

    if (!product) {
      // You can handle this case by returning a default product or throwing an error
      throw new Error(`Product with ID ${productId} not found`);
    }
    return product;
  };

  const getQuantityById = (productId: number): number | undefined => {
    const item = items.find((item) => item.product_id === productId);

    // Check if item is defined before accessing its quantity property
    if (item) {
      return item.quantity;
    } else {
      // Handle the case where no matching item is found
      console.error(`Item with productId ${productId} not found`);
      return undefined; // Or you can return a default value or throw an error
    }
  };

  // Function to delete item  (is Done)
  const deleteCartItem = (productId: number) => {
    fetch(`/api/deleteCartItem/${productId}`, {
      method: "DELETE",
      headers: {
        "Content-Type": "application/json",
      },
    })
      .then((response) => {
        if (!response.ok) {
          throw new Error(`HTTP error! Status: ${response.status}`);
        }
        // Handle success as needed
        return response.json();
      })
      .then((deletedData) => {
        // Handle the deleted data
        console.log("cart Item deleted:", deletedData);
      })
      .catch((error) => {
        // Handle errors
        console.error("Error deleting cart Item:", error);
      });
  };

  // Function to increment quantity
  const incrementCounter = (
    cartId: number,
    productId: number,
    quantity: number | undefined,
    count: number
  ) => {
    setItems((items) =>
      items.map((item) =>
        item.product_id === productId && (quantity ? quantity : 0) < count
          ? { ...item, quantity: item.quantity + 1 }
          : item
      )
    );

    if (quantity || quantity === 0) {
      if (quantity <= count) {
        fetch(`/api/updateCartItem/${productId}`, {
          method: "PUT",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({
            cart_id: cartId,
            product_id: productId,
            quantity: quantity + 1,
          }),
        })
          .then((response) => {
            if (!response.ok) {
              throw new Error(
                `Network response was not ok: ${response.status}`
              );
            }
            return response.json();
          })
          .then((data) => {
            // Handle the updated data if needed
            console.log("User updated successfully:", data);
          })
          .catch((error) => {
            console.error("Error updating user:", error);
          });
      } else if (quantity > count) {
        alert("this is the max quantity ");
      } else {
        console.log("quantity variable is undefined");
      }
    }
  };

  // Function to decrement quantity
  const decrementCounter = (
    cartId: number,
    productId: number,
    quantity: number | undefined
  ) => {
    setItems((items) =>
      items.map((item) =>
        item.product_id === productId && !((quantity ? quantity : 0) == 0)
          ? { ...item, quantity: item.quantity - 1 }
          : item
      )
    );

    if (quantity) {
      if (quantity > 0) {
        fetch(`/api/updateCartItem/${productId}`, {
          method: "PUT",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({
            cart_id: cartId,
            product_id: productId,
            quantity: quantity - 1,
          }),
        })
          .then((response) => {
            if (!response.ok) {
              throw new Error(
                `Network response was not ok: ${response.status}`
              );
            }
            return response.json();
          })
          .then((data) => {
            // Handle the updated data if needed
            console.log("User updated successfully:", data);
          })
          .catch((error) => {
            console.error("Error updating user:", error);
          });
      } else {
        // if quantity is zero then delete item
        deleteCartItem(productId);
      }
    } else {
      console.log("quantity variable is undefined");
    }
  };

  const getTotalPrice = (): number | undefined => {
    let total = 0;

    products.forEach((product) => {
      total +=
        (getQuantityById(product.product_id) ?? 0) * product.product_price;
    });

    return total;
  };

  const createListOfPayments = () => {
    let list = "";

    products.map((product) => {
      list +=
        product.product_name +
        " : " +
        getQuantityById(product.product_id) +
        "\n";
    });
    setPayments(list);
  };

  useEffect(() => {
    const totalPrice = getTotalPrice();
    createListOfPayments();

    if (totalPrice !== undefined) {
      setTotal(totalPrice);
    }
  }, [products, getQuantityById]);



 useEffect(() => {
   const setQuants = () => {
     let newInputCount = 0;
     let newOutputCount = 0;
     let newControllerCount = 0;

     products.forEach((product) => {
       const item = items.find(
         (item) => item.product_id === product.product_id
       );

       if (product.product_category === "input") {
         newInputCount += item ? item.quantity : 0;
       } else if (product.product_category === "output") {
         newOutputCount += item ? item.quantity : 0;
       } else if (product.product_category === "controller") {
         newControllerCount += item ? item.quantity : 0;
       }
     });

     setInputCount(newInputCount);
     setOutputCount(newOutputCount);
     setControllerCount(newControllerCount);
   };

   setQuants();
   console.log(products);
 }, [products,items]);

 useEffect(() => {
   console.log("input quantity: ", inputCount);
   console.log("output quantity: ", outputCount);
   console.log("controller quantity: ", controllerCount);
 }, [inputCount, outputCount, controllerCount]);


  return (
    <>
      <div className={styles.pageContainer}>
        <div className={styles.cartSide}>
          {products.map((product) => {
            return (
              <div key={product.product_id} className={styles.itemCard}>
                <button
                  className={styles.deleteButton}
                  onClick={() => deleteCartItem(product.product_id)}
                >
                  X
                </button>
                <>
                  <Image
                    src={product.product_img_path}
                    alt=""
                    width={300}
                    height={300}
                  />

                  <button
                    className={styles.itemButton}
                    onClick={() =>
                      incrementCounter(
                        2,
                        product.product_id,
                        getQuantityById(product.product_id),
                        product.product_count
                      )
                    }
                  >
                    +
                  </button>
                  {<p>quantity: {getQuantityById(product.product_id)}</p>}
                  <button
                    className={styles.itemButton}
                    onClick={() =>
                      decrementCounter(
                        2,
                        product.product_id,
                        getQuantityById(product.product_id)
                      )
                    }
                  >
                    -
                  </button>
                </>
              </div>
            );
          })}
        </div>
        <div className={styles.checkoutSide}>
          <MapComponent
            username={"ahmad"}
            payments={payments}
            total_price={total}
            input_count={inputCount}
            output_count={outputCount}
            controller_count={controllerCount}
          />

          <div className={styles.paymentsContainer}>
            <h4>
              Cart{" "}
              <span className="price" style={{ color: "black" }}>
                <ShoppingCartRoundedIcon /> <b>{products.length}</b>
              </span>
            </h4>
            {products.map((product, index) => (
              <p key={index}>
                <a href="#">
                  {product.product_name}{" "}
                  <span style={{ backgroundColor: "yellow" }}>
                    (x {getQuantityById(product.product_id)}){" "}
                  </span>
                </a>
                <span className="price" style={{ float: "right" }}>
                  ${product.product_price}
                </span>
              </p>
            ))}
            <hr />
            <p>
              Total
              <span className="price" style={{ color: "black" }}>
                <b>${total}</b>
              </span>
            </p>
          </div>
        </div>
      </div>
    </>
  );
};




export default CardList;