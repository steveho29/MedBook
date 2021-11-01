import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medbook/view/screens/account_page.dart';
import 'package:medbook/view/screens/home_page.dart';
import 'package:medbook/view/widgets/change_password_screen.dart';

class MainPageController extends GetxController {
  final _pages = <String, Widget>{
    "Home": HomePage(),
    "Account": AccountPage(),
    "ChangePassword": ChangePasswordScreen(),
  };
  var _currentPage = "Home".obs;
  var _prevPage = "Home";
  Widget? get currentPage => _pages[_currentPage];

  void setPage(String page) {
    _prevPage = _currentPage.value;
    _currentPage.value = page;
  }

  void back() {
    var tmp = _currentPage.value;
    _currentPage.value = _prevPage;
    _prevPage = tmp;
  }
}