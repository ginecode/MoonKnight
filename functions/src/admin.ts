import { onCall } from "firebase-functions/v2/https";
import * as admin from "firebase-admin";

export const delAllUsers = onCall(async (request) => {
    let deleted = 0;
    admin.auth().listUsers()
        .then((listUsersResult) => {
            listUsersResult.users.forEach(async (userRecord) => {
                await admin.auth().deleteUser(userRecord.uid);
                await admin.firestore().collection("users").doc(userRecord.uid).delete();
                deleted++;
                // console.log('User', userRecord.uid, 'deleted');
            });
        })
        .catch((error) => {
            return "Error listing users: ${error}";
        });

    return { deleted: deleted };
});

export const addAdmin = onCall(async (request) => {
    if (request.auth.token.moderator !== true) {
        return {
            error: "Request not authorized. User is not moderator  to fulfill request.",
        };
    }
    const email = request.data.email;
    return grantModerateRole(email).then(() => {
        return {
            result: `Request fulfilled! ${email} is now a moderator.`,
        };
    });
});

async function grantModerateRole(email: string) {
    const user = await admin.auth().getUserByEmail(email);
    if (user.customClaims && (user.customClaims as any).moderator === true) {
        return;
    }
    return admin.auth().setCustomUserClaims(user.uid, {
        moderator: true,
        manager: true,
    });
}
