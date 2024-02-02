// import { NextApiRequest, NextApiResponse } from 'next';
// import { PrismaClient } from '@prisma/client';

// const prisma = new PrismaClient();

// export default async function handler(req: NextApiRequest, res: NextApiResponse) {
//   if (req.method === 'POST') {
//     const { username, email, password } = req.body;

//     const user_name =  username;
//     const user_email = email ;
//     const user_password = password ;

//     try {

//       const existingUser = await prisma.users.findFirst({
//         where: {
//           user_email: email,
//         },
//       });

//       console.log("this email is used please try another email : ",existingUser)

//       if (existingUser) {
//         return res.status(400).json({ error: 'User with this email already exists' });
//       }

//       const newUser = await prisma.users.create({
//         data: {
//           user_name,
//           user_email,
//           user_password,
//         },
//       });

//       res.status(201).json(newUser);
//     } catch (error) {
//       console.error('Error registering user:', error);
//       res.status(500).json({ error: 'Internal Server Error' });
//     }
//   } else {
//     res.status(405).json({ error: 'Method Not Allowed' });
//   }
// }





// pages/api/register.ts
import { NextApiRequest, NextApiResponse } from 'next';
import { generateToken, hashPassword } from '../../utils/auth';
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

export default async function handler(req: NextApiRequest, res: NextApiResponse) {
  if (req.method === 'POST') {

    const { username, email, password } = req.body;
    const user_name =  username;
    const user_email = email ;
    const user_password = password ;

    try {
      // Check if the user with the given email already exists
           const existingUser = await prisma.users.findFirst({
        where: {
          user_email: email,
        },
      });

      if (existingUser) {
        return res.status(400).json({ error: 'User with this email already exists' });
      }

      // Hash the password
      const hashedPassword = await hashPassword(user_password as string);

      // Insert the new user into the database
      const newUser = await prisma.users.create({
        data: {
          user_name,
          user_email,
          user_password: hashedPassword,
        },
      });

      // Generate and send the token
      const token = generateToken({ userId: newUser.user_id });
      res.status(201).json({ token });
    } catch (error) {
      console.error('Error registering user:', error);
      res.status(500).json({ error: 'Internal Server Error' });
    }
  } else {
    res.status(405).json({ error: 'Method Not Allowed' });
  }
}
