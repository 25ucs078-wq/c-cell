const { validateNotificationPayload } = require('../utils/validators');
const { verifyAndAuthorizeAdmin } = require('../services/authService');
const { saveNotification } = require('../services/firestoreService');
const { sendCampusBuzzPushNotification } = require('../services/notificationService');

module.exports = async (req, res) => {
  // CORS Headers
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'POST, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');

  if (req.method === 'OPTIONS') {
    return res.status(200).end();
  }

  if (req.method !== 'POST') {
    return res.status(405).json({
      success: false,
      error: 'Method Not Allowed. Use POST.',
    });
  }

  try {
    // 1. Validate Input Payload
    const validation = validateNotificationPayload(req.body);
    if (!validation.isValid) {
      return res.status(400).json({
        success: false,
        error: validation.error,
      });
    }

    const { title, message, idToken } = validation.cleanData;

    // 2. Verify Firebase ID Token & Check Admin Whitelist
    let authenticatedEmail;
    try {
      const authResult = await verifyAndAuthorizeAdmin(idToken);
      authenticatedEmail = authResult.authenticatedEmail;
    } catch (authErr) {
      const statusCode = authErr.statusCode || 401;
      return res.status(statusCode).json({
        success: false,
        error: authErr.message,
      });
    }

    // 3. Save Notification to Cloud Firestore
    let notificationId;
    try {
      notificationId = await saveNotification({
        title,
        message,
        senderEmail: authenticatedEmail,
      });
    } catch (dbErr) {
      console.error('Firestore save failed:', dbErr);
      return res.status(500).json({
        success: false,
        error: 'Failed to persist notification in Firestore database.',
      });
    }

    // 4. Send Push Notification via FCM Topic 'campus_buzz'
    try {
      await sendCampusBuzzPushNotification({ title, message });
      return res.status(200).json({
        success: true,
        firestoreSaved: true,
        pushSent: true,
        notificationId,
      });
    } catch (fcmErr) {
      console.warn('FCM delivery failed after Firestore write:', fcmErr.message);
      return res.status(200).json({
        success: true,
        firestoreSaved: true,
        pushSent: false,
        warning: 'Notification stored successfully but push delivery failed.',
        notificationId,
      });
    }
  } catch (error) {
    console.error('Unhandled server error in send-notification endpoint:', error);
    return res.status(500).json({
      success: false,
      error: 'An unexpected internal server error occurred.',
    });
  }
};
