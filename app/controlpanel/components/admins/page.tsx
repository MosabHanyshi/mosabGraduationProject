// pages/MyComponent.tsx
"use client";
import { Category } from "@mui/icons-material";
import styles from "./styles.module.css";
import { useEffect, useState } from "react";

interface Admin {
  admin_id: number;
  admin_name: string;
  admin_email: string;
  admin_specialists: string ;
  admin_photo: string;
  admin_password: string;
}

const Admins: React.FC = () => {
  const [admins, setAdmins] = useState<Admin[]>([]);
  const [error, setError] = useState<string | null>(null);
  const [id, setId] = useState("");
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [specialists, setSpecialists] = useState("");
  const [photo, setPhoto] = useState("");
  const [password, setPassword] = useState("");
  const [showDiv, setShowDiv] = useState(false);
  const [editedData, setEditedData] = useState({ id, name, email, specialists ,photo, password });

  const [isNameChecked, setNameChecked] = useState(false);
  const [isEmailChecked, setEmailChecked] = useState(false);
  const [isSpecialistsChecked,setSpecialistsChecked] = useState(false);
  const [isPhotoChecked,setPhotoChecked] = useState(false);
  const [isPasswordChecked, setPasswordChecked] = useState(false);

  useEffect(() => {
    fetch("/api/admins")
      .then((response) => {
        
        if (!response.ok) {
          throw new Error(`Network response was not ok: ${response.status}`);
        }
        return response.json();
      })
      .then((data) => {
        if (Array.isArray(data)) {
          setAdmins(data);
        } else {
          setError("Data received is not an array");
        }
      })
      .catch((error) => {
        console.error("Error fetching admins:", error);
        setError("Error fetching data");
      });
  }, []);

  const handleCreate = (editedData: Admin) => {
    fetch(`/api/createAdmin`, {
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
        console.log("Admin created:", createdData);
      })
      .catch((error) => {
        // Handle errors
        console.error("Error creating Admin:", error);
      });
  };

  const handleUpdate = (adminId: number, updatedData: Partial<Admin>) => {
    // Implement the logic to update the database with the new data

    fetch(`/api/updateAdmin/${adminId}`, {
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
        console.log("User updated successfully:", data);
      })
      .catch((error) => {
        console.error("Error updating user:", error);
      });
  };

  const handleDelete = (adminId: number) => {
    fetch(`/api/updateAdmin/${adminId}`, {
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
        console.log("Admin deleted:", deletedData);
      })
      .catch((error) => {
        // Handle errors
        console.error("Error deleting admin:", error);
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
  const handleEmailCheckboxChange = () => {
    setEmailChecked(!isEmailChecked); // Toggle the boolean value
  };

  const handleSpecialistsCheckboxChange = () => {
   setSpecialistsChecked(!isSpecialistsChecked);     
  };

   const handlePhotoCheckboxChange = () => {
     setPhotoChecked(!isPhotoChecked);
   };
  // Handler function for checkbox change
  const handlePasswordCheckboxChange = () => {
    setPasswordChecked(!isPasswordChecked); // Toggle the boolean value
  };


  

  return (
    <div>
      <div className={styles.admins}>
        <h1>Admins</h1>
        <button className={styles.buttonAdd} onClick={toggleDiv}>
          {showDiv ? "-" : "+"}
        </button>
        {showDiv ? (
          <table className={styles.table}>
            <thead className={styles.thead}>
              <tr className={styles.tr}>
                <th className={styles.thLeft}>user_id</th>
                <th className={styles.th}>admin_name</th>
                <th className={styles.th}>admin_email</th>
                <th className={styles.th}>admin_specialists</th>
                <th className={styles.th}>admin_photo</th>
                <th className={styles.th}>admin_password</th>
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
                  onBlur={(e) => handleContentChange(e, "email")}
                >
                  {email}
                </td>
                <td
                  className={styles.td}
                  contentEditable={true}
                  onBlur={(e) => handleContentChange(e, "specialists")}
                >
                  {password}
                </td>
                <td
                  className={styles.td}
                  contentEditable={true}
                  onBlur={(e) => handleContentChange(e, "photo")}
                >
                  {password}
                </td>
                <td
                  className={styles.td}
                  contentEditable={true}
                  onBlur={(e) => handleContentChange(e, "password")}
                >
                  {password}
                </td>

                <td className={styles.td}>
                  <button
                    className={styles.buttonRemove}
                    onClick={() =>
                      handleCreate({
                        admin_id: parseInt(editedData.id, 10),
                        admin_name: editedData.name,
                        admin_email: editedData.email,
                        admin_specialists: editedData.specialists,
                        admin_photo: editedData.photo,
                        admin_password: editedData.password,
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
              <th className={styles.thLeft}> admin_id</th>
              <th className={styles.th}>
                <input
                  type="checkbox"
                  checked={isNameChecked}
                  onChange={handleNameCheckboxChange}
                />
                admin_name
              </th>

              <th className={styles.th}>
                <input
                  type="checkbox"
                  checked={isEmailChecked}
                  onChange={handleEmailCheckboxChange}
                />
                admin_email
              </th>

              <th className={styles.th}>
                <input
                  type="checkbox"
                  checked={isSpecialistsChecked}
                  onChange={handleSpecialistsCheckboxChange}
                />
                admin_specialists
              </th>

              <th className={styles.th}>
                <input
                  type="checkbox"
                  checked={isPhotoChecked}
                  onChange={handlePhotoCheckboxChange}
                />
                admin_photo
              </th>

              <th className={styles.th}>
                <input
                  type="checkbox"
                  checked={isPasswordChecked}
                  onChange={handlePasswordCheckboxChange}
                />
                admin_password
              </th>

              <th className={styles.thRight}>action</th>
            </tr>
          </thead>
          <tbody>
            {admins.map((admin) => (
              <tr key={admin.admin_id}>
                <td
                  className={styles.td}
                  contentEditable={true}
                  onBlur={(e) => handleContentChange(e, "id")}
                >
                  {admin.admin_id}
                </td>

                <td
                  className={styles.td}
                  contentEditable={true}
                  onBlur={(e) => handleContentChange(e, "name")}
                >
                  {admin.admin_name}
                </td>

                <td
                  className={styles.td}
                  contentEditable={true}
                  onBlur={(e) => handleContentChange(e, "email")}
                >
                  {admin.admin_email}
                </td>
                <td
                  className={styles.td}
                  contentEditable={true}
                  onBlur={(e) => handleContentChange(e, "specialists")}
                >
                  {admin.admin_specialists}
                </td>

                <td
                  className={styles.td}
                  contentEditable={true}
                  onBlur={(e) => handleContentChange(e, "photo")}
                >
                  {admin.admin_photo}
                </td>

                <td
                  className={styles.td}
                  contentEditable={true}
                  onBlur={(e) => handleContentChange(e, "password")}
                >
                  {admin.admin_password}
                </td>

                <td className={styles.td}>
                  <button
                    className={styles.buttonRemove}
                    onClick={() => handleDelete(admin.admin_id)}
                  >
                    Remove
                  </button>

                  <button
                    className={styles.buttons}
                    onClick={() =>
                      handleUpdate(admin.admin_id, {
                        admin_name: isNameChecked
                          ? editedData.name
                          : admin.admin_name,
                        admin_email: isEmailChecked
                          ? editedData.email
                          : admin.admin_email,
                        admin_specialists: isSpecialistsChecked
                          ? editedData.specialists
                          : admin.admin_specialists,
                        admin_photo: isPhotoChecked
                          ? editedData.photo
                          : admin.admin_photo,
                        admin_password: isPasswordChecked
                          ? editedData.password
                          : admin.admin_password,
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

export default Admins;
