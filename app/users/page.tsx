"use client";
import { useEffect, useState } from "react";

interface User {
  user_id: number;
  user_name: string;
  user_email: string;
  user_password: string;
}

const UserList: React.FC = () => {
  
  const [users, setUsers] = useState<User[]>([]);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    fetch('/api/users')
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

  if (error) {
    return <div>Error: {error}</div>;
  }

  return (
    <div>
      <h1>Users</h1>
      <ul>
        {users.map((user) => (
          <li key={user.user_id}>
            {user.user_name} - {user.user_email} - {user.user_password}
          </li>
        ))}
      </ul>
    </div>
  );
};

export default UserList;
