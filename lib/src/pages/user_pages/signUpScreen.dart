// ignore_for_file: file_names

import 'package:ecommerce_app/src/pages/user_pages/signInScreen.dart';
import 'package:ecommerce_app/src/provider/register_provider.dart';
import 'package:ecommerce_app/src/widgets/un_focus_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/themes/colors.dart';
import '../../config/themes/theme.dart';
import '../../config/route.dart';
import '../../services/helper.dart';
import '../../widgets/buildTextField.dart';
import '../../widgets/build_button.dart';
import '../../widgets/social_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {


  TextEditingController firstNameField = TextEditingController();
  TextEditingController lastNameField = TextEditingController();
  TextEditingController emailField = TextEditingController();
  TextEditingController passwordField = TextEditingController();
  TextEditingController phoneField = TextEditingController();
  TextEditingController skillsField = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;


  @override
  Widget build(BuildContext context) {
    return UnFocus(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          reverse: true,
          child: Column(children: [
            const BuildCircularHeader(
              headText: 'New Account!',
              normalText: 'Sign up \nand get started',
            ),
            const SizedBox(
              height: 40,
            ),
            _buildForm(), //Password
            _buildSignUpButton(context),
            _buildRichText(),
            const SocialWidget(),
          ]),
        ),
      ),
    );
  }

  RichText _buildRichText() {
    return RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                const TextSpan(
                  text: "Have an account? ",
                ),
                TextSpan(
                  text: "Log in",
                  style: const TextStyle(
                    color: Colors.blue,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      pushReplacement(const SignInScreen());

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

  Padding _buildSignUpButton(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: BuildButton(
                width: 150.0,
                color: AppColor.orange,
                text: "Sign up",
                textColor: Colors.white,
                onPressed: () {
                  final formKey = _formKey.currentState!;
                  setState(() {
                    _autoValidate = true;
                  });
                  if (formKey.validate()) {
                    context.read<RegisterProvider>().signUp(context,
                        name: '${firstNameField.text} ${lastNameField.text}',
                        email: emailField.text,
                        password: passwordField.text);
                  }
                }),
          );
  }

  Form _buildForm() {
    return Form(
            key: _formKey,
            autovalidateMode: _autoValidate
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BuildTextField(
                      controller: firstNameField,
                      label: "First name",
                      textFieldWidth: 150,
                      validator: (val) => validateName(val),
                    ),
                    BuildTextField(
                      controller: lastNameField,
                      label: "Last name",
                      textFieldWidth: 150,
                      validator: (val) => validateName(val),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5.0,
                ),
                BuildTextField(
                  controller: emailField,
                  icon: Icons.email,
                  label: "Email",
                  keyboardType: TextInputType.emailAddress,
                  hint: "Name@Example.com",
                  validator: (val) => validateEmail(val!),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                BuildTextField(
                  controller: passwordField,
                  icon: Icons.lock,
                  label: "Password",
                  keyboardType: TextInputType.visiblePassword,
                  isObscure: true,
                  symbol: "*",
                  hint: "",
                  validator: (val) => validatePassword(val),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                BuildTextField(
                  controller: phoneField,
                  icon: Icons.phone_iphone,
                  label: "Phone number",
                  keyboardType: TextInputType.phone,
                  hint: "",
                  validator: (val) => validateMobile(val),
                ),
              ],
            ),
          );
  }
}
