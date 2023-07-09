// import { onCall, onRequest } from "firebase-functions/v2/https";
// import * as logger from "firebase-functions/logger";
// import * as functions from 'firebase-functions';
import { firestore /*, auth*/ } from "firebase-functions";
import * as admin from "firebase-admin";

import { FieldValue } from "firebase-admin/firestore";
// import { Const, Room, RoomAccess, RoomUser } from "./lib/chat_pb";
// import { getConst } from "./utils";

// const mapKeys = {
//     membersList: 'members'
// };

// export const testRoomModel = onRequest(async (request, response) => {
//     const room = new Room();
//     room.setId('uid')
//     room.setName('name')
//     room.setMembersList([new RoomUser()])
//     room.setOpen(true)
//     room.setAvatarUrl('http.url')

//     response.send(
//         `<html>
//             <div>${Object.entries(Const).map(v => `${v[0]} : ${v[1]}<br>`)}</div>
//             <br>
//             <div>${Object.keys(Const).map(v => v.toLowerCase()).toString()}</div>
//             <br>
//             <div>${room.toObject().toString()}</div>
//             <br>
//             <div>${getConst(Const.EMAIL)}</div>
//         </html>`
//     )
// })

export const updateRoomTweetCount = firestore
    .document('rooms/{roomId}/tweets/{tweetId}')
    .onWrite(async (change, context) => {
        const roomId = context.params.roomId;
        const roomRef = admin.firestore().collection('rooms').doc(roomId);

        // Increment or decrement depending on whether the tweet was created or deleted
        if (change.before.exists && !change.after.exists) {
            // Message deleted, decrement count
            return roomRef.update({ tweetCount: FieldValue.increment(-1) });
        } else if (!change.before.exists && change.after.exists) {
            // Message added, increment count
            return roomRef.update({ tweetCount: FieldValue.increment(1) });
        }

        // No change in tweet count, do nothing
        return null;
    });

// export const newUser = onRequest(async (request, response) => {
//     try {
//         console.log(`--------------------`);

//         const user = new User();
//         user.setId('uid');
//         user.setEmail(null);
//         user.setName('displayName');
//         user.setStatus(Status.TYPING);
//         user.setPhoneNumber('phoneNumber');
//         user.setAvatarUrl('photoURL');
//         user.setRoomsList(['Hello', 'Hi', 'Sol']);
//         user.setCreatedAt((new Date()).toISOString());
//         user.setOpen(true)

//         console.log(user.toObject());

//         await admin.firestore().collection(getConst(Const.USERS)).doc('uid').set(renameMapKeys(new Map(Object.entries(user.toObject())), mapKeys));
//         let hello = await admin.firestore().collection(getConst(Const.USERS)).doc('uid').get()
//         response.contentType('json').send(hello.data());
//         return;
//     } catch (error) {
//         response.send(`Error creating user: ${error}`);
//     }
// });

// export const onUserSignIn = auth.user().onCreate(async (_user) => {
//     const { uid, email, displayName, phoneNumber, photoURL } = _user;

//     console.log(`***********************`);
//     logger.info(_user.toJSON());

//     try {
//         const user = new User();
//         user.setId(uid);
//         user.setEmail(email);
//         user.setName(displayName);
//         user.setStatus(Status.TYPING);
//         user.setPhoneNumber(phoneNumber);
//         user.setAvatarUrl(photoURL);
//         user.setRoomsList([]);
//         user.setCreatedAt((new Date()).toISOString());
//         user.setOpen(true)

//         logger.debug(user.toString());

//         await admin.firestore().collection(getConst(Const.USERS)).doc(uid).set(renameMapKeys(new Map(Object.entries(user.toObject())), mapKeys));
//         logger.info(`New user ${email} created with ID ${uid}`);
//     } catch (error) {
//         console.error("Error creating user:", error);
//     }
// });
