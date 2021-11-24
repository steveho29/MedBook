import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medbook/controller/auth_controller.dart';
import 'package:medbook/view/screens/account_page.dart';
import 'package:medbook/view/screens/activity.dart';
import 'package:medbook/view/screens/booking_page.dart';
import 'package:medbook/view/screens/doctor_activity_page.dart';
import 'package:medbook/view/screens/home_page.dart';
import 'package:medbook/view/screens/login_page.dart';
import 'package:medbook/view/screens/register_page.dart';
import 'package:medbook/view/widgets/change_password_screen.dart';

class MainPageController extends GetxController {
  AuthController authController = Get.find();
  final _pages = <String, Widget>{
    "Home": HomePage(),
    "Account": AccountPage(),
    "ChangePassword": ChangePasswordScreen(),
    "Login": LoginPage(),
    "Booking": BookingPage(),
    "Activity": ActivityPage(),
  };

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  var _currentPage = "Home".obs;
  var _prevPage = "Home";
  String get currentPage => _currentPage.value;
  Widget? get currentPageWidget => _pages[_currentPage];

  void setPage(String page) {
    if ((page == "Booking" || page == "Activity") && !authController.isSignIn) {
      Get.defaultDialog(
        title: "Sign in to use this feature",
        titleStyle: TextStyle(fontWeight: FontWeight.bold),
        titlePadding: EdgeInsets.all(20),
        content: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  minimumSize: Size(100, 40),
                ),
                onPressed: () => Get.to(() => RegisterPage()),
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                      color: Colors.grey.shade700, fontWeight: FontWeight.bold),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  minimumSize: Size(100, 40),
                ),
                onPressed: () => Get.to(() => LoginPage()),
                child: Text(
                  "Sign In",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      );
    }
    //   Get.snackbar(
    //     "Sign in",
    //     "Not sign in",
    //     backgroundColor: Colors.green,
    //     snackPosition: SnackPosition.TOP,
    //     titleText: Text(
    //       "You are not sign yet",
    //       style: TextStyle(color: Colors.white),
    //     ),
    //     messageText: GestureDetector(
    //       onTap: () => Get.to(() => LoginPage()),
    //       child: Text(
    //         "Sign in here",
    //         style: TextStyle(decoration: TextDecoration.underline),
    //       ),
    //     ),
    //   );
    // }
    else {
      if (page == "Activity") if (authController.isDoctor)
        _pages["Activity"] = DoctorActivityPage();
      else
        _pages["Activity"] = ActivityPage();

      _prevPage = _currentPage.value;
      _currentPage.value = page;
    }
  }

  void back() {
    var tmp = _currentPage.value;
    _currentPage.value = _prevPage;
    _prevPage = tmp;
  }
}
