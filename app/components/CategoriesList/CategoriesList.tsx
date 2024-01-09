import React, { useState, useEffect } from 'react';
import axios from 'axios';

interface Category {
  category_id: number;
  category_name: string;
}

interface SearchAndCategoriesProps {
  onSearchTerm: (term: string) => void;
  onSelectCategory: (category: string) => void;
}

const SearchAndCategories: React.FC<SearchAndCategoriesProps> = ({
  onSearchTerm,
  onSelectCategory,
}) => {
  const [searchTerm, setSearchTerm] = useState<string>('');
  const [categories, setCategories] = useState<Category[]>([]);

  useEffect(() => {
    // Fetch categories from the server
    const fetchCategories = async () => {
      try {
        const response = await axios.get('/api/categories');
        setCategories(response.data);
      } catch (error) {
        console.error('Error fetching categories:', error);
      }
    };

    fetchCategories();
  }, []);

  const handleSearchTermChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const term = e.target.value;
    setSearchTerm(term);
    onSearchTerm(term);
  };

  return (
    <div>
      {/* Search Bar */}
      <input
        type="text"
        placeholder="Search products..."
        value={searchTerm}
        onChange={handleSearchTermChange}
        style={{
          color: "#39A7FF", // Text color
          border: "1px solid #39A7FF", // Border color and style
        }}
      />

      {/* Categories Dropdown List */}
      <select
        onChange={(e) => onSelectCategory(e.target.value)}
        value={searchTerm}
      >
        <option value="">Select a category</option>
        {categories.map((category) => (
          <option key={category.category_id} value={category.category_name}>
            {category.category_name}
          </option>
        ))}
      </select>
    </div>
  );
};

export default SearchAndCategories;
