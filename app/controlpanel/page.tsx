"use client";
import { Category } from "@mui/icons-material";
import styles from "./styles.module.css";
import { useEffect, useState } from "react";
import Admins from "./components/admins/page"
import Users from "./components/users";
import Categories from "./components/categories";
import Products from "./components/products";
import Orders from "./components/orders/page";
import Sidebar from "./components/sidebar/sidebar";
import Payments from "./components/payments/page";
import Profits from "./components/profits/page";
import Request from "./components/requests/page";
import Campaigns from "./components/campaigns/page";
import NavComponent from "../components/navbar";


const ControlPanel:React.FC = () => {


  const [admins, setAdmins] = useState(false);
  const [users, setUsers] = useState(false);
  const [categories, setCategories] = useState(false);
  const [products, setProducts] = useState(false);
  const [orders, setOrders] = useState(false);
  const [payments, setPayments] = useState(false);
  const [profits, setProfits] = useState(false);
  const [requests, setRequests] = useState(false);
  const [campaigns, setCampaigns] = useState(false);
  


  

 const handlePageClick = (pageName: string) =>{

  console.log(pageName);

  if(pageName === 'Admins'){ 
     setAdmins(true);
     setUsers(false);
     setCategories(false);
     setProducts(false);
     setOrders(false);
     setProfits(false);
     setRequests(false);
     setCampaigns(false);
  }

  if(pageName === 'Users'){
    setAdmins(false);
    setUsers(true);
    setCategories(false);
    setProducts(false);
    setOrders(false);
    setPayments(false);
    setProfits(false);
    setRequests(false);
    setCampaigns(false);
  }

   if (pageName === "Categories"){
    setAdmins(false);
    setUsers(false);
    setCategories(true);
    setProducts(false);
    setOrders(false);
    setPayments(false);
    setProfits(false);
    setRequests(false);
    setCampaigns(false);
   }

  if(pageName === 'Products'){
     setAdmins(false);
     setUsers(false);
     setCategories(false);
     setProducts(true);
     setOrders(false);
     setPayments(false);
     setProfits(false);
     setRequests(false);
     setCampaigns(false);
     
  }

  if (pageName === "Orders") {
    setAdmins(false);
    setUsers(false);
    setCategories(false);
    setProducts(false);
    setOrders(true);
    setPayments(false);
    setProfits(false);
    setRequests(false);
    setCampaigns(false);
  }

  if(pageName === 'Payments'){
     setAdmins(false);
     setUsers(false);
     setCategories(false);
     setProducts(false);
     setOrders(false);
     setPayments(true);
     setProfits(false);
     setRequests(false);
     setCampaigns(false);
    
  }

  if(pageName === 'Profits'){
    setAdmins(false);
    setUsers(false);
    setCategories(false);
    setProducts(false);
    setOrders(false);
    setPayments(false);
    setProfits(true);
    setRequests(false);
    setCampaigns(false);
  }

  if (pageName === "Requests") {
    setAdmins(false);
    setUsers(false);
    setCategories(false);
    setProducts(false);
    setOrders(false);
    setPayments(false);
    setProfits(false);
    setRequests(true);
    setCampaigns(false);
  }

  if (pageName === "Campaigns") {
    setAdmins(false);
    setUsers(false);
    setCategories(false);
    setProducts(false);
    setOrders(false);
    setPayments(false);
    setProfits(false);
    setRequests(false);
    setCampaigns(true);
  }
  }

 

  return (
    <>
      {/* <NavComponent message={""} /> */}
      <div className={styles.page}>
        <div className={styles.leftColumn}>
          <Sidebar onPageClick={handlePageClick} />
        </div>

        <div className={styles.rightColumn}>
          {admins ? <Admins /> : null}
          {users ? <Users /> : null}
          {categories ? <Categories /> : null}
          {products ? <Products /> : null}
          {orders ? <Orders/> : null}
          {payments ? <Payments/>: null}
          {profits ? <Payments/> : null}
          {requests ? <Request /> : null}
          {campaigns? <Campaigns/>: null}
        </div>
      </div>
    </>
  );
  }

export default ControlPanel;
