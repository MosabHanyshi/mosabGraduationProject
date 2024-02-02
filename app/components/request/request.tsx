// pages/index.tsx

import React, { useState } from 'react';
import styles from "./styles.module.css";

const requestForm: React.FC = () => {
  const [componentName, setComponentName] = useState<string>('');
  const [description, setDescription] = useState<string>('');
  const [showTooltipName, setShowTooltipName] = useState(false);
  const [showTooltipDescription, setShowTooltipDescription] = useState(false);

  const [data,setData] = useState({
    componentName:'',
    description:''
  });

  const insertData = async () => {
    try {

    const data = {
        componentName,description
    }
      
      // Make a POST request to the backend API
      const response = await fetch('/api/createRequest', {
        method: 'POST',
        body: JSON.stringify(data),
      });

      const result = await response.json();
      console.log('Data inserted successfully:', result);

      // You can perform additional actions here if needed
    } catch (error) {
      console.error('Error inserting data:', error);
    }
  };

  return (
    <div className={styles.formContainer}>
    <h1 className={styles.title}>Make request</h1>
    <p>You can ask about electronic devices that not exists in our store </p>

    <label
        htmlFor="componentName"
        className="block text-sm font-medium text-gray-600 relative"
      >
        Component Name:
      </label>
    <input
      type="text"
      id="componentName"
      placeholder="Enter Component Name"
      value={componentName}
      onChange={(e) => setComponentName(e.target.value)}
      onMouseEnter={() => setShowTooltipName(true)}
      onMouseLeave={() => setShowTooltipName(false)}
    />
     {showTooltipName && (
          <span className="top-full  left-0 mt-2 text-xs text-green-800">
            Please enter an accurate name. It is preferable to include the scientific name of the electronic component
          </span>
        )}

    <label htmlFor="description"
     className="block text-sm font-medium text-gray-600 relative">
      Description:</label>

    <input
      type="text"
      id="description"
      placeholder="Enter Description"
      value={description}
      onChange={(e) => setDescription(e.target.value)}
      onMouseEnter={() => setShowTooltipDescription(true)}
      onMouseLeave={() => setShowTooltipDescription(false)}
    />
    {showTooltipDescription && (
          <span className="block top-full  left-0 mt-2 text-xs text-green-800">
            Please set here why you want this component so we can give you the best result .
          </span>
        )}

    <button onClick={insertData}>Insert Data</button>
  </div>
  );
};

export default requestForm;
