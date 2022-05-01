// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/themes/colors.dart';

Widget buildNormalText({required String text, required double fontSize}) {
  return Text(
    text,
    style: TextStyle(
        fontSize: fontSize,
        color: AppColor.black,
        letterSpacing: 0.5,
        fontFamily: "Grandstander_SemiBold"),
  );
}

Widget buildHeadText({required String text, required double fontSize}) {
  return Text(
    text,
    style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
        color: AppColor.black,
        letterSpacing: 1.0,
        fontFamily: "Grandstander"),
  );
}

Text titleText(
    {final String? text,
    final double fontSize = 18,
    final Color color = AppColor.titleTextColor,
    final FontWeight fontWeight = FontWeight.w800}) {
  return Text(text!,
      style: GoogleFonts.mulish(
          fontSize: fontSize, fontWeight: fontWeight, color: color));
}
