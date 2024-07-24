import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Dialog(
        backgroundColor: Colors.transparent,
        child: Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    },
  );
}

class Authentication {
  static User? user;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: const TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }

  static Future<User?> signInWithGoogle(BuildContext context) async {
    showLoadingDialog(context);
    FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
        await _checkAndCreateUserCollection(user!);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            Authentication.customSnackBar(
              content: 'The account already exists with a different credential',
            ),
          );
        } else if (e.code == 'invalid-credential') {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            Authentication.customSnackBar(
              content: 'Error occurred while accessing credentials. Try again.',
            ),
          );
        }
      } catch (e) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          Authentication.customSnackBar(
            content: 'Error occurred using Google Sign In. Try again.',
          ),
        );
      } finally {
        // ignore: use_build_context_synchronously
        Navigator.of(context, rootNavigator: true).pop();
      }
    }

    return user;
  }

  static Future<void> _checkAndCreateUserCollection(User user) async {
    final email = user.email!;
    final uid = user.uid;

    final userDoc = _firestore.collection(email).doc(uid);

    final docSnapshot = await userDoc.get();

    if (!docSnapshot.exists) {
      await userDoc.set({
        'customCategories': {},
      });
    }
  }

  static Future<void> signOut({required BuildContext context}) async {
    try {
      await FirebaseAuth.instance.signOut();
      user = null;
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        Authentication.customSnackBar(
          content: 'Error signing out. Try again.',
        ),
      );
    }
  }

  static bool isUserSignedIn() {
    return user != null;
  }
}

Future<void> signInWithGoogleAndShowLoading(BuildContext context) async {
  showLoadingDialog(context);
  try {
    Authentication.user = await Authentication.signInWithGoogle(context);
  } finally {
    // ignore: use_build_context_synchronously
    Navigator.of(context, rootNavigator: true).pop();
  }
}
