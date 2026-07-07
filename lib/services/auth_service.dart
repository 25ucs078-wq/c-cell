import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/user_model.dart';

class UnauthorizedDomainException implements Exception {
  final String message;
  UnauthorizedDomainException(this.message);

  @override
  String toString() => message;
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Stream of auth state changes to listen to current session
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Google Sign-In with Domain Restriction
  Future<User?> signInWithGoogle() async {
    try {
      // 1. Trigger the Google Sign-In flow
      final googleUser = await _googleSignIn.authenticate();

      // 2. Enforce @lnmiit.ac.in domain restriction
      final String email = googleUser.email.trim().toLowerCase();
      if (!email.endsWith('@lnmiit.ac.in')) {
        // Disconnect account immediately to clean up cached credentials
        await _googleSignIn.signOut();
        throw UnauthorizedDomainException(
          'Access Denied: Only @lnmiit.ac.in email accounts are authorized.',
        );
      }

      // 3. Obtain authorization tokens
      final googleAuth = googleUser.authentication;

      // 4. Create credential using the ID Token for Firebase
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      // 5. Sign in to Firebase
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? firebaseUser = userCredential.user;

      if (firebaseUser == null) {
        throw FirebaseAuthException(
          code: 'null-user',
          message: 'Firebase User creation failed.',
        );
      }

      // 6. Explicitly verify Google account email is verified
      if (!firebaseUser.emailVerified) {
        await signOut();
        throw FirebaseAuthException(
          code: 'unverified-email',
          message: 'Access Denied: Google email address is not verified.',
        );
      }

      // 7. Update user profile in Firestore
      await _syncUserProfile(firebaseUser);

      return firebaseUser;
    } on UnauthorizedDomainException {
      rethrow;
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        debugPrint('FirebaseAuthException during Google Sign-In: ${e.code}');
      }
      rethrow;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Unexpected error during Google Sign-In.');
      }
      rethrow;
    }
  }

  // Sync user profile with Firestore (create if new, update lastLogin if existing)
  Future<void> _syncUserProfile(User user) async {
    final DocumentReference userRef = _db.collection('users').doc(user.uid);
    
    try {
      // Run in transaction to prevent race conditions during concurrent logins
      await _db.runTransaction((transaction) async {
        final DocumentSnapshot snapshot = await transaction.get(userRef);

        final userModel = UserModel(
          uid: user.uid,
          name: user.displayName ?? 'C-CELL Student',
          email: user.email!,
          photoUrl: user.photoURL,
        );

        if (!snapshot.exists) {
          // Document does not exist: create it with first login timestamp (createdAt)
          transaction.set(userRef, userModel.toCreateMap());
          if (kDebugMode) {
            debugPrint('Successfully registered new user in Firestore: ${user.uid}');
          }
        } else {
          // Document exists: update lastLogin and updatedAt
          transaction.update(userRef, userModel.toUpdateMap());
          if (kDebugMode) {
            debugPrint('Successfully updated lastLogin for user: ${user.uid}');
          }
        }
      });
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error syncing user profile in Firestore.');
      }
      // Re-throw so UI can notify the user if profile sync fails
      rethrow;
    }
  }

  // Sign out from both Firebase and Google Sign-In
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      debugPrint('Successfully signed out from Google and Firebase.');
    } catch (e) {
      debugPrint('Error during sign out: $e');
      rethrow;
    }
  }
}
