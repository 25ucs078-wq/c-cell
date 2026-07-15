const admin = require('firebase-admin');

// 1. Production Safeguard Check
const emulatorHost = process.env.FIRESTORE_EMULATOR_HOST;
const allowProduction = process.env.ALLOW_PRODUCTION_SEED === 'true';

if (!emulatorHost && !allowProduction) {
  console.error(
    '\n[ERROR] Production environment detected. Refusing to seed Firestore.\n' +
    'Explicit production seeding must be enabled by setting ALLOW_PRODUCTION_SEED=true.\n'
  );
  process.exit(1);
}

if (emulatorHost) {
  console.log(`Connecting to Firestore Emulator at: ${emulatorHost}`);
} else {
  console.log('WARNING: Seeding PRODUCTION database as ALLOW_PRODUCTION_SEED=true is set.');
}

admin.initializeApp({
  projectId: emulatorHost ? 'c-cell-backend' : undefined
});

const db = admin.firestore();

async function seed() {
  console.log('1. Seeding app configuration...');
  await db.collection('configs').doc('app_config').set({
    activeAdmissionCycle: '2026'
  });

  const stages = [
    {
      id: 'hostel_allotment',
      title: 'Hostel Allotment',
      location: 'CP-2',
      stageOrder: 1,
      assignedRole: 'desk_hostel',
      isEnabled: true,
      bypassCodeHash: '59a46b111fe459b58a170f4f0acdbd945c9fb1db5d71d6f1c38f3765c32a6225' // Code: 4918
    },
    {
      id: 'jee_verification',
      title: 'JEE Verification',
      location: 'LH 1 / LH 2',
      stageOrder: 2,
      assignedRole: 'desk_jee',
      isEnabled: true,
      bypassCodeHash: 'ed12f17149c7e7b586c76a949fed6e85c2f1bf57e820427eac00c1eeb3926f3d' // Code: 7204
    },
    {
      id: 'documents_verification',
      title: 'Document Verification',
      location: 'LH 1 / LH 2',
      stageOrder: 3,
      assignedRole: 'desk_verification',
      isEnabled: true,
      bypassCodeHash: '42e544025f96e6ee0a064873a7f2d431ca555ed0ab1f2990377a5dcac1a7dd16' // Code: 8139
    },
    {
      id: 'credentials_allocation',
      title: 'Email & Network Credentials',
      location: 'LH 3',
      stageOrder: 4,
      assignedRole: 'desk_credentials',
      isEnabled: true,
      bypassCodeHash: '34af953ef5913ef6d17a9dfd145aeb063762b08ef2aa1a96cf4405ff55437192' // Code: 6275
    },
    {
      id: 'id_card_verification',
      title: 'ID Card and Data Verification',
      location: 'CP-2',
      stageOrder: 5,
      assignedRole: 'desk_student_affairs',
      isEnabled: true,
      bypassCodeHash: '9532f197bbc85d99b5be01eb362f1314104016f8bf1283174864836d9433c084' // Code: 3051
    },
    {
      id: 'biometric_registration',
      title: 'Biometric Registration',
      location: 'LH 9',
      stageOrder: 6,
      assignedRole: 'desk_security',
      isEnabled: true,
      bypassCodeHash: '395e21aaf42e2d2e9a09addc7495693c993991c9541e3dc45a117c4349437690' // Code: 9846
    },
    {
      id: 'antiragging_registration',
      title: 'Anti-Ragging Registration',
      location: 'CP Lab 2',
      stageOrder: 7,
      assignedRole: 'desk_antiragging',
      isEnabled: true,
      bypassCodeHash: 'a580f210e5e622d2df90102c9ec7e074c81a323f28c2ce0256aab2edbde69b54' // Code: 5193
    },
    {
      id: 'id_card_printing',
      title: 'ID Card Printing and Handover',
      location: 'CP Lab 1',
      stageOrder: 8,
      assignedRole: 'desk_printing',
      isEnabled: true,
      bypassCodeHash: '33d9f4526b23543c77260989ff4439aca18cff76c61511b6987816f1e9fc6c32' // Code: 8420
    }
  ];

  console.log('2. Seeding stages...');
  for (const s of stages) {
    await db.collection('admission_cycles').doc('2026').collection('stages').doc(s.id).set(s);
  }

  console.log('3. Seeding candidate (LNMSV5KB)...');
  await db.collection('admission_cycles').doc('2026').collection('candidates').doc('LNMSV5KB').set({
    tempId: 'LNMSV5KB',
    name: 'Rahul Sharma',
    jeeAppNo: '2403102495',
    dob: '2006-08-15',
    candidateUid: '',
    completedStageIds: [],
    approved: false,
    updatedAt: admin.firestore.FieldValue.serverTimestamp()
  });

  // Seed private verification subdocument
  await db.collection('admission_cycles').doc('2026').collection('candidates').doc('LNMSV5KB').collection('private').doc('verification').set({
    jeeAppNo: '2403102495',
    dob: '2006-08-15'
  });

  console.log('Database seeded successfully!');
}

seed().catch(console.error);
