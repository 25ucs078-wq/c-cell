const admin = require('firebase-admin');

if (!admin.apps.length) {
  let credential;

  if (process.env.FIREBASE_SERVICE_ACCOUNT) {
    try {
      const serviceAccount = JSON.parse(process.env.FIREBASE_SERVICE_ACCOUNT);
      credential = admin.credential.cert(serviceAccount);
    } catch (error) {
      console.error('Error parsing FIREBASE_SERVICE_ACCOUNT environment variable:', error.message);
      throw new Error('Invalid FIREBASE_SERVICE_ACCOUNT environment variable formatting.');
    }
  } else if (process.env.FIREBASE_PROJECT_ID && process.env.FIREBASE_CLIENT_EMAIL && process.env.FIREBASE_PRIVATE_KEY) {
    credential = admin.credential.cert({
      projectId: process.env.FIREBASE_PROJECT_ID,
      clientEmail: process.env.FIREBASE_CLIENT_EMAIL,
      privateKey: process.env.FIREBASE_PRIVATE_KEY.replace(/\\n/g, '\n'),
    });
  } else {
    // Fallback to default application credentials if running in Firebase/GCP environment
    credential = admin.credential.applicationDefault();
  }

  admin.initializeApp({
    credential,
  });
}

const db = admin.firestore();
const auth = admin.auth();
const messaging = admin.messaging();

module.exports = {
  admin,
  db,
  auth,
  messaging,
};
