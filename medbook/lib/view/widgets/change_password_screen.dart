import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:medbook/controller/main_controller.dart';

import 'password_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  MainPageController mCtrler = Get.find();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => mCtrler.back(),
          icon: FaIcon(
            FontAwesomeIcons.arrowLeft,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Change Password",
          style: TextStyle(color: Colors.black),
        ),
        shape: Border(),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              PasswordFieldWidget(
                controller: currentPasswordController,
                text: "Current Password",
              ),
              SizedBox(
                height: 10,
              ),
              PasswordFieldWidget(
                controller: newPasswordController,
                text: "New Password",
              ),
              SizedBox(
                height: 10,
              ),
              PasswordFieldWidget(
                controller: confirmPasswordController,
                text: "Confirm Password",
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                  shape: StadiumBorder(),
                ),
                child: FittedBox(
                  child: Text(
                    "SAVE PASSWORD",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                onPressed: () => {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
