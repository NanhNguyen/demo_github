import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
  static Future<void> signIn(
      String email, String password, BuildContext context) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Invalid User or Password. Please Try Again $e')),
      );
    }
  }

  static Future<void> signOut(BuildContext context) async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unknown Error. Please Try Again $e')),
      );
    }
  }

  static Future<void> createAccount(
    BuildContext context,
    String email,
    String password,
    String confirmPass,
  ) async {
    try {
      if (password != confirmPass) {
        throw Exception("Password and Confirm Password must be similar!");
      }
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unknown Error. Please Try Again $e')),
      );
    }
  }
}
