/**
 * Validates payload for notification sending API
 * @param {Object} body - Request body containing title, message, idToken
 * @returns {Object} - { isValid: boolean, error?: string, cleanData?: { title, message, idToken } }
 */
function validateNotificationPayload(body) {
  if (!body || typeof body !== 'object') {
    return { isValid: false, error: 'Request body must be a valid JSON object.' };
  }

  const { title, message, idToken } = body;

  // 1. Validate ID Token
  if (!idToken || typeof idToken !== 'string' || idToken.trim().length === 0) {
    return { isValid: false, error: 'Firebase ID token (idToken) is required.' };
  }

  // 2. Validate Title
  if (!title || typeof title !== 'string') {
    return { isValid: false, error: 'Title is required and must be a string.' };
  }
  const cleanTitle = title.trim();
  if (cleanTitle.length < 1 || cleanTitle.length > 100) {
    return { isValid: false, error: 'Title must be between 1 and 100 characters in length.' };
  }

  // 3. Validate Message
  if (!message || typeof message !== 'string') {
    return { isValid: false, error: 'Message is required and must be a string.' };
  }
  const cleanMessage = message.trim();
  if (cleanMessage.length < 1 || cleanMessage.length > 2000) {
    return { isValid: false, error: 'Message must be between 1 and 2000 characters in length.' };
  }

  return {
    isValid: true,
    cleanData: {
      title: cleanTitle,
      message: cleanMessage,
      idToken: idToken.trim(),
    },
  };
}

module.exports = {
  validateNotificationPayload,
};
