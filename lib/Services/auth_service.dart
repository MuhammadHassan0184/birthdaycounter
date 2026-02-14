// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // -----------------------------
  // SIGNUP
  // -----------------------------
  Future<User?> signUp(String email, String password, String fullName) async {
    try {
      // Firebase Auth create user
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = result.user;

      if (user != null) {
        // Save user info in Firestore
        await _firestore.collection("users").doc(user.uid).set({
          "uid": user.uid,
          "email": email,
          "fullName": fullName,
          "createdAt": DateTime.now(),
        });
      }

      return user;
    } on FirebaseAuthException {
      rethrow; // 🔥 Keep original Firebase error
    } catch (e) {
      throw Exception("Signup failed. Please try again.");
    }
  }

  // -----------------------------
  // LOGIN
  // -----------------------------
  Future<UserCredential> login(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // -----------------------------
  // LOGOUT
  // -----------------------------
  Future<void> logout() async {
    await _auth.signOut();
  }

  // -----------------------------
  // GET CURRENT USER
  // -----------------------------
  User? get currentUser => _auth.currentUser;

  // -----------------------------
  // GET USER DATA FROM FIRESTORE
  // -----------------------------
  Future<Map<String, dynamic>?> getUserData(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection("users")
          .doc(uid)
          .get();

      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception("Error fetching user data: $e");
    }
  }

  // -----------------------------
  // GOOGLE SIGN-IN
  // -----------------------------
  Future<User?> signInWithGoogle() async {
    try {
      // Create a GoogleSignIn instance
      final GoogleSignIn googleSignIn = GoogleSignIn();

      // Trigger the sign-in flow
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) return null; // User canceled

      // Obtain the auth details
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google [UserCredential]
      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );
      final User? user = userCredential.user;

      // Save user info to Firestore if new
      if (user != null) {
        final doc = await _firestore.collection("users").doc(user.uid).get();
        if (!doc.exists) {
          await _firestore.collection("users").doc(user.uid).set({
            "uid": user.uid,
            "email": user.email,
            "fullName": user.displayName ?? "",
            "createdAt": DateTime.now(),
          });
        }
      }

      return user;
    } catch (e) {
      print("Google Sign-In Error: $e");
      return null;
    }
  }
}

class GoogleAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    try {
      debugPrint("🔹 Starting Google Sign-In...");

      // Trigger Google Sign-In
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        debugPrint("❌ Google Sign-In canceled by user.");
        return null; // User canceled
      }
      debugPrint("🔹 Google account selected: ${googleUser.email}");

      // Obtain auth details
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      debugPrint(
        "🔹 Google Auth token: ${googleAuth.accessToken?.substring(0, 5)}...",
      );

      // Create Firebase credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase
      UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );
      debugPrint(
        "✅ Firebase Sign-In successful: ${userCredential.user?.email}",
      );

      return userCredential.user;
    } catch (e) {
      debugPrint("❌ Error during Google Sign-In: $e");
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      debugPrint("🔹 Signing out...");
      await _googleSignIn.signOut();
      await _auth.signOut();
      debugPrint("✅ Sign-out successful");
    } catch (e) {
      debugPrint("❌ Error signing out: $e");
    }
  }
}
