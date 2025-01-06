import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:task_manager_flutter/pages/home-page/page/homepage.dart';

class AuthState with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  bool mounted = false;
  @override
  void dispose() {
    super.dispose();
    mounted = true;
  }

  notify() {
    if (!mounted) {
      notifyListeners();
    }
  }

  Future<void> signInWithGoogle(
      BuildContext context, ValueNotifier<bool> isDarkMode) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
        );

        await _auth.signInWithCredential(credential);

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Homepage(isDarkMode: isDarkMode),
            ));
        notify();
      }
    } catch (error) {
      print("error $error");
    }
  }

  Future<void> _signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    notify();
  }
}
