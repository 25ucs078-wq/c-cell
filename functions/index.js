const functions = require("firebase-functions");
const admin = require("firebase-admin");
const crypto = require("crypto");

admin.initializeApp();

const db = admin.firestore();

// Secure Cloud Function to verify desk passcode and write status changes on the backend
exports.verifyStageCode = functions.https.onCall(async (data, context) => {
  // 1. Validate inputs
  const { cycleId, tempId, stageId, passcode } = data;
  if (!cycleId || !tempId || !stageId || !passcode) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Missing required fields (cycleId, tempId, stageId, passcode)."
    );
  }

  try {
    // 2. Fetch the stage document to retrieve the SHA-256 code hash
    const stageRef = db
        .collection("admission_cycles")
        .doc(cycleId)
        .collection("stages")
        .doc(stageId);
        
    const stageSnap = await stageRef.get();
    if (!stageSnap.exists) {
      throw new functions.https.HttpsError("not-found", "Stage config not found.");
    }

    const stageData = stageSnap.data();
    const dbHash = stageData.bypassCodeHash;
    if (!dbHash) {
      throw new functions.https.HttpsError(
        "failed-precondition", 
        "Verification code is not configured on the server for this stage."
      );
    }

    // 3. Hash entered passcode using SHA-256
    const enteredHash = crypto.createHash("sha256").update(passcode.trim()).digest("hex");

    // 4. Validate passcode match
    if (enteredHash !== dbHash) {
      throw new functions.https.HttpsError("permission-denied", "Incorrect desk verification code.");
    }

    // 5. Execute progress update inside a Firestore Transaction
    const candidateRef = db
        .collection("admission_cycles")
        .doc(cycleId)
        .collection("candidates")
        .doc(tempId);
        
    const logRef = candidateRef.collection("stage_logs").doc(stageId);
    const stagesRef = db.collection("admission_cycles").doc(cycleId).collection("stages");

    await db.runTransaction(async (transaction) => {
      const candidateSnap = await transaction.get(candidateRef);
      if (!candidateSnap.exists) {
        throw new functions.https.HttpsError("not-found", "Candidate profile not found.");
      }

      // Fetch all enabled stages to determine if candidate is approved
      const enabledStagesSnap = await stagesRef.where("isEnabled", "==", true).get();
      const allEnabledStageIds = enabledStagesSnap.docs.map(doc => doc.id);

      const candidateData = candidateSnap.data();
      const currentStages = candidateData.completedStageIds || [];

      if (!currentStages.includes(stageId)) {
        currentStages.push(stageId);
      }

      const isAllCompleted = allEnabledStageIds.every(id => currentStages.includes(id));

      // Update candidate details
      transaction.update(candidateRef, {
        completedStageIds: currentStages,
        approved: isAllCompleted,
        updatedAt: admin.firestore.FieldValue.serverTimestamp()
      });

      // Write stage sign-off log
      transaction.set(logRef, {
        stageId: stageId,
        verifiedBy: context.auth ? context.auth.uid : "desk_officer",
        completedAt: admin.firestore.FieldValue.serverTimestamp()
      });
    });

    return { success: true };
  } catch (e) {
    if (e instanceof functions.https.HttpsError) {
      throw e;
    }
    throw new functions.https.HttpsError("internal", e.message || "Internal error occurred.");
  }
});
