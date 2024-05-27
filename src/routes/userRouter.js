// Nơi định nghĩa API
import express from 'express'
import {  getUser, signUp, logIn, resetToken, loginFacebook, forgetCheckMail, forgetCheckCode } from '../controllers/userController.js'
import { sendMail } from '../configs/mail.js'
import { upload } from '../configs/upload.js'
import compress_images from 'compress-images'
//yarn add compress-images
//yarn add pngquant-bin@6.0.1
// yarn add gifsicle@5.2.1
const userRouter = express.Router()

userRouter.get("/get-user", getUser)

// API signup
userRouter.post("/sign-up", signUp)
// API login
userRouter.post("/login", logIn)

// API reset token
userRouter.post("/reset-token", resetToken)

//API login FB
userRouter.post("/login-facebook", loginFacebook)


//API checkmail => forget mat khau
userRouter.post("/forget-check-mail", forgetCheckMail)
//API code => forget mat khau
userRouter.post("/forget-check-code", forgetCheckCode)

//file system
import fs from 'fs'

// API upload avatar
userRouter.post("/upload-avatar", upload.single("avatar"), (req, res) => {

    //tao file ten data.txt => hello node41
    // fs.writeFile(process.cwd()+"/data.txt", "hello node41", (err) => {})

    // > 900KB moi giam 

    let file = req.file

    // duong dan toi hinh can toi uu
    let input = process.cwd() + "/public/img/" + file.filename
    //duong dan toi hinh anh da toi uu
    let output = process.cwd() + "/public/file/"

    compress_images(input, output, { compress_force: false, statistic: true, autoupdate: true }, false,
                    { jpg: { engine: "mozjpeg", command: ["-quality", "20"] } },
                    { png: { engine: "pngquant", command: ["--quality=20-50", "-o"] } },
                    { svg: { engine: "svgo", command: "--multipass" } },
                    { gif: { engine: "gifsicle", command: ["--colors", "64", "--use-col=web"] } },
        function (error, completed, statistic) {
            // xoa hinh chua toi uu
            console.log("-------------");
            console.log(error);
            console.log(completed);
            console.log(statistic);
            console.log("-------------");
        }
    );  
    res.send("ok")

    // fs.readFile(process.cwd() + "/public/img/" + file.filename, (err, data) => {
    //     let base64 = Buffer.from(data).toString("base64");

    //     res.send(base64);
    // })
    // let files = req.files

    // let {token} = req.headers
    //decode user id
    //getUser
    //update avatar
    // res.send(file)
})

export default userRouter 

//lmjc ahvi eyes vife
// nodemailer