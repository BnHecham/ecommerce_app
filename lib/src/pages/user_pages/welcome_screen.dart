// ignore_for_file: file_names

import 'package:ecommerce_app/src/config/route.dart';
import 'package:ecommerce_app/src/pages/user_pages/signInScreen.dart';
import 'package:ecommerce_app/src/pages/user_pages/signUpScreen.dart';
import 'package:flutter/material.dart';
import '../../config/route.dart';
import '../../config/themes/colors.dart';
import '../../config/themes/theme.dart';
import '../../widgets/build_button.dart';
import '../../widgets/build_text.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildImage(context),
            _buildText(),
            _buildButtons()
          ],
        ),
      ),
    );
  }

  Container _buildImage(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      padding: const EdgeInsets.only(top: 30.0),
      child: Container(
          width: AppTheme.fullWidth(context),
          height: AppTheme.fullHeight(context) / 2,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/shopping.png'),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          )),
    );
  }

  Container _buildText() {
    return Container(
      margin: const EdgeInsets.only(
          left: 20.0, bottom: 30.0, right: 20.0, top: 10.0),
      child: Column(
        children: [
          Row(
            children: [
              buildHeadText(text: "Welcome !", fontSize: 30.0),
            ],
          ), //Welcome!
          const SizedBox(
            height: 5.0,
          ),
          Row(
            children: [
              Expanded(
                child: buildNormalText(
                    text:
                    "Login with your data that you entered during your registration.",
                    fontSize: 20.0),
              )
            ],
          ) // Login with your data
        ],
      ),
    );
  }

  Column _buildButtons() {
    return Column(
            children: [
              BuildButton(
                width: 280,
                color: AppColor.orange,
                text: "Sign up",
                textColor: Colors.white,
                onPressed: () {
                  pushReplacement(const RegisterScreen());
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              BuildButton(
                width: 280,
                color: AppColor.orange,
                text: "Sign in",
                textColor: AppColor.black,
                onPressed: () {
                  pushReplacement(const SignInScreen());
                },
              )
            ],
          );
  }

}
