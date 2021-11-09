import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:medbook/controller/auth_controller.dart';
import 'package:medbook/view/screens/register_page.dart';
import 'package:medbook/view/widgets/BigButtonWidget.dart';
import 'package:medbook/view/widgets/email_field.dart';
import 'package:medbook/view/widgets/password_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final passwordController = TextEditingController();
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
                "Let's sign you in",
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

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forget password?",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 15,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),

              BigButtonWidget(
                onClicked: () => authController.loginWithEmailAndPassword(
                    emailController.text, passwordController.text),
                text: 'Login',
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Or connecting with",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
              SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: CircleBorder(),
                    ),
                    onPressed: () => {},
                    child: Padding(
                      padding: const EdgeInsets.all(13),
                      child: FaIcon(
                        FontAwesomeIcons.facebookF,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: CircleBorder(),
                    ),
                    onPressed: () => authController.googleLogin(),
                    child: Padding(
                      padding: const EdgeInsets.all(13),
                      child: FaIcon(
                        FontAwesomeIcons.google,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have account?",
                  ),
                  GestureDetector(
                    onTap: () => Get.to(() => RegisterPage()),
                    child: Text(
                      " Register",
                      style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),

              // IconButton(
              //     onPressed: () => authController.signOut(),
              //     icon: Icon(Icons.logout))
              // Obx(() => Text(authController.isSignIn
              //     ? authController.user.displayName!
              //     : 'NOT LOGIN YET')),
            ],
          ),
        ),
      ),
    );
  }
}
