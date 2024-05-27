//setup server BE nodejs

// ctrl + J => mở terminal
// yarn init => enter tới chết

// yarn add express 

import rootRouter from './routes/rootRouter.js'
import mysql from 'mysql2';
import express from 'express'
import cors from 'cors'

const app = express()
// mở chặn CORS
// yarn add cors
app.use(cors())

// chèn middle ware khi FE  request BE
app.use(express.json())

app.use(express.static("./public/img"))// dinh vi duong dan de BE load 

app.use(rootRouter)
// app.use(cors({
//     origin:["http://localhost:3000","https://google.com"]
// }))



// khởi tạo server với port
app.listen(8080)

// ctrl+ C => tắt server
// yarn add nodemon => watching => auto restart server => developer

// định nghĩa API
// endpoint => GET: demo 
// rest params: function(...rest)

app.get("/demo/:id", (request, response) => {

    // trả data trên URL
    // + Query string: localhost:8080/demo?id=1&hoTen=John Cena
    let { hoTen } = request.query
    // + query params: localhost:8080/demo/1
    let { id } = request.params

    // trả json (body)
    let { email, phone, address } = request.body
    /*
        {
            "email":"john@gmail.com",
            "phone":"0909090",
            "address":"111 DPB"
        }
    */

    // 100 - 599
    response.status(209).send({ id, hoTen, email, phone, address }) // string, object, list, list object,.. trừ number

})

// yarn add mysql2



// API 
// endpoint: viết thường, cách nhau bởi gạch ngang, kiểu dữ kiệu luôn luôn là string


// MVC  MC Routes

import swaggerUi from 'swagger-ui-express';
import swaggerJsDoc from 'swagger-jsdoc';

const options = {
    definition: {
        info: {
            title: "api",
            version: "1.0.0"
        }
    },
    apis: ["src/swagger/index.js"]
}

const specs = swaggerJsDoc(options);

app.use("/swagger", swaggerUi.serve, swaggerUi.setup(specs));

// yarn add prisma @prisma/client

// yarn prisma init

// Update lai chuoi ket noi csdl trong .env va file schema.prisma

// database First => yarn prisma db pull

// yarn prisma generate
import { PrismaClient } from '@prisma/client';
let prisma = new PrismaClient()

app.get("/user/get-all-user", async (req, res) => {
    let id = 2
    let data = await prisma.users.findMany({
        // where: {
        //     video_id: id
        // },
        // include: {
        //     video_comment: {
        //         include: {
        //             users: true
        //         }
        //     },
        // }
    })
    res.send(data)

    //destroy
    // model.video.delete()

    //prisma
    //video.create({video_id, video_name, ..})

    //prisma
    // model.video.create({
    //     data: [video_id, video_name,...]
    // })

    // model.video.update({
    //     data: [video_id, video_name,...],
    //     where: {}
    // })
}) 

import { createServer } from "http";
import { Server } from "socket.io";

const httpServer = createServer(app);

//doi tượng socket server
const io = new Server(httpServer, { cors: {
    origin: "*"
} });


//lắng nghe key: connection => khi client kết nối server
io.on("connection", (socket) => {
    // app chat
    socket.on("send-mess", (data) => {
        io.emit("server-client", data)
    })




//     // add vao room voi room key
//     socket.join("room-1")
//   // xử lý các sự kiện liên quan đến realtime
//   //key, value
//   //client nao gui client do nhan socket.emit
//   //toan bo client nhan
//   io.to("room-1").to("room-2").emit("send-data", socket.id)
//   socket.on("client-data", (data) => {
//     console.log(data)
//   })
});

httpServer.listen(8081);