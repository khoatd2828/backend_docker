import { DataTypes, Model } from "sequelize";
import sequelize from "./connect.js";
class Video extends Model {}

Video.init(
    // định nghĩa column mapping với table trong database
    {
        video_id: {
            type: DataTypes.INTEGER,
            primaryKey: true, 
            autoIncrement: true,
        },
        video_name: {
            type: DataTypes.STRING
        },
        thumbnail: {
            type: DataTypes.STRING
        },

        description: {
            type: DataTypes.TEXT
        },
        source: {
            type: DataTypes.STRING
        },
        user_id: {
            type: DataTypes.INTEGER
        },
        type_id: {
            type: DataTypes.INTEGER
        }

    },
    //kết nối CSDL, ánh xạ ten model với tên table
    {
        sequelize: sequelize,
        modelName: "Video",
        timestamps: false,
        tableName: "video", //ánh tạ tên model với tên table

    }
)

export default Video