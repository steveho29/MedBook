import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'view/screens/main_page.dart';

void main() {
  runApp(GetMaterialApp(
    home: MainPage(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Color.fromRGBO(55, 174, 167, 1),
    ),
  ));
}
