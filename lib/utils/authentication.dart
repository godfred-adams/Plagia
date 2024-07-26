// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:plagia_oc/screens/welcome_screen.dart';
import 'package:plagia_oc/utils/usermodel.dart';
import '../widgets/snacbar.dart';

// StateNotifier to handle user authentication
class Authentication extends StateNotifier<UserModel?> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Ref ref;

  Authentication(this.ref) : super(null) {
    _loadUserFromPreferences(); // Load user data on initialization
  }

  // Save user data to SharedPreferences
  Future<void> _saveUserToPreferences(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user', user.toJson());
    state = user;
  }

  // Load user data from SharedPreferences
  Future<void> _loadUserFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    if (userJson != null) {
      state = UserModel.fromJson(userJson);
    }
  }

  // Clear user data from SharedPreferences
  Future<void> _clearUserFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
  }

  // Get user details from Firestore
  Future<UserModel> getUserDetails() async {
    DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(_auth.currentUser!.uid).get();
    return UserModel.fromMap(snapshot.data() as Map<String, dynamic>);
  }

  // Sign up method
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (credential.user != null) {
        UserModel user =
            UserModel(email: email, uid: credential.user!.uid, name: name);
        await _firestore
            .collection('users')
            .doc(credential.user!.uid)
            .set(user.toMap());
        await credential.user!.sendEmailVerification();
        showSnackBar(
            context: context,
            txt:
                "Email verification sent to your email account, check and verify");
        state = user;
      }
    } catch (err) {
      showSnackBar(context: context, txt: err.toString());
    }
  }

  // Login method
  Future<void> loginUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      showSnackBar(context: context, txt: 'Please enter your credentials');
      return;
    }
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      await credential.user!.reload();

      if (!credential.user!.emailVerified) {
        showSnackBar(context: context, txt: "Please verify your email account");
        return;
      }

      if (credential.user != null && credential.user!.emailVerified) {
        UserModel user = await getUserDetails();
        state = user;
        _saveUserToPreferences(user);

        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setBool("isAuthenticated", true);
        Navigator.pushNamedAndRemoveUntil(
            context, WelcomeScreen.routeName, (T) => false);
      } else {
        showSnackBar(context: context, txt: "Please verify your email");
      }
    } on FirebaseAuthException catch (err) {
      print(err);
      showSnackBar(context: context, txt: err.toString());
    } catch (err) {
      showSnackBar(context: context, txt: err.toString());
    }
  }

  // Sign out method
  Future<void> signOut() async {
    await _auth.signOut();
    state = null;
    _clearUserFromPreferences(); // Clear user from preferences
  }
}
