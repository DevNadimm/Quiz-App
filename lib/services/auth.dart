import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quiz_app/services/database.dart';
import 'package:quiz_app/ui/screens/home_screen.dart';
import 'package:quiz_app/utils/toast.dart';

class AuthMethod {
  static Future<User?> getCurrentUser() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    return auth.currentUser;
  }

  static Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final GoogleSignIn googleSignIn = GoogleSignIn();

      // Start Google Sign-In
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      // Handle user canceling the sign-in
      if (googleSignInAccount == null) {
        print('Sign-in canceled by user.');
        return;
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      // Create a new credential
      final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      // Sign in the user with Firebase
      UserCredential result = await auth.signInWithCredential(authCredential);
      User? userDetails = result.user;

      if (userDetails != null) {
        // Store user info in Firestore
        Map<String, dynamic> userInfoMap = {
          'email': userDetails.email,
          'name': userDetails.displayName,
          'imgUrl': userDetails.photoURL,
          'id': userDetails.uid,
        };

        await DatabaseMethod.addUser(userInfoMap, userDetails.uid).then(
          (value) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          },
        );
      }
    } catch (e) {
      print("\n\n\nError during Google sign-in: $e\n\n\n");
      ToastMessage.errorToast('Sign-in failed. Please try again.');
    }
  }
}
