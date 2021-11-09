import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:medbook/controller/auth_controller.dart';
import 'package:medbook/view/screens/login_page.dart';
import 'package:medbook/view/widgets/BigButtonWidget.dart';
import 'package:medbook/view/widgets/email_field.dart';
import 'package:medbook/view/widgets/password_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final emailController = TextEditingController();
  final AuthController authController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).primaryColor,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Text(
                "MedBook.",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  // color: Colors.white,
                ),
              ),
              Text(
                "Let's be our member",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                  // color: Colors.white,
                ),
              ),
              SizedBox(height: 30),
              EmailFieldWidget(controller: emailController),
              SizedBox(height: 10),
              PasswordFieldWidget(controller: passwordController),
              SizedBox(height: 10),
              PasswordFieldWidget(controller: confirmPasswordController),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    passwordController.text != confirmPasswordController.text
                        ? "Confirm password not correct"
                        : emailController.text.isEmail
                            ? ""
                            : "Email invalid",
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
              SizedBox(height: 30),
              BigButtonWidget(
                onClicked: () => emailController.text != "" &&
                        confirmPasswordController.text ==
                            passwordController.text
                    ? authController.registerWithEmailAndPassword(
                        emailController.text, passwordController.text)
                    : {},
                text: 'Sign Up',
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "You have an account?",
                  ),
                  GestureDetector(
                    onTap: () => Get.to(() => LoginPage()),
                    child: Text(
                      " Login",
                      style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
