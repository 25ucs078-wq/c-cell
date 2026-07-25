importScripts('https://www.gstatic.com/firebasejs/10.7.0/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/10.7.0/firebase-messaging-compat.js');

// Initialize Firebase in Service Worker
// The SDK automatically uses configuration from firebase_options.dart on client initialization
firebase.initializeApp({
  messagingSenderId: "109876543210" // Placeholder or dynamic config
});

const messaging = firebase.messaging();

messaging.onBackgroundMessage((payload) => {
  console.log('[firebase-messaging-sw.js] Received background message ', payload);
  const notificationTitle = (payload.notification && payload.notification.title) || 'LNMIIT C-Cell';
  const notificationOptions = {
    body: (payload.notification && payload.notification.body) || '',
    icon: '/ccell_logo_c.png'
  };

  self.registration.showNotification(notificationTitle, notificationOptions);
});
