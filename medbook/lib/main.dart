import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'view/screens/main_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GetMaterialApp(
    home: MainPage(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Color.fromRGBO(55, 174, 167, 1),
    ),
  ));
}
