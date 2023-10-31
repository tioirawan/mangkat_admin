/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const { onCall } = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");
const admin = require("firebase-admin");

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

admin.initializeApp();

// Create a new auth user using email and password
exports.createUser = onCall(async (request) => {
  const { email, password } = request.data;

  try {
    const user = await admin.auth().createUser({
      email,
      password,
    });

    return user;
  } catch (error) {
    return error;
  }
});

// Delete an auth user
exports.deleteUser = onCall(async (request) => {
  const { uid } = request.data;

  try {
    const user = await admin.auth().deleteUser(uid);

    return user;
  } catch (error) {
    return error;
  }
});
