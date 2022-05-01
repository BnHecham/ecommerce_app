// ignore_for_file: file_names

import 'package:ecommerce_app/src/config/themes/colors.dart';
import 'package:ecommerce_app/src/provider/login_provider.dart';
import 'package:ecommerce_app/src/services/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/themes/theme.dart';
import '../../widgets/build_app_bar.dart';
import '../../widgets/profile_widget.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<LoginProvider>().getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          customAppBar(context, action: false, leadingMethod: 'back',
              leadingOnPressed: () {
            Navigator.pop(context);
          }),
        ],
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            ProfileWidget(
              imagePath: 'images/customer_login_avatar.png',
              editIcon: true,
              onClicked: () async {},
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: buildMainInfo(context),
            ),
            const Divider(
              thickness: 1,
              height: 10,
              indent: 30,
              endIndent: 30,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMainInfo(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, user , child) => Column(
        children: [
          Text(
            user.user!.user!.name!.toTitleCase(),
            style: AppTheme.h3Style,
          ),
          const SizedBox(
            height: 5.0,
          ),
          Text(
            user.user!.user!.email!,
            style: AppTheme.fadedTitleStyle,
          )
        ],
      )
    );
  }
}
