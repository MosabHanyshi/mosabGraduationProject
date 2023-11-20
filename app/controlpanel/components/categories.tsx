"use client";
import styles from "./styles.module.css";
import { useEffect, useState } from "react";
import React from "react";


interface Category {
  category_id: number;
  category_name: string;
  category_description: string;
  category_image_path: string;
}

const Categories: React.FC = () => {

   const [categories, setCategories] = useState<Category[]>([]);
   const [error, setError] = useState<string | null>(null);

   const [id, setId] = useState("");
   const [name, setName] = useState("");
   const [description, setDescription] = useState("");
   const [image , setImage] = useState("");

   const [showDiv, setShowDiv] = useState(false);
   const [editedData, setEditedData] = useState({id, name, description, image });

   const [isNameChecked, setNameChecked] = useState(false);
   const [isDescriptionChecked, setDescriptionChecked] = useState(false);
   const [isImageChecked, setImageChecked] = useState(false);
  


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

  const handleCreate = (editedData: Category) => {
    fetch(`/api/createCategory`, {
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
        console.log("User created:", createdData);
      })
      .catch((error) => {
        // Handle errors
        console.error("Error creating user:", error);
      });
  };

  const handleUpdate = (categoryId: number, updatedData: Partial<Category>) => {
    // Implement the logic to update the database with the new data

    fetch(`/api/updateCategory/${categoryId}`, {
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
        console.log("category updated successfully:", data);
      })
      .catch((error) => {
        console.error("Error updating category:", error);
      });
  };


  const handleDelete = (categoryId: number) => {

    fetch(`/api/updateCategory/${categoryId}`, {
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
        console.log("Category deleted:", deletedData);
      })
      .catch((error) => {
        // Handle errors
        console.error("Error deleting user:", error);
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
   const handleDescriptionCheckboxChange = () => {
     setDescriptionChecked(!isDescriptionChecked); // Toggle the boolean value
   };

   // Handler function for checkbox change
   const handleImageCheckboxChange = () => {
     setImageChecked(!isImageChecked); // Toggle the boolean value
   };


  return (
    <div>
      <div className={styles.categories}>
        <h1>Categories</h1>
        <button className={styles.buttonAdd} onClick={toggleDiv}>
          {showDiv ? "-" : "+"}
        </button>

        {showDiv ? (
          <table className={styles.table}>
            <thead className={styles.thead}>
              <tr className={styles.tr}>
                <th className={styles.thLeft}>category_id</th>
                <th className={styles.th}>category_name</th>
                <th className={styles.th}>category_description</th>
                <th className={styles.th}>category_image_path</th>
                <th className={styles.thRight}>action</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td
                  className={styles.td}
                  contentEditable={true}
                  onBlur={(e) => handleContentChange(e, "id")}
                >
                  {id}
                </td>
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
                  onBlur={(e) => handleContentChange(e, "description")}
                >
                  {description}
                </td>
                <td
                  className={styles.td}
                  contentEditable={true}
                  onBlur={(e) => handleContentChange(e, "image")}
                >
                  {image}
                </td>

                <td className={styles.td}>
                  <button
                    className={styles.buttonRemove}
                    onClick={() =>
                      handleCreate({
                        category_id: parseInt(editedData.id, 10),
                        category_name: editedData.name,
                        category_description: editedData.description,
                        category_image_path: editedData.image,
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
              <th className={styles.thLeft}> category_id</th>
              <th className={styles.th}>
                <input
                  type="checkbox"
                  checked={isNameChecked}
                  onChange={handleNameCheckboxChange}
                />
                category_name
              </th>

              <th className={styles.th}>
                <input
                  type="checkbox"
                  checked={isDescriptionChecked}
                  onChange={handleDescriptionCheckboxChange}
                />
                category_description
              </th>

              <th className={styles.th}>
                <input
                  type="checkbox"
                  checked={isImageChecked}
                  onChange={handleImageCheckboxChange}
                />
                category_image_path
              </th>

              <th className={styles.thRight}>action</th>
            </tr>
          </thead>

          <tbody>
            {categories.map((category) => (
              <tr key={category.category_id}>
                <td
                  className={styles.td}
                  contentEditable={true}
                  onBlur={(e) => handleContentChange(e, "id")}
                >
                  {category.category_id}
                </td>

                <td
                  className={styles.td}
                  contentEditable={true}
                  onBlur={(e) => handleContentChange(e, "name")}
                >
                  {category.category_name}
                </td>

                <td
                  className={styles.td}
                  contentEditable={true}
                  onBlur={(e) => handleContentChange(e, "description")}
                >
                  {category.category_description}
                </td>
                <td
                  className={styles.td}
                  contentEditable={true}
                  onBlur={(e) => handleContentChange(e, "image")}
                >
                  {category.category_image_path}
                </td>

                <td className={styles.td}>
                  <button
                    className={styles.buttonRemove}
                    onClick={() => handleDelete(category.category_id)}
                  >
                    Remove
                  </button>

                  <button
                    className={styles.buttons}
                    onClick={() =>
                      handleUpdate(category.category_id, {
                        category_name: isNameChecked
                          ? editedData.name
                          : category.category_name,
                        category_description: isDescriptionChecked
                          ? editedData.description
                          : category.category_image_path,
                        category_image_path: isImageChecked
                          ? editedData.image
                          : category.category_image_path,
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

export default Categories;
