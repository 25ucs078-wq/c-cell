const { admin, db } = require('../config/firebaseAdmin');

/**
 * Saves a notification document permanently in Cloud Firestore
 * @param {Object} param0 
 * @param {string} param0.title
 * @param {string} param0.message
 * @param {string} param0.senderEmail
 * @returns {Promise<string>} Document ID
 */
async function saveNotification({ title, message, senderEmail }) {
  try {
    const docRef = await db.collection('notifications').add({
      title,
      message,
      senderEmail,
      timestamp: admin.firestore.FieldValue.serverTimestamp(),
    });

    return docRef.id;
  } catch (error) {
    console.error('Error writing notification to Firestore:', error);
    const dbError = new Error('Failed to store notification in Firestore database.');
    dbError.statusCode = 500;
    throw dbError;
  }
}

module.exports = {
  saveNotification,
};
