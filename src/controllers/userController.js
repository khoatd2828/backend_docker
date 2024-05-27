import initModels from "../models/init-models.js";
import sequelize from "../models/connect.js";
import { response } from "../configs/response.js";
import bcrypt from "bcrypt";
import {
  checkToken,
  checkTokenRef,
  createToken,
  createTokenRef,
  decodeToken,
} from "../configs/jwt.js";
import { sendMail } from "../configs/mail.js";

let model = initModels(sequelize);

const getUser = (req, res) => {
  res.send("get user");
};

// yarn add bcrypt
const signUp = async (req, res) => {
  console.log(`abc`, req.body);
  let { fullName, email, password } = req.body;

  //check email trùng
  let checkEmail = await model.users.findOne({
    where: {
      email: email,
    },
  });

  if (checkEmail) {
    //response ko co chuc nang dung lenh
    response(res, "", "Email đã tồn tại", 400);
    return;
  }

  // INSERT INTO user (....) VALUE (......)
  let newData = {
    full_name: fullName,
    email: email,
    avatar: "",
    pass_word: bcrypt.hashSync(password, 10),
    face_app_id: "",
    role: "USER",
    refresh_token: "",
  };

  model.users.create(newData);

  response(res, "", "Đăng ký thành công", 200);
};

function generateRandomString() {
  const characters =
    "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
  let randomString = "";

  for (let i = 0; i < 6; i++) {
    const randomIndex = Math.floor(Math.random() * characters.length);
    randomString += characters.charAt(randomIndex);
  }

  return randomString;
}

const logIn = async (req, res) => {
  try {
    let { email, password } = req.body;

    //check email trùng
    let checkEmail = await model.users.findOne({
      where: {
        email: email,
      },
    });

    if (checkEmail) {
      // if (password==checkEmail.pass_word) {
      if (bcrypt.compareSync(password, checkEmail.pass_word)) {
        let key = generateRandomString();

        let token = createToken({ userId: checkEmail.dataValues.user_id, key });

        let tokenRef = createTokenRef({
          userId: checkEmail.dataValues.user_id,
          key,
        });
        // update lai table user
        checkEmail.refresh_token = tokenRef;
        model.users.update(checkEmail.dataValues, {
          where: {
            user_id: checkEmail.dataValues.user_id,
          },
        });

        response(res, token, "Đăng nhập thành công", 200);
      } else {
        response(res, "", "Mật khẩu không đúng!", 400);
      }
    } else {
      response(res, "", "Email không đúng!", 400);
    }
  } catch (error) {
    console.log(error);
  }
};

const resetToken = async (req, res) => {
  console.log(`refresh token`);
  // check lại token
  let { token } = req.headers;

  let errorToken = checkToken(token);
  if (errorToken != null && errorToken.name != "TokenExpiredError") {
    response(res, "", "Not Authorized", 401);
    return;
  }

  let { data } = decodeToken(token);
  let getUser = await model.users.findByPk(data.userId);

  let tokenRef = decodeToken(getUser.dataValues.refresh_token);

  if (data.key != tokenRef.data.key) {
    response(res, "", "Not Authorized", 401);
    return;
  }

  // check refresh token => expired
  // userId
  if (checkTokenRef(getUser.dataValues.refresh_token) != null) {
    response(res, "", "Not Authorized", 401);
    return;
  }

  // create token
  let tokenNew = createToken({
    userId: getUser.dataValues.user_id,
    key: tokenRef.data.key,
  });

  response(res, tokenNew, "", 200);
};

const loginFacebook = async (req, res) => {
  let { userID, name, email } = req.body;

  let checkUser = await model.users.findOne({
    where: {
      face_app_id: userID,
    },
  });

  let user_id = "";

  if (checkUser) {
    user_id = checkUser.dataValues.user_id;
  } else {
    // check ton tai email

    // chua ton tai
    let newData = {
      full_name: name,
      email: email,
      avatar: "",
      pass_word: "",
      face_app_id: "userID",
      role: "USER",
      refresh_token: "",
    };

    let data = await model.users.create(newData);

    user_id = data.dataValues.user_id;
  }

  //ton tai
  // create token
  let key = generateRandomString();

  let token = createToken({ userId: user_id, key });

  let tokenRef = createTokenRef({ userId: user_id, key });
  // update refresh token
  response(res, token, "", 200);
};

const forgetCheckMail = async (req, res) => {
  let { email } = req.body;
  //check mail
  let checkEmail = await model.users.findOne({
    where: {
      email: email,
    },
  });

  if (!checkEmail) {
    response(res, "", "Email không tồn tại", 404);
    return;
  }
  //create code
  let dNow = new Date();
  let code = generateRandomString();
  let newCode = {
    code: code,
    expired: dNow.setMinutes(dNow.getMinutes() + 10),
  };
  model.code.create(newCode);
  //send mail code
  sendMail(email, "Lấy lại mật khẩu", code);

  response(res, true, "", 200);
};

const forgetCheckCode = async (req, res) => {
  //Check code
  let { code } = req.body;

  let checkCode = await model.code.findOne({
    where: {
      code: code,
    },
  });

  if (checkCode) {
    model.code.destroy({
      where: {
        id: checkCode.dataValues.id,
      },
    });
    response(res, true, "", 200);
  } else {
    response(res, false, "Code không đúng", 403);
  }
  //remove code
};
export {
  getUser,
  signUp,
  logIn,
  resetToken,
  loginFacebook,
  forgetCheckMail,
  forgetCheckCode,
};
