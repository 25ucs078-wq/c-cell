const { auth } = require('../config/firebaseAdmin');

// Default fallback list of authorized admin emails if ADMIN_EMAILS env variable is not set
const DEFAULT_ADMIN_WHITELIST = [
  'c-cell@lnmiit.ac.in',
  '25ucs078@lnmiit.ac.in',
  'admin@lnmiit.ac.in',
];

/**
 * Parses configured admin whitelist emails from process.env.ADMIN_EMAILS
 * @returns {Set<string>}
 */
function getAuthorizedAdminEmails() {
  if (process.env.ADMIN_EMAILS) {
    const emails = process.env.ADMIN_EMAILS.split(',')
      .map((e) => e.trim().toLowerCase())
      .filter((e) => e.length > 0);
    return new Set(emails);
  }
  return new Set(DEFAULT_ADMIN_WHITELIST.map((e) => e.toLowerCase()));
}

/**
 * Verifies Firebase ID token and checks if user is an authorized admin
 * @param {string} idToken 
 * @returns {Promise<{ authenticatedEmail: string }>}
 */
async function verifyAndAuthorizeAdmin(idToken) {
  let decodedToken;
  try {
    decodedToken = await auth.verifyIdToken(idToken);
  } catch (error) {
    console.error('[AUTH_ERROR] Invalid or expired Firebase ID token:', error.message);
    const authError = new Error('Invalid or expired Firebase ID token.');
    authError.statusCode = 401;
    throw authError;
  }

  const email = decodedToken.email ? decodedToken.email.trim().toLowerCase() : '';
  if (!email) {
    console.error('[AUTH_ERROR] Firebase ID token contains no email claim.');
    const noEmailError = new Error('Firebase ID token contains no email claim.');
    noEmailError.statusCode = 401;
    throw noEmailError;
  }

  const authorizedEmails = getAuthorizedAdminEmails();
  if (!authorizedEmails.has(email)) {
    console.error(`[AUTH_UNAUTHORIZED] User [${email}] attempted to send notification but is not in admin whitelist.`);
    const forbiddenError = new Error(`User [${email}] is not authorized to send Campus Buzz notifications.`);
    forbiddenError.statusCode = 403;
    throw forbiddenError;
  }

  return { authenticatedEmail: email };
}

module.exports = {
  verifyAndAuthorizeAdmin,
};
