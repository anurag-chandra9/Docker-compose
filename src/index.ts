import { PrismaClient } from '@prisma/client';

import express from 'express';
const app = express();

const prismaClient = new PrismaClient();
app.get('/', async (req,res)=>{

    const users = await prismaClient.user.findMany();
    res.json({
        "message": "GET request received",
        "data": users
    })
})
app.post('/', async (req,res)=>{
    await prismaClient.user.create({
        data: {
            username: Math.random().toString(36).substring(2, 15),
            password: Math.random().toString(36).substring(2, 15)
        }
    })
    res.json({
        "message": "Post request received"
    })
})





 
app.listen(3000, () => {
  console.log('Server is running on port 3000');
});
