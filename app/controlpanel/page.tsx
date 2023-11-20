"use client";
import { Category } from "@mui/icons-material";
import styles from "./styles.module.css";
import { useEffect, useState } from "react";
import Users from "./components/users";
import Categories from "./components/categories";
import Products from "./components/products";
import Sidebar from "./components/sidebar/sidebar";





const ControlPanel:React.FC = () => {

  const [users, setUsers] = useState(false);
  const [categories, setCategories] = useState(false);
  const [products, setProducts] = useState(false);

  

 const handlePageClick = (pageName: string) =>{

  if(pageName === 'Admin'){ 
     setUsers(false);
     setCategories(false);
     setProducts(false);
  }

  if(pageName === 'Users'){
    setUsers(true);
    setCategories(false);
    setProducts(false);
  }

   if (pageName === "Categories"){
    setUsers(false);
    setCategories(true);
    setProducts(false);
   }

  if(pageName === 'Products'){
     setUsers(false);
     setCategories(false);
     setProducts(true);
  }

 }

  return (
    <div className={styles.page}>
      <div className={styles.leftColumn}>
        <Sidebar onPageClick={handlePageClick} />
      </div>

      <div className={styles.rightColumn}>
        {users?<Users />:null}
        {categories?<Categories />:null}
        {products?<Products />:null}
      </div>
    </div>
  );
}

export default ControlPanel;
