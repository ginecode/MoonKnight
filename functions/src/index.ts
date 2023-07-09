import { onDocumentWritten } from "firebase-functions/v2/firestore";
import { onRequest } from "firebase-functions/v2/https";
import * as admin from "firebase-admin";
import * as functions from 'firebase-functions';
import { FieldValue } from "firebase-admin/firestore";
// import * as hello from "./example";
// import * as users from "./user";
// import * as power from "./admin";
import * as room from "./room";

admin.initializeApp({ projectId: "rivercroc" });

// export const sayHello = hello.sayHello;
// export const helloWorld = hello.helloWorld;
// export const allUsers = users.allUsers;
// export const delAllUsers = power.delAllUsers;

// export const testUserModel = users.testUserModel;

// Trigger
// export const onUserSignIn = users.onUserSignIn;
// export const newUser = users.newUser;
export const updateRoomTweetCount = room.updateRoomTweetCount;

export const count = onRequest(async (_request, response) => {
  try {
    await admin.firestore().collection("counter").doc("count").set({
      "count": FieldValue.increment(5),
    }, { merge: true });

    admin.firestore().collection("counter").doc("count").get().then(async (d) => {
      response.contentType("json").send({
        count: d.data().count,
      });
      return;
    }, (e) => {
      response.send(`Fire ${e}`);
      return;
    });
  } catch (e) {
    console.log(e);
    response.send('Count : Failure');
  }
});


export const docWrite = onDocumentWritten('counter/{count}', (change) => {
  let hello = {
    'subject': change.subject,
    'type': change.type,
    'after': change.data?.after.data(),
    'before': change.data?.before.data(),
    'params': change.params,
    'location': change.location,
    'id': change.id,
  }
  functions.logger.log('--------------------');
  console.log(hello)
  console.log('~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
  // change.data?.after.ref.update({ newField: 'newFieldValue' });
  return hello;
})

export const onCountUpdate = functions.firestore.document('counter/{count}').onUpdate(change => {
  const after = change.after.data();
  const payload = {
    data: {
      count: String(after.count)
    }
  }
  functions.logger.log('--------------------');
  functions.logger.log(payload);
  console.log('~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
  return admin.messaging().sendToTopic('Count Changed', payload)
});
