// firebaseConfig.js

// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";

// Your web app's Firebase configuration
const firebaseConfig = {
  apiKey: "AIzaSyDutQupBXg2BGnBzdfeVcF9uCvirQFB9aE",
  authDomain: "e-commerce-agent-86a0e.firebaseapp.com",
  projectId: "e-commerce-agent-86a0e",
  storageBucket: "e-commerce-agent-86a0e.appspot.com",
  messagingSenderId: "375926798538",
  appId: "1:375926798538:web:a1d053e79ce84cabd39c33",
  measurementId: "G-C9T0PBVCZL"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);

export default app;
