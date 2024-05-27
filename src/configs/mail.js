import nodemailer from 'nodemailer';


export const sendMail = (to, subject, text) => {

    let configMail = nodemailer.createTransport({
        service: "gmail",
        auth: {
            user: "dangkhoa020228@gmail.com",
            pass: "lmjcahvieyesvife"
        }
    })
    let infoMail = {
        from: "dangkhoa020228@gmail.com",
        to,
        subject,
        text
    }

    return configMail.sendMail(infoMail, error => error);

}