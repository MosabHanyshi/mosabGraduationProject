// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyA_3uftbSRkLd2gnapIxrZiTiPPWR9ecpA",
  authDomain: "estore-90443.firebaseapp.com",
  projectId: "estore-90443",
  storageBucket: "estore-90443.appspot.com",
  messagingSenderId: "808244854090",
  appId: "1:808244854090:web:5c23f42a1f216586b195b3",
  measurementId: "G-FR1KHV4XTM"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);