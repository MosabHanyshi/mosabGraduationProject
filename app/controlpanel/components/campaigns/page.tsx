// SendEmails.tsx
import React, { useState } from "react";
import axios from "axios";
import styles from "./styles.module.css"; // Import the styles

const SendEmails: React.FC = () => {
  const [toEmails, setToEmails] = useState("");
  const [subject, setSubject] = useState("");
  const [text, setText] = useState("");
  const [result, setResult] = useState<{
    success: boolean;
    message: string;
  } | null>(null);

  const sendEmails = async () => {
    try {
      const response = await axios.post("/api/sendMessage", {
        to: toEmails,
        subject: subject,
        text: text,
      });

      setResult(response.data);
    } catch (error) {
      console.error(
        "Error sending emails:",
        (error as any)?.response?.data || (error as any)?.message
      );
      setResult({ success: false, message: "Failed to send emails" });
    }
  };

  return (
    <div className={styles.emailFormContainer}>
      <h1>Send Emails</h1>
      <div className={styles.formInput}>
          <input
            type="text"
            value={toEmails}
            onChange={(e) => setToEmails(e.target.value)}
          />
      </div>
      <div className={styles.formInput}>
        <h2>The subject</h2>
        <input
          type="text"
          value={subject}
          onChange={(e) => setSubject(e.target.value)}
        />
      </div>
      <div className={styles.formInput}>
        <h2>Write here a message</h2>
        <textarea value={text} onChange={(e) => setText(e.target.value)} />
      </div>
      <button className={styles.buttonPrimary} onClick={sendEmails}>
        Send Emails
      </button>

      {result && (
        <div>
          <p>
            {result.success
              ? "Emails sent successfully"
              : "Failed to send emails"}
          </p>
          <p>{result.message}</p>
        </div>
      )}
    </div>
  );
};

export default SendEmails;
