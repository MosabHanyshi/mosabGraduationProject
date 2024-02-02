"use client"
import styles from "./styles.module.css";
import person from "../../public/images/person.png"
import Image from "next/image";
import { FaFacebookF, FaTwitter, FaInstagram, FaWhatsappSquare } from "react-icons/fa";
import NavComponent from "../components/navbar";
import { useEffect } from "react";
import { checkAuth } from "@/utils/auth";
import router from "next/router";
import Layout from '../components/Layout';

export default function about() {


  return (
    <>
      <Layout>
      {/* <NavComponent message={""} /> */}
      <div className={styles.page}>
        <div className={styles.aboutSection}>
          <h1>About Us Page</h1>
          <p>Kapatokiya is an online store that sells various electronics. 
            We have a large quantity of these electronics... 
            We hope that you will find everything you need with us.</p>
        </div>

        <h2>Our Team</h2>
        <div className={styles.row}>
          <div className={styles.column}>
            <div className={styles.card}>
              <div className={styles.image}>
                <Image src={person} alt="John" />
              </div>
              <div className={styles.container}>
                <h2>Jane Doe</h2>
                <p className={styles.title}>CEO & Founder</p>
                <p>Some text that describes me lorem ipsum ipsum lorem.</p>
                <p>jane@example.com</p>
                <p>
                  <button className={styles.button}>Contact</button>
                </p>
              </div>
            </div>
          </div>

          <div className={styles.column}>
            <div className={styles.card}>
              <div className={styles.image}>
                <Image src={person} alt="John" />
              </div>
              <div className={styles.container}>
                <h2>Mike Ross</h2>
                <p className={styles.title}>Art Director</p>
                <p>Some text that describes me lorem ipsum ipsum lorem.</p>
                <p>mike@example.com</p>
                <p>
                  <button className={styles.button}>Contact</button>
                </p>
              </div>
            </div>
          </div>

          <div className={styles.column}>
            <div className={styles.card}>
              <div className={styles.image}>
                <Image src={person} alt="John" />
              </div>
              <div className={styles.container}>
                <h2>John Doe</h2>
                <p className={styles.title}>Designer</p>
                <p>Some text that describes me lorem ipsum ipsum lorem.</p>
                <p>john@example.com</p>
                <p>
                  <button className={styles.button}>Contact</button>
                </p>
              </div>
            </div>
          </div>
        </div>

        <div className={styles.footer}>
          <a href="#" target="_blank" rel="noopener noreferrer">
            <FaFacebookF />
          </a>

          <a href="#" target="_blank" rel="noopener noreferrer">
            <FaTwitter />
          </a>

          <a href="#" target="_blank" rel="noopener noreferrer">
            <FaInstagram />
          </a>

          <a href="#" target="_blank" rel="noopener noreferrer">
            <FaWhatsappSquare />
          </a>
        </div>
      </div>
      </Layout>
    </>
  );
}
