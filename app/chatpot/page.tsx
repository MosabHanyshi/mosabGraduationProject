// "use client";
// import React, { useState } from "react";

// interface ChatItem {
//   role: "user" | "bot";
//   content: string;
// }

// const Chatbot: React.FC = () => {
//   const [userInput, setUserInput] = useState<string>("");
//   const [chatHistory, setChatHistory] = useState<ChatItem[]>([]);
//   const [isLoading, setIsLoading] = useState<boolean>(false);

//   const handleUserInput = async () => {
//     setIsLoading(true);

//     // Make a request to the API endpoint
//     try {
//       const response = await fetch(
//         `/api/chatbot?userInput=${encodeURIComponent(userInput)}`
//       );
//       const data = await response.json();

//       // Update chat history with user and bot messages
//       setChatHistory((prevChat) => [
//         ...prevChat,
//         { role: "user", content: userInput },
//       ]);
//       setChatHistory((prevChat) => [
//         ...prevChat,
//         { role: "bot", content: data.response },
//       ]);
//     } catch (error) {
//       console.error("API error:", error);
//     }

//     setIsLoading(false);
//   };

//   return (
//     <div
//       style={{
//         maxWidth: "400px",
//         margin: "auto",
//         padding: "20px",
//         border: "1px solid #ccc",
//         borderRadius: "10px",
//       }}
//     >
//       <div
//         style={{
//           marginBottom: "10px",
//           minHeight: "150px",
//           overflowY: "auto",
//           padding: "10px",
//           border: "1px solid #ddd",
//           borderRadius: "5px",
//         }}
//       >
//         {chatHistory.map((item, index) => (
//           <div
//             key={index}
//             className={item.role === "user" ? "user-message" : "bot-message"}
//           >
//             {item.content}
//           </div>
//         ))}
//       </div>
//       <input
//         type="text"
//         value={userInput}
//         onChange={(e) => setUserInput(e.target.value)}
//         placeholder="Type your message..."
//         style={{
//           width: "80%",
//           padding: "8px",
//           marginRight: "5px",
//           borderRadius: "5px",
//           border: "1px solid #ccc",
//         }}
//       />
//       <button
//         onClick={handleUserInput}
//         disabled={isLoading}
//         style={{
//           padding: "8px",
//           borderRadius: "5px",
//           background: "#4CAF50",
//           color: "white",
//           border: "none",
//           cursor: "pointer",
//         }}
//       >
//         {isLoading ? "Loading..." : "Send"}
//       </button>
//     </div>
//   );
// };

// export default Chatbot;


"use client";

import { checkAuth } from "@/utils/auth";
import { useCompletion, useChat } from "ai/react";
import router from "next/router";
import { useEffect } from "react";
import Layout from "../components/Layout";

export default function ConvertToRuby() {
  const { completion, input, handleInputChange, handleSubmit } = useCompletion({
    api: "/api/chatbot",
  });

  


  return (
    <>
    <Layout>
    <div className="mx-auto w-full max-w-md py-24 flex flex-col stretch">
      <form onSubmit={handleSubmit}>
        <input
          className="fixed w-full max-w-md bottom-0 border border-gray-300 rounded mb-8 shadow-xl p-2 text-black"
          value={input}
          placeholder="Conver to Ruby..."
          onChange={handleInputChange}
        />
      </form>
      <div className="whitespace-pre-wrap my-6">{completion}</div>
    </div>
    </Layout>
    </>
  );
}