import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:doctor/widgets/snaackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'usermodel.dart';
import 'package:plagia_oc/widgets/snacbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestorage = FirebaseFirestore.instance;
  static bool isLoading = false;
  Stream<User?> get authChanges => _auth.authStateChanges();
  User get user => _auth.currentUser!;
  Future<void> _saveUserToPreferences(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user', user.toJson());
    // state = user;
  }

  Future<UserModel> getUserDetails() async {
    DocumentSnapshot snapshot = await _firestorage
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .get();

    return UserModel.fromMap(snapshot.data() as Map<String, dynamic>);
  }

  // Sign up method
  Future<String> signUp({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    String result = 'Some error occured';

    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (credential.user != null) {
        UserModel user = UserModel(
          email: email,
          // badgeNumber: badgeNumber,
          uid: credential.user!.uid,
          name: name,
        );

        await _firestorage.collection('users').doc(credential.user!.uid).set(
              user.toMap(),
            );

        await credential.user!.sendEmailVerification();
        showSnackBar(
            context: context,
            txt:
                "Email verification sent to your email account check and verify");
      }
      result = 'Successful';
      debugPrint(result);
    } catch (err) {
      result = err.toString();
      final String error = getErrorMessage(err.toString());
      showSnackBar(context: context, txt: error);
      debugPrint(err.toString());
    }

    return result;
  }

  Future<bool> loginUser(
      String password, String email, BuildContext context) async {
    bool result = false;
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      credential.user!.reload();

      // debugPrint(credential.user as String?);
      if (!credential.user!.emailVerified) {
        showSnackBar(context: context, txt: "Please verify your email account");
        return false;
      }

      if (credential.user != null && credential.user!.emailVerified) {
        UserModel user = await getUserDetails();
        // state = user;
        _saveUserToPreferences(user);

        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setBool("isAuthenticated", true);
        result = true;
      } else {
        showSnackBar(context: context, txt: "Please verify your email");
        result = false;
      }
    } on FirebaseAuthException {
      throw Exception;
    } catch (err) {
      result = false;

      debugPrint(" err.toString() ${err.toString()}");
    }

    return result;
  }

  signOut() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool("isAuthenticated", false);
    await pref.remove("user");
    _auth.signOut();
  }
}
