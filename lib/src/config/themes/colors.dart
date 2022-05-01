import 'package:flutter/material.dart';

class AppColor {
  static const Color background = Color(0XFFFFFFFF);

  static const Color titleTextColor = Color(0xff1d2635);
  static const Color subTitleTextColor = Color(0xff797878);

  static const Color skyBlue = Color(0xff2890c8);
  static const Color lightBlue = Color(0xff5c3dff);

  static const Color orange = Color(0xffFA8165);
  static const Color lightOrange = Color(0xffFB8964);

  static Color opacityOrange = const Color(0xffE65829).withOpacity(.50);
  static const Color red = Color(0xffF72804);

  static const Color lightGrey = Color(0xffE1E2E4);
  static const Color grey = Color(0xffA1A3A6);
  static const Color darkGrey = Color(0xff747F8F);

  static const Color iconColor = Color(0xffFA696C);
  static const Color yellowColor = Color(0xfffbba01);

  static const Color black = Color(0xff20262C);
  static const Color lightBlack = Color(0xff5F5F60);

  static const greyScale = ColorFilter.matrix(<double>[
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0,
    0,
    0,
    1,
    0
  ]);
}
