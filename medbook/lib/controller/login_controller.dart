import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GoogleSignInController extends GetxController {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  var isSignIn = false.obs;

  void googleLogin() async {
    if (googleSignIn.currentUser != null) {
      isSignIn.value = true;
      return;
    }
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    isSignIn.value = true;

    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void googleLogout() async {
    await googleSignIn.disconnect();
    await googleSignIn.signOut();
    isSignIn.value = false;
  }
}
