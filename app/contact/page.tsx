"use client"
import NavComponent from "../components/navbar";
import { useEffect, useState } from "react";
import io, { Socket } from "socket.io-client";



export default function Contact()  {

  const [messages, setMessages] = useState<string[]>([]);
  const [messageInput, setMessageInput] = useState("");
  const socket: Socket = io("http://localhost:3001"); // Connect to the WebSocket server

  useEffect(() => {
    // Listen for incoming chat messages
    socket.on("chat message", (message: string) => {
      setMessages((prevMessages) => [...prevMessages, message]);
    });

    // Clean up on component unmount
    return () => {
      socket.disconnect();
    };
  }, [socket]);

  const sendMessage = () => {
    if (messageInput.trim() !== "") {
      socket.emit("chat message", messageInput);
      setMessageInput("");
    }
  };
  return (
    <main>
      <div>
        <ul>
          {messages.map((msg, index) => (
            <li key={index}>{msg}</li>
          ))}
        </ul>
        <input
          type="text"
          value={messageInput}
          onChange={(e) => setMessageInput(e.target.value)}
        />
        <button onClick={sendMessage}>Send</button>
      </div>
    </main>
  );
}
