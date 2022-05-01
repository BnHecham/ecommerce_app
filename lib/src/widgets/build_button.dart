// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';

class BuildButton extends StatelessWidget {
  BuildButton(
      {Key? key,
      required this.width,
      required this.color,
      required this.text,
      required this.textColor,
      required this.onPressed})
      : super(key: key);

  BuildContext? context;
  final double width;
  final Color color;
  final String text;
  final Color textColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style:
              TextStyle(fontSize: 18.0, color: textColor, letterSpacing: 1.5),
        ),
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          primary: color,
        ),
      ),
    );
  }
}
