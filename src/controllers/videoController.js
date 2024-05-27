import Video from "../models/video1.js"
import initModels from "../models/init-models.js"
import sequelize from "../models/connect.js"
import { response } from "../configs/response.js"
import { decodeToken } from "../configs/jwt.js"

const model = initModels(sequelize)

const getVideo = async (req, res) => {
    //SELECT * FROM Video where user_id = 5
    // [{}, {}],
    let data = await model.video.findAll({
        where: {
            video_id: 5,
        }
    })

    data = await model.video.findByPk(5)
    //SELECT * FROM Video LIMIT 1
    // data = await model.video.findOne()
    // {}

    // SELECT * FROM video JOIN video_type

    data = await model.video.findAll({
        include:["type", "user"]
    })
    response(res, data, "Thành công", 200)

}

const createVideo = (req, res) => {

}

const updateVideo = (req, res) => {

}

const getVideoType = async (req, res) => {
    let data = await model.video_type.findAll()
    // res.send(data)
    response(res, data, "Thành công", 200)
}

const getVideoWithType = async (req, res) => {
    
    try{
        let { typeId } = req.params;
        //select * from video where type_id = typeId
        let data = await model.video.findAll({
            where: {
                type_id: typeId
            },
            include:["type", "user"]
        })
        response(res, data, "Thành công", 200)
    }catch(exption){
        response(res, "", "Lỗi hệ thống", 500)
    }
}

const getVideoPage = async (req, res) => {
    try{
        let {page} = req.params
        let pageSize = 3
        let index = (page - 1) * pageSize
        //select * from video limit index, pageSize
        let data = await model.video.findAll({
            offset: index,
            limit: pageSize
        })
        let totalItem = await model.video.count()
        let totalPage = Math.ceil(totalItem / pageSize)
        // res.send(data)
        response(res, {listVideo:data, totalPage}, "Thành công", 200)
    }catch(exption){
        response(res, "", "Lỗi hệ thống", 500)
    }
}

const getVideoDetail = async (req, res) => {
    try{
        let {videoId} = req.params
        let data = await model.video.findByPk(videoId, {
            include: ["type", "user"]
        })
       response(res, data, "Thành công", 200)
    }catch(exption){
        response(res, "", "Lỗi hệ thống", 500)
    }
}

const getComment = async (req, res) => {
    try{
        let {videoId} = req.params
        let data = await model.video_comment.findAll({
            where: {
                video_id: videoId,
            },
            include: ["user", "video"],
            order: 
            [
                ["date_create", "DESC"]
            ]
            
        })

        response(res, data, "Thanh Cong", 200)
    }catch(exption){
        response(res, "", "Lỗi hệ thống", 500)
    }
}

const createComment = async (req, res) => {
    try{
        let {videoId, content} = req.body
        let {token} = req.headers
        let {data} = decodeToken(token)

        //liên quan đến ngày tháng năm => lấy từ sever => BE
        let dateComment = new Date()

        let newData = {
            user_id: data.userId,
            video_id: videoId,
            content: content,
            date_create: dateComment    
        }

        await model.video_comment.create(newData)

        response(res, data, "Binh Luan Thanh Cong", 200)
    }catch(exption){
        response(res, "", "Lỗi hệ thống", 500)
    }
}

export {
    getVideo,
    createVideo,
    updateVideo,
    getVideoType,
    getVideoWithType,
    getVideoPage,
    getVideoDetail,
    getComment,
    createComment
}