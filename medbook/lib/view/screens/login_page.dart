import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:medbook/controller/login_controller.dart';
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
  final googleLoginController = GoogleSignInController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
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
                  color: Colors.white,
                ),
              ),
              Text(
                "Let's sign you in",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 30),
              EmailFieldWidget(controller: emailController),
              SizedBox(height: 10),
              PasswordFieldWidget(controller: passwordController),
              SizedBox(height: 10),
              BigButtonWidget(
                onClicked: () => {},
                text: 'Login',
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () => {googleLoginController.googleLogin()},
                    // onPressed: () {
                    //   final provider = Provider.of<GoogleSignInController>(context, listen: false);
                    //   provider.
                    // },
                    icon: FaIcon(FontAwesomeIcons.google),
                    color: Colors.red.shade300,
                  ),
                  IconButton(
                      onPressed: () => googleLoginController.googleLogout(),
                      icon: Icon(Icons.logout))
                ],
              ),
              Obx(() => Text(googleLoginController.isSignIn.value
                  ? googleLoginController.user.displayName!
                  : 'NOT LOGIN YET')),
            ],
          ),
        ),
      ),
    );
  }
}
