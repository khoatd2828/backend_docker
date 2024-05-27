// Nơi định nghĩa API
import express from 'express'
import { createComment, getComment, createVideo, getVideo, getVideoType, updateVideo, getVideoWithType, getVideoPage, getVideoDetail } from '../controllers/videoController.js'
import { verifyToken } from '../configs/jwt.js'

const videoRouter = express.Router()

videoRouter.get("/get-video", getVideo)

videoRouter.post("/create-video", createVideo)
videoRouter.put("/update-video", updateVideo)

//API get video type
videoRouter.get("/get-video-type", getVideoType)

//API get video with type
videoRouter.get("/get-video-with-type/:typeId", getVideoWithType)

//API get video page
videoRouter.get("/get-video-page/:page", verifyToken, getVideoPage)

// API get video Detail
videoRouter.get("/get-video-detail/:videoId", getVideoDetail)

//API get comment
videoRouter.get("/get-comment/:videoId", getComment)

//API comment
videoRouter.post("/comment/", createComment)

export default videoRouter

