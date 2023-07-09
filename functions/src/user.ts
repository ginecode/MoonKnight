// import { onCall, onRequest } from "firebase-functions/v2/https";
// import * as logger from "firebase-functions/logger";
// // import * as functions from 'firebase-functions';
// import { auth } from "firebase-functions";
// import * as admin from "firebase-admin";
// import { Const, Status, User } from "./lib/chat_pb";
// import protobuf = require("protobufjs");
// import { getConst } from "./utils";

// export const allUsers = onRequest(async (request, response) => {
//     const total = (await admin.firestore().collection("users").get()).docs;

//     response.send(total.map((v) => {
//         // logger.info(v.data());

//         return v.data();
//     }));
// });

// const mapKeys = {
//     roomsList: 'rooms'
// };

// export const testUserModel = onRequest(async (request, response) => {
//     const user = new User();
//     user.setId('uid');
//     user.setEmail(null);
//     user.setName('displayName');
//     user.setPhoneNumber('phoneNumber');
//     user.setAvatarUrl('photoURL');
//     user.setRoomsList(['Hello', 'Hi', 'Sol']);
//     user.setCreatedAt((new Date()).toISOString());
//     user.setStatus(Status.ONLINE);
//     user.setOpen(true);

//     response.send(
//         `<html>
//             <div>${Object.entries(Const).map(v => `${v[0]} : ${v[1]}<br>`)}</div>
//             <br>
//             <div>${Object.keys(Const).map(v => v.toLowerCase()).toString()}</div>
//             <br>
//             <div>${user.toObject().toString()}</div>
//             <br>
//             <div>${getConst(Const.EMAIL)}</div>
//         </html>`
//     )

//     // response.send(Object.entries(Const));
//     // response.send(Object.keys(Const).map(v => v.toLowerCase()));
//     // response.send(user.toObject());
// })

// // export const newUser = onRequest(async (request, response) => {
// //     try {
// //         console.log(`--------------------`);

// //         const user = new User();
// //         user.setId('uid');
// //         user.setEmail(null);
// //         user.setName('displayName');
// //         user.setStatus(Status.TYPING);
// //         user.setPhoneNumber('phoneNumber');
// //         user.setAvatarUrl('photoURL');
// //         user.setRoomsList(['Hello', 'Hi', 'Sol']);
// //         user.setCreatedAt((new Date()).toISOString());
// //         user.setOpen(true)

// //         console.log(user.toObject());

// //         await admin.firestore().collection(getConst(Const.USERS)).doc('uid').set(renameMapKeys(new Map(Object.entries(user.toObject())), mapKeys));
// //         let hello = await admin.firestore().collection(getConst(Const.USERS)).doc('uid').get()
// //         response.contentType('json').send(hello.data());
// //         return;
// //     } catch (error) {
// //         response.send(`Error creating user: ${error}`);
// //     }
// // });

// // export const onUserSignIn = auth.user().onCreate(async (_user) => {
// //     const { uid, email, displayName, phoneNumber, photoURL } = _user;

// //     console.log(`***********************`);
// //     logger.info(_user.toJSON());

// //     try {
// //         const user = new User();
// //         user.setId(uid);
// //         user.setEmail(email);
// //         user.setName(displayName);
// //         user.setStatus(Status.TYPING);
// //         user.setPhoneNumber(phoneNumber);
// //         user.setAvatarUrl(photoURL);
// //         user.setRoomsList([]);
// //         user.setCreatedAt((new Date()).toISOString());
// //         user.setOpen(true)

// //         logger.debug(user.toString());

// //         await admin.firestore().collection(getConst(Const.USERS)).doc(uid).set(renameMapKeys(new Map(Object.entries(user.toObject())), mapKeys));
// //         logger.info(`New user ${email} created with ID ${uid}`);
// //     } catch (error) {
// //         console.error("Error creating user:", error);
// //     }
// // });

// // export const onUserUpdate = onCall(async (_request) => {
// //     const { uid, email, displayName, phoneNumber, photoURL } = auth.user.;

// //     console.log(`***********************`);
// //     logger.info(_user.toJSON());

// //     try {
// //         const user = new User();
// //         user.setId(uid);
// //         user.setEmail(email);
// //         user.setName(displayName);
// //         user.setStatus(Status.TYPING);
// //         user.setPhoneNumber(phoneNumber);
// //         user.setAvatarUrl(photoURL);
// //         user.setRoomsList([]);
// //         user.setCreatedAt((new Date()).toISOString());
// //         user.setOpen(true)

// //         logger.debug(user.toString());

// //         await admin.firestore().collection(getConst(Const.USERS)).doc(uid).set(renameMapKeys(new Map(Object.entries(user.toObject())), mapKeys));
// //         logger.info(`New user ${email} created with ID ${uid}`);
// //     } catch (error) {
// //         console.error("Error creating user:", error);
// //     }
// // });
