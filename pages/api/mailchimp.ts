// Import necessary libraries
import axios, { AxiosResponse } from 'axios';

// Mailchimp API endpoint and list ID
const API_ENDPOINT = 'https://us21.api.mailchimp.com/3.0/lists/d2d45c331c';
const API_KEY = 'ddf13a071f6998652f3cfda1a2ce299c-us21';

// Interface for Mailchimp response
interface MailchimpResponse {
  id: string;
  email_address: string;
  status: string;
}

// Function to subscribe an email
const subscribeEmail = async (email: string): Promise<void> => {
  try {
    const response: AxiosResponse<MailchimpResponse> = await axios.post(
      `${API_ENDPOINT}/members`,
      {
        email_address: email,
        status: 'subscribed',
      },
      {
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${API_KEY}`,
        },
      }
    );

    console.log('Subscription successful:', response.data);
  } catch (error: any) {
    if (axios.isAxiosError(error) && error.response) {
      console.error('Error subscribing:', error.response.data);
    } else {
      console.error('Error subscribing:', error.message);
    }
  }
};

// Example usage
subscribeEmail('example@example.com');
