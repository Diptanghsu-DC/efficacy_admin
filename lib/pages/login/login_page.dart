import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/controllers/controllers.dart';
import 'package:efficacy_admin/pages/login/widgets/google_sign_in_button.dart';
import 'package:efficacy_admin/pages/pages.dart';

// import 'package:efficacy_admin/pages/sign_up/signup_page.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  //route
  static const String routeName = "/LoginPage";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    login();
  }

  void login() async {
    await UserController.login(email: "raj@gmail.com", password: "123456");
  }

  @override
  Widget build(BuildContext context) {
    //screen height and width
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    //size constants
    double avatarRadius = width * 0.25;
    double gap = height * 0.05;
    double smallGap = height * 0.01;
    double messageFieldWidth = 0.85;

    return WillPopScope(
      onWillPop: () async {
        final quitCondition = await showExitWarning(context);
        return quitCondition ?? false;
      },
      child: Scaffold(
        body: SizedBox(
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                radius: avatarRadius,
                child: Image.asset(Assets.efficacyAdminLogoImagePath),
              ),
              Text(
                "Hey! Welcome",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              FractionallySizedBox(
                widthFactor: messageFieldWidth,
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suscipit sed augue quam amet, sed gravida.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              Column(
                children: [
                  const GoogleSignInButton(),
                  // Toggle button to signup page
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          SignUpPage.routeName,
                          (Route<dynamic> route) => false);
                    },
                    child: RichText(
                      text: const TextSpan(
                          text: "Don't have an account? ",
                          children: [
                            TextSpan(
                                text: "Sign Up",
                                style: TextStyle(
                                    color: dark,
                                    decoration: TextDecoration.underline))
                          ],
                          style: TextStyle(color: shadow)),
                    ),
                  ),
                ].separate(smallGap),
              ),
            ].separate(gap),
          ),
        ),
      ),
    );
  }
}
