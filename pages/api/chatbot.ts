// // pages/api/chatbot.ts
// import { NextApiRequest, NextApiResponse } from 'next';
// import OpenAI, { RateLimitError } from 'openai';


// const RATE_LIMIT_DELAY_MS = 1000; // 1 second delay
// const OPENAI_API_KEY = process.env.NEXT_PUBLIC_OPENAI_API_KEY;




// function delay(ms: number | undefined) {
//   return new Promise(resolve => setTimeout(resolve, ms));
// }



// if (!OPENAI_API_KEY) {
//   throw new Error('OpenAI API key is missing.');
// }

// const openai = new OpenAI({ apiKey: OPENAI_API_KEY });

// export default async function handler(req: NextApiRequest, res: NextApiResponse) {
//   try {
//     const completion = await openai.chat.completions.create({
//       messages: [
//         {
//           role: 'system',
//           content: 'You are a helpful assistant designed to output JSON.',
//         },
//         { role: 'user', content: req.query.userInput as string },
//       ],
//       model: 'gpt-3.5-turbo',
//       response_format: { type: 'json_object' },
//     });

    

//     res.status(200).json({ response: completion.choices[0].message.content });
//   } catch (error) {
//     if (error instanceof RateLimitError) {
//       // Handle rate-limiting error
//       console.error('Rate-limit exceeded. Please try again later.');
//       await delay(RATE_LIMIT_DELAY_MS);
//       res.status(429).json({ error: 'Rate-limit exceeded. Please try again later.' });
//     } else {
//       console.error('OpenAI API error:', error);
//       res.status(500).json({ error: 'Internal Server Error' });
//     }
//   }
// }


import { Configuration, OpenAIApi } from 'openai-edge';
import { OpenAIStream, StreamingTextResponse } from 'ai';

// Create an OpenAI API client (that's edge friendly!)
const config = new Configuration({
  apiKey: process.env.OPENAI_API_KEY,
});

const openai = new OpenAIApi(config);

// Set the runtime to edge for best performance
export const runtime = 'edge';

export async function POST(req: Request) {
  const { prompt } = await req.json();

  // Ask OpenAI for a streaming completion given the prompt
  const response = await openai.createCompletion({
    model: 'text-davinci-003',
    stream: true,
    temperature: 0.6,
    prompt: `Convert the given code to ruby.
              User: ${prompt}
              Agent:`
  });
  // Convert the response into a friendly text-stream
  const stream = OpenAIStream(response);
  // Respond with the stream
  return new StreamingTextResponse(stream);
}