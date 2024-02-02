"use client";
import React from "react";
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
  product_discount:number
}

const Products: React.FC = () => {
  const [products, setProducts] = useState<Product[]>([]);
  const [error, setError] = useState<string | null>(null);

  const [id, setId] = useState("");
  const [name, setName] = useState("");
  const [price, setPrice] = useState(0);
  const [count, setCount] = useState(0);
  const [category, setCategory] = useState("");
  const [image, setImage] = useState("");
  const [description, setDescription] = useState("");
  const [discount, setDiscount] = useState(0);
  const [showDiv, setShowDiv] = useState(false);
  const [editedData, setEditedData] = useState({
    id,
    name,
    price,
    count,
    category,
    image,
    description,
    discount
  });
  const [isNameChecked, setNameChecked] = useState(false);
  const [isPriceChecked, setPriceChecked] = useState(false);
  const [isCountChecked, setCountChecked] = useState(false);
  const [isCategoryChecked, setCategoryChecked] = useState(false);
  const [isImageChecked, setImageChecked] = useState(false);
  const [isDescriptionChecked, setDescriptionChecked] = useState(false);
  const [isDiscountChecked, setDiscountChecked] = useState(false);

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

  const handleCreate = (editedData: Product) => {
    
    fetch(`/api/createProduct`, {
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
        console.log("Product created:", createdData);
      })
      .catch((error) => {
        // Handle errors
        console.error("Error creating product:", error);
        console.log(editedData)
      });
  };

  const handleUpdate = (productId: number, updatedData: Partial<Product>) => {
    // Implement the logic to update the database with the new data
   console.log(updatedData.product_count);
    fetch(`/api/updateProduct/${productId}`, {
      method: "PUT",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(updatedData),
      
    })
      .then((response) => {
        if (!response.ok) {
          throw new Error(`Network response was not ok: ${response.status}`);
        }
        return response.json();
      })
      .then((data) => {
        // Handle the updated data if needed
        console.log("Product updated successfully:", data);
      })
      .catch((error) => {
        console.error("Error updating product:", error);
      });
  };

  const handleDelete = (productId: number) => {
    fetch(`/api/updateProduct/${productId}`, {
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
        console.log("Product deleted:", deletedData);
      })
      .catch((error) => {
        // Handle errors
        console.error("Error deleting Product:", error);
      });
  };

  const toggleDiv = () => {
    setShowDiv(!showDiv);
  };

  const handleContentChange = async (
    event: React.FocusEvent<HTMLTableCellElement>,
    field: string
  ) => {
    const updatedContent = event.target.textContent;
    setEditedData((prevData) => ({ ...prevData, [field]: updatedContent }));
  };

  // Handler function for checkbox change
  const handleNameCheckboxChange = () => {
    setNameChecked(!isNameChecked); // Toggle the boolean value
  };

  // Handler function for checkbox change
  const handlePriceCheckboxChange = () => {
    setPriceChecked(!isPriceChecked); // Toggle the boolean value
  };

  // Handler function for checkbox change
  const handleCountCheckboxChange = () => {
    setCountChecked(!isCountChecked); // Toggle the boolean value
  };

  // Handler function for checkbox change
  const handleCategoryCheckboxChange = () => {
    setCategoryChecked(!isCategoryChecked); // Toggle the boolean value
  };

  // Handler function for checkbox change
  const handleImageCheckboxChange = () => {
    setImageChecked(!isImageChecked); // Toggle the boolean value
  };

  // Handler function for checkbox change
  const handleDescriptionCheckboxChange = () => {
    setDescriptionChecked(!isDescriptionChecked); // Toggle the boolean value
  };

    // Handler function for checkbox change
    const handleDiscountCheckboxChange = () => {
      setDiscountChecked(!isDiscountChecked); // Toggle the boolean value
    };

  return (
    <div>
      <div className={styles.products}>
        <h1>Products</h1>
        <button className={styles.buttonAdd} onClick={toggleDiv}>
          {showDiv ? "-" : "+"}
        </button>
        {showDiv ? (
          <table className={styles.table}>
            <thead className={styles.thead}>
              <tr className={styles.tr}>
                {/* <th className={styles.thLeft}>product_id</th> */}
                <th className={styles.th}>product_name</th>
                <th className={styles.th}>product_price</th>
                <th className={styles.th}>product_count</th>
                <th className={styles.th}>product_category</th>
                <th className={styles.th}>product_image</th>
                <th className={styles.th}>product_description</th>
                <th className={styles.th}>discount</th>

                <th className={styles.thRight}>action</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                {/* <td
                  className={styles.td}
                  contentEditable={true}
                  onBlur={(e) => handleContentChange(e, "id")}
                >
                  {id}
                </td> */}
                <td
                  className={styles.td}
                  contentEditable={true}
                  onBlur={(e) => handleContentChange(e, "name")}
                >
                  {name}
                </td>
                <td
                  className={styles.td}
                  contentEditable={true}
                  onBlur={(e) => handleContentChange(e, "price")}
                >
                  {price}
                </td>
                <td
                  className={styles.td}
                  contentEditable={true}
                  onBlur={(e) => handleContentChange(e, "count")}
                >
                  {count}
                </td>

                <td
                  className={styles.td}
                  contentEditable={true}
                  onBlur={(e) => handleContentChange(e, "category")}
                >
                  {category}
                </td>

                <td
                  className={styles.td}
                  contentEditable={true}
                  onBlur={(e) => handleContentChange(e, "image")}
                >
                  {image}
                </td>

                <td
                  className={styles.td}
                  contentEditable={true}
                  onBlur={(e) => handleContentChange(e, "description")}
                >
                  {description}
                </td>

                <td
                  className={styles.td}
                  contentEditable={true}
                  onBlur={(e) => handleContentChange(e, "discount")}
                >
                  {discount}
                </td>

                <td className={styles.td}>
                  <button
                    className={styles.buttonRemove}
                    onClick={() =>
                      handleCreate({
                        product_id: parseInt(editedData.id, 10),
                        product_name: editedData.name,
                        product_price: editedData.price,
                        product_count: editedData.count,
                        product_category: editedData.category,
                        product_img_path: editedData.image,
                        product_description: editedData.description,
                        product_discount: editedData.discount
                      })
                    }
                  >
                    Add
                  </button>
                </td>
              </tr>
            </tbody>
          </table>
        ) : null}

        <table className={styles.table}>
          <thead className={styles.thead}>
            <tr className={styles.tr}>
              {/* <th className={styles.thLeft}>product_id</th> */}
              <th className={styles.th}>
                <input
                  type="checkbox"
                  checked={isNameChecked}
                  onChange={handleNameCheckboxChange}
                />
                product_name
              </th>

              <th className={styles.th}>
                <input
                  type="checkbox"
                  checked={isPriceChecked}
                  onChange={handlePriceCheckboxChange}
                />
                product_price
              </th>

              <th className={styles.th}>
                <input
                  type="checkbox"
                  checked={isCountChecked}
                  onChange={handleCountCheckboxChange}
                />
                product_count
              </th>

              <th className={styles.th}>
                <input
                  type="checkbox"
                  checked={isCategoryChecked}
                  onChange={handleCategoryCheckboxChange}
                />
                product_category
              </th>
              <th className={styles.th}>
                <input
                  type="checkbox"
                  checked={isImageChecked}
                  onChange={handleImageCheckboxChange}
                />
                product_img_path
              </th>

              <th className={styles.th}>
                <input
                  type="checkbox"
                  checked={isDescriptionChecked}
                  onChange={handleDescriptionCheckboxChange}
                />
                product_description
              </th>

              <th className={styles.th}>
                <input
                  type="checkbox"
                  checked={isDescriptionChecked}
                  onChange={handleDescriptionCheckboxChange}
                />
                 discount
              </th>

              <th className={styles.thRight}>action</th>
            </tr>
          </thead>
          <tbody>
            {products.map((product) => (
              <tr key={product.product_id}>
                {/* <td className={styles.td}>{product.product_id}</td> */}
                <td
                  className={styles.td}
                  contentEditable={true}
                  onBlur={(e) => handleContentChange(e, "name")}
                >
                  {product.product_name}
                </td>
                <td
                  className={styles.td}
                  contentEditable={true}
                  onBlur={(e) => handleContentChange(e, "price")}
                >
                  {product.product_price}
                </td>
                <td
                  className={styles.td}
                  contentEditable={true}
                  onBlur={(e) => handleContentChange(e, "count")}
                >
                  {product.product_count}
                </td>
                <td
                  className={styles.td}
                  contentEditable={true}
                  onBlur={(e) => handleContentChange(e, "category")}
                >
                  {product.product_category}
                </td>
                <td
                  className={styles.td}
                  contentEditable={true}
                  onBlur={(e) => handleContentChange(e, "image")}
                >
                  {product.product_img_path}
                </td>

                <td
                  className={styles.td}
                  contentEditable={true}
                  onBlur={(e) => handleContentChange(e, "description")}
                >
                  {product.product_description}
                </td>

                
                <td
                  className={styles.td}
                  contentEditable={true}
                  onBlur={(e) => handleContentChange(e, "discount")}
                >
                  {product.product_description}
                </td>

                <td className={styles.td}>
                  <button
                    className={styles.buttonRemove}
                    onClick={() => handleDelete(product.product_id)}
                  >
                    Remove
                  </button>
                  <button
                    className={styles.buttons}
                    onClick={() =>
                      handleUpdate(product.product_id, {
                        product_name: isNameChecked
                          ? editedData.name
                          : product.product_name,
                        product_price: isPriceChecked
                          ? editedData.price
                          : product.product_price,
                        product_count: isCountChecked
                          ? editedData.count
                          : product.product_count,
                        product_category: isCategoryChecked
                          ? editedData.category
                          : product.product_category,
                        product_img_path: isImageChecked
                          ? editedData.image
                          : product.product_img_path,
                        product_description: isDescriptionChecked
                          ? editedData.description
                          : product.product_description,
                        product_discount: isDiscountChecked 
                        ? editedData.discount
                        : product.product_discount
                      })
                    }
                  >
                    Update
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
};

export default Products;
