console.log('Carregando scripts do Firebase...');
importScripts('https://www.gstatic.com/firebasejs/9.21.0/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/9.21.0/firebase-messaging.js');


// Configuração do Firebase
firebase.initializeApp({
  apiKey: "AIzaSyBPIcJ9xINhLmm65GBBODS5KyqGfedoKyI",
  authDomain: "rate-io.firebaseapp.com",
  projectId: "rate-io",
  storageBucket: "rate-io.firebasestorage.app",
  messagingSenderId: "314552752091",
  appId: "1:314552752091:web:29ecb32de834ad7423b9fe",
});

const messaging = firebase.messaging();

// Manipulação de mensagens em segundo plano
messaging.onBackgroundMessage((message) => {
  console.log('[firebase-messaging-sw.js] Mensagem em segundo plano:', message);
});
