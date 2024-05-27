// chuỗi kết nối CSDL
// const connect = mysql.createConnection({
//     host: "localhost",
//     user: "root",
//     password: "1234",
//     port: "3306",
//     database: "db_youtube"
// })

// yarn add sequelize
import { Sequelize } from "sequelize";
import config from "../configs/config.js";
console.log(config.db_database)
console.log(config.db_dialect)
console.log(config.db_host)
console.log(config.db_pass)
console.log(config.db_port)
console.log(config.db_user)

const sequelize = new Sequelize(config.db_database,config.db_user,config.db_pass,{
    host: config.db_host,
    dialect: config.db_dialect,
    port: config.db_port
})

export default sequelize

// yarn add sequelize-auto
// yarn sequelize-auto -h localhost -d db_youtube -u root -x 1234 -p 3306 --dialect mysql -o src/models -l esm
