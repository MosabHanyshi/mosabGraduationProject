"use client"
import { useEffect } from "react";
import NavComponent from "../components/navbar";
import { checkAuth } from "@/utils/auth";
import router from "next/router";
import RequestForm from "../components/request/request";
import Layout from "../components/Layout";

export default function requests() {

  return (
    <>
 <Layout>
    <div>
      <RequestForm/>
      </div>
  </Layout>
  </>
  );
}
