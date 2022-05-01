// ignore_for_file: file_names

import 'package:ecommerce_app/src/pages/user_pages/signUpScreen.dart';
import 'package:ecommerce_app/src/provider/login_provider.dart';
import 'package:ecommerce_app/src/widgets/un_focus_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/route.dart';
import '../../provider/product_provider.dart';
import '../../config/themes/colors.dart';
import '../../config/themes/theme.dart';
import '../../widgets/buildTextField.dart';
import '../../widgets/build_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailField = TextEditingController();
  TextEditingController passwordField = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return UnFocus(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(
                height: 40.0,
              ),
              _buildForm(), //Password
              _buildSignInButton(context),
              _buildRichText(),
            ],
          ),
        ),
      ),
    );
  }

  BuildCircularHeader _buildHeader() {
    return const BuildCircularHeader(
              headText: 'Welcome!',
              normalText: 'Sign in \nand get started',
            );
  }

  Form _buildForm() {
    return Form(
              key: _formKey,
              child: Column(
                children: [
                  BuildTextField(
                      controller: emailField,
                      icon: Icons.email,
                      label: "Email",
                      hint: "Name@Example.com"),
                  const SizedBox(height: 10.0),
                  BuildTextField(
                    controller: passwordField,
                    icon: Icons.lock,
                    label: "Password",
                    isObscure: true,
                    symbol: "*",
                    hint: "",
                  ),
                ],
              ),
            );
  }

  Padding _buildSignInButton(BuildContext context) {
    return Padding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              child: BuildButton(
                  width: 150.0,
                  color: AppColor.orange,
                  text: "Sign In",
                  textColor: Colors.white,
                  onPressed: () {
                    final formKey = _formKey.currentState!;
                    if (formKey.validate()) {
                      context.read<LoginProvider>().signIn(context ,email : emailField.text , password : passwordField.text);
                      context.read<ProductProvider>().getProducts(context);
                    }
                  }),
            );
  }

  RichText _buildRichText() {
    return RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: "Don't have an account? ",
                  ),
                  TextSpan(
                    text: "sign up",
                    style: const TextStyle(
                      color: Colors.blue,
                      //decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        pushReplacement(const RegisterScreen());
                      },
                  ),
                ],
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
            );
  }
}
