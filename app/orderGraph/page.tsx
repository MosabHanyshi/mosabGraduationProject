import React, { useEffect, useState } from "react";

const MyComponent: React.FC = () => {
  const [data, setData] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchOrdersTimeSeries = async () => {
      try {
        const selectedDate = "2023-01"; // Replace with your desired date
        const response = await fetch(
          `/api/ordersTimeSeries/${selectedDate}`
        );

        if (!response.ok) {
          throw new Error(`Failed to fetch data. Status: ${response.status}`);
        }

        const result = await response.json();
        setData(result);
        setLoading(false);
      } catch (err: unknown) {
        if (err instanceof Error) {
          setError(err.message);
        } else {
          setError("An error occurred while fetching data.");
        }
        setLoading(false);
      }
    };

    fetchOrdersTimeSeries();
  }, []); // Ensure the effect runs only once on component mount

  if (loading) {
    return <p>Loading...</p>;
  }

  if (error) {
    return <p>Error: {error}</p>;
  }

  return (
    <div>
      <h1>Data from API:</h1>
      <pre>{JSON.stringify(data, null, 2)}</pre>
    </div>
  );
};

export default MyComponent;
