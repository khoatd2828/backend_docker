import express from 'express'   
import videoRouter from './videoRoutes.js'
import userRouter from './userRouter.js'

const rootRouter = express()

rootRouter.use("/video", videoRouter)
rootRouter.use("/user", userRouter)

export default rootRouter 