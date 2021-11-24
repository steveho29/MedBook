import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medbook/controller/firestore.dart';
import 'package:medbook/models/doctor.dart';
import 'package:medbook/view/screens/home_page.dart';
import 'package:medbook/view/screens/login_page.dart';
import 'package:medbook/view/screens/main_page.dart';
import 'package:medbook/view/screens/register_page.dart';

class AuthController extends GetxController {
  // GoogleSignInAccount? _user;
  // GoogleSignInAccount get user => _user!;
  Rx<User?> _user = Rx(null);
  FirebaseAuth auth = FirebaseAuth.instance;
  FirestoreController firestoreController = Get.put(FirestoreController());
  Rx<Doctor?> doctor = Rx(null);

  bool get isDoctor => doctor.value != null;
  bool get isSignIn => _user.value != null;
  User get user => _user.value!;
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, userChanges);
    checkUserIsDoctor();
  }

  void checkUserIsDoctor() async {
    doctor.value = await firestoreController.isDoctor();
  }

  userChanges(User? user) {
    print("User changes");
  }

  void googleLogin() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      if (googleSignIn.currentUser != null) {
        return;
      }
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await auth.signInWithCredential(credential);
      Get.to(() => MainPage());
      checkUserIsDoctor();
    } catch (error) {
      Get.snackbar(
        "Sign in",
        "Incomplete",
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "Account not correct",
          style: TextStyle(color: Colors.white),
        ),
        messageText: Text(error.toString()),
      );
    }
  }

  void signOut() async {
    GoogleSignIn().signOut();
    await auth.signOut();
    this.doctor.value = null;
    // print(user);
  }

  void registerWithEmailAndPassword(String email, String password) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Get.to(() => LoginPage());
        FirestoreController fireStoreController = Get.find();
        fireStoreController.addUser(user.uid, {'appoinments': []});
      });
    } catch (error) {
      String msg = error.toString();
      Get.snackbar(
        "Sign up Failed",
        "Incomplete",
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
        isDismissible: false,
        // titleText: Text(
        //   // "",
        //   "Account Redgister Failed!",
        //   style: TextStyle(color: Colors.white),
        // ),
        messageText: Text(msg.substring(msg.indexOf(']') + 2)),
      );
    }
  }

  void loginWithEmailAndPassword(String email, String password) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => Get.to(() => MainPage()));
      checkUserIsDoctor();
    } catch (error) {
      Get.snackbar(
        "Sign in",
        "Incomplete",
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "Account not correct",
          style: TextStyle(color: Colors.white),
        ),
        messageText: Text(error.toString()),
      );
    }
  }
}
