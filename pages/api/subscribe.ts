// pages/api/subscribe.ts
import { NextApiRequest, NextApiResponse } from 'next';
import axios from 'axios';

const MAILCHIMP_API_KEY = 'ddf13a071f6998652f3cfda1a2ce299c-us21';
const MAILCHIMP_LIST_ID = 'd2d45c331c';

export default async function handler(req: NextApiRequest, res: NextApiResponse) {
  if (req.method === 'POST') {
    const { email } = req.body;

    try {
      // Check if the email already exists in the Mailchimp list
      const checkResponse = await axios.get(
        `https://us21.api.mailchimp.com/3.0/lists/${MAILCHIMP_LIST_ID}/members/${encodeURIComponent(email)}`,
        {
          headers: {
            'Content-Type': 'application/json',
            Authorization: `Bearer ${MAILCHIMP_API_KEY}`,
          },
        }
      );

      // If the email already exists, handle it accordingly (return an error, update the existing user, etc.)
      console.log('Email already exists in Mailchimp:', checkResponse.data);
      res.status(400).json({ error: 'Email already exists' });
    } catch (error) {
      if (axios.isAxiosError(error) && error.response?.status === 404) {
        // If the error is a 404 (Not Found), the email doesn't exist, proceed with subscription
        try {
          const response = await axios.post(
            `https://us21.api.mailchimp.com/3.0/lists/${MAILCHIMP_LIST_ID}/members`,
            {
              email_address: email,
              status: 'subscribed',
            },
            {
              headers: {
                'Content-Type': 'application/json',
                Authorization: `Bearer ${MAILCHIMP_API_KEY}`,
              },
            }
          );

          res.status(200).json(response.data);
        } catch (subscribeError) {
          console.error('Error subscribing to Mailchimp:', subscribeError);
          res.status(500).json({ error: 'Internal server error' });
        }
      } else {
        console.error('Error checking Mailchimp for existing email:', error);
        res.status(500).json({ error: 'Internal server error' });
      }
    }
  } else {
    res.status(405).json({ error: 'Method Not Allowed' });
  }
}
