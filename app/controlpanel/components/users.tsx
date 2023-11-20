// pages/MyComponent.tsx
"use client"
import { Category } from "@mui/icons-material";
import styles from "./styles.module.css";
import { useEffect, useState } from "react";

interface User {
  user_id: number;
  user_name: string;
  user_email: string;
  user_password: string;
}

const Users: React.FC = () => {
  const [users, setUsers] = useState<User[]>([]);
  const [error, setError] = useState<string | null>(null);
  const [id, setId] = useState("");
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [showDiv, setShowDiv] = useState(false);
  const [editedData, setEditedData] = useState({ id, name, email, password });

  const [isNameChecked, setNameChecked] = useState(false);
  const [isEmailChecked, setEmailChecked] = useState(false);
  const [isPasswordChecked, setPasswordChecked] = useState(false);

  useEffect(() => {
    fetch("/api/users")
      .then((response) => {
        if (!response.ok) {
          throw new Error(`Network response was not ok: ${response.status}`);
        }
        return response.json();
      })
      .then((data) => {
        if (Array.isArray(data)) {
          setUsers(data);
        } else {
          setError("Data received is not an array");
        }
      })
      .catch((error) => {
        console.error("Error fetching users:", error);
        setError("Error fetching data");
      });
  }, []);

  const handleCreate = (editedData: User) => {
    fetch(`/api/createUser`, {
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

  const handleUpdate = (userId: number, updatedData: Partial<User>) => {
    // Implement the logic to update the database with the new data

    fetch(`/api/updateUser/${userId}`, {
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

  const handleDelete = (userId: number) => {
    fetch(`/api/updateUser/${userId}`, {
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
        console.log("User deleted:", deletedData);
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
  const handleEmailCheckboxChange = () => {
    setEmailChecked(!isEmailChecked); // Toggle the boolean value
  };

  // Handler function for checkbox change
  const handlePasswordCheckboxChange = () => {
    setPasswordChecked(!isPasswordChecked); // Toggle the boolean value
  };

  return (
    <div>
      <div className={styles.users}>
        <h1>Users</h1>
        <button className={styles.buttonAdd} onClick={toggleDiv}>
          {showDiv ? "-" : "+"}
        </button>
        {showDiv ? (
          <table className={styles.table}>
            <thead className={styles.thead}>
              <tr className={styles.tr}>
                <th className={styles.thLeft}>user_id</th>
                <th className={styles.th}>user_name</th>
                <th className={styles.th}>user_email</th>
                <th className={styles.th}>user_password</th>
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
                  onBlur={(e) => handleContentChange(e, "password")}
                >
                  {password}
                </td>

                <td className={styles.td}>
                  <button
                    className={styles.buttonRemove}
                    onClick={() =>
                      handleCreate({
                        user_id: parseInt(editedData.id, 10),
                        user_name: editedData.name,
                        user_email: editedData.email,
                        user_password: editedData.password,
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
              <th className={styles.thLeft}> user_id</th>
              <th className={styles.th}>
                <input
                  type="checkbox"
                  checked={isNameChecked}
                  onChange={handleNameCheckboxChange}
                />
                user_name
              </th>

              <th className={styles.th}>
                <input
                  type="checkbox"
                  checked={isEmailChecked}
                  onChange={handleEmailCheckboxChange}
                />
                user_email
              </th>

              <th className={styles.th}>
                <input
                  type="checkbox"
                  checked={isPasswordChecked}
                  onChange={handlePasswordCheckboxChange}
                />
                user_password
              </th>

              <th className={styles.thRight}>action</th>
            </tr>
          </thead>
          <tbody>
            {users.map((user) => (
              <tr key={user.user_id}>
                <td
                  className={styles.td}
                  contentEditable={true}
                  onBlur={(e) => handleContentChange(e, "id")}
                >
                  {user.user_id}
                </td>

                <td
                  className={styles.td}
                  contentEditable={true}
                  onBlur={(e) => handleContentChange(e, "name")}
                >
                  {user.user_name}
                </td>

                <td
                  className={styles.td}
                  contentEditable={true}
                  onBlur={(e) => handleContentChange(e, "email")}
                >
                  {user.user_email}
                </td>
                <td
                  className={styles.td}
                  contentEditable={true}
                  onBlur={(e) => handleContentChange(e, "password")}
                >
                  {user.user_password}
                </td>

                <td className={styles.td}>
                  <button
                    className={styles.buttonRemove}
                    onClick={() => handleDelete(user.user_id)}
                  >
                    Remove
                  </button>

                  <button
                    className={styles.buttons}
                    onClick={() =>
                      handleUpdate(user.user_id, {
                        user_name: isNameChecked? editedData.name:user.user_name,
                        user_email:isEmailChecked? editedData.email: user.user_email,
                        user_password:isPasswordChecked? editedData.password : user.user_password,
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

export default Users;
