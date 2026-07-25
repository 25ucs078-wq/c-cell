const { messaging } = require('../config/firebaseAdmin');

/**
 * Dispatches an FCM push notification to topic 'campus_buzz'
 * Branded strictly as "LNMIIT C-Cell"
 * @param {Object} param0 
 * @param {string} param0.title
 * @param {string} param0.message
 * @returns {Promise<string>} FCM Message ID
 */
async function sendCampusBuzzPushNotification({ title, message }) {
  const fcmPayload = {
    topic: 'campus_buzz',
    notification: {
      title: 'LNMIIT C-Cell',
      body: title ? `${title}: ${message}` : message,
    },
    data: {
      notificationTitle: title,
      notificationMessage: message,
      sender: 'LNMIIT C-Cell',
      channelId: 'campus_buzz_channel',
    },
    android: {
      priority: 'high',
      notification: {
        channelId: 'campus_buzz_channel',
        sound: 'default',
      },
    },
    apns: {
      payload: {
        aps: {
          sound: 'default',
        },
      },
    },
  };

  const response = await messaging.send(fcmPayload);
  return response;
}

module.exports = {
  sendCampusBuzzPushNotification,
};
