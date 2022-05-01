import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../config/themes/colors.dart';

class SocialWidget extends StatelessWidget {
  const SocialWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(30.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: AppColor.grey.withOpacity(.2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              icon: const FaIcon(FontAwesomeIcons.facebookF),
              color: Colors.blue,
              onPressed: () {
                print("Pressed");
              }),
          IconButton(
              icon: const FaIcon(FontAwesomeIcons.twitter),
              color: Colors.lightBlue,
              onPressed: () {
                print("Pressed");
              }),
          IconButton(
              icon: const FaIcon(FontAwesomeIcons.linkedin),
              color: Colors.blueAccent,
              onPressed: () {
                print("Pressed");
              }),
          IconButton(
              icon: const FaIcon(FontAwesomeIcons.github),
              color: Colors.deepPurple,
              onPressed: () {
                print("Pressed");
              }),
        ],
      ),
    );
  }
}
