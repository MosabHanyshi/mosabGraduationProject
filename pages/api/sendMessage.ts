// pages/api/sendEmail.ts
import { NextApiRequest, NextApiResponse } from 'next';
import axios, { AxiosError } from 'axios';

export default async function handler(req: NextApiRequest, res: NextApiResponse) {
  if (req.method !== 'POST') {
    return res.status(405).end(); // Method Not Allowed
  }

  const { to, subject, text } = req.body;

  const senderEmail = 'ahmadwnabhan1999@gmail.com'; // Update this with a verified sender in your Mailgun account


  const apiKey = process.env.MAILGUN_API_KEY;
  const domain = process.env.MAILGUN_DOMAIN;

  if (!apiKey || !domain) {
    return res.status(500).json({ success: false, message: 'Mailgun API key or domain not configured.' });
  }

  const apiUrl = `https://api.mailgun.net/v3/${domain}/messages`;

  try {

    const response = await axios.post(
      apiUrl,
      new URLSearchParams({
        from: senderEmail,
        to: Array.isArray(to) ? to.join(',') : to,
        subject: subject,
        text: text,
      }),
      {
        auth: {
          username: 'api',
          password: apiKey,
        },
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      }
    );

    return res.status(200).json({
      success: true,
      message: 'Email sent successfully',
      response: response.data,
    });
  } catch (error: unknown) {
    if (axios.isAxiosError(error)) {
      const axiosError = error as AxiosError;
      console.error('Axios Error:', axiosError.response?.data || axiosError.message);
    } else {
      console.error('Error:', (error as Error).message);
    }

    return res.status(500).json({ success: false, message: 'Failed to send email' });
  }
}
