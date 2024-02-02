import { NextRequest, NextResponse } from 'next/server';
import bcryptjs from 'bcryptjs';
import jwt from 'jsonwebtoken';
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

export async function POST(request: NextRequest) {
    try {
        const reqBody = await request.json();
        const { user_email, user_password } = reqBody;

        const user = await prisma.users.findFirst({ where: { user_email } });

        if (!user) {
            return NextResponse.json(
                {
                    error: 'User does not exist in DB',
                },
                { status: 400 }
            );
        }

        const validPassword = await bcryptjs.compare(user_password, user.user_password);

        if (!validPassword) {
            return NextResponse.json({ error: 'Invalid password' }, { status: 400 });
        }

        const tokenData = {
            id: user.user_id,
            username: user.user_name,
            email: user.user_email,
        };

        const token = await jwt.sign(tokenData, process.env.TOKEN_SECRET!, {
            expiresIn: '2d',
        });

        const response = NextResponse.json({
            message: 'Login Successful',
            success: true,
        });

        response.cookies.set('token', token, { httpOnly: true });
        return response;
    } catch (error: any) {
        return NextResponse.json({ error: error.message }, { status: 500 });
    } finally {
        await prisma.$disconnect();
    }
}
