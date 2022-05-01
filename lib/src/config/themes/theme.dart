import 'package:flutter/material.dart';

import 'colors.dart';

class AppTheme {
  const AppTheme();
  static ThemeData themes = ThemeData(
      backgroundColor: AppColor.background,
      primaryColor: AppColor.background,
      cardTheme: const CardTheme(color: AppColor.background),
      textTheme: const TextTheme(bodyText1: TextStyle(color: AppColor.black)),
      iconTheme: const IconThemeData(color: AppColor.iconColor),
      bottomAppBarColor: AppColor.background,
      dividerColor: AppColor.lightGrey,
      primaryTextTheme: const TextTheme(
          bodyText1: TextStyle(color: AppColor.titleTextColor)));

  static TextStyle titleStyle = const TextStyle(
      color: AppColor.titleTextColor,
      fontSize: 16,
      fontWeight: FontWeight.bold);
  static TextStyle appBarTitleStyle = const TextStyle(
      color: AppColor.titleTextColor,
      fontSize: 25,
      fontWeight: FontWeight.bold);
  static TextStyle subTitleStyle =
      const TextStyle(color: AppColor.subTitleTextColor, fontSize: 13);
  static TextStyle fadedTitleStyle = const TextStyle(
      fontWeight: FontWeight.bold, color: Colors.black54, letterSpacing: 1.0);

  static TextStyle h1Style =
      const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  static TextStyle h2Style = const TextStyle(fontSize: 22);
  static TextStyle h3Style =
      const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  static TextStyle h4Style = const TextStyle(fontSize: 18);
  static TextStyle h5Style = const TextStyle(fontSize: 16);
  static TextStyle h6Style = const TextStyle(fontSize: 14);

  static Expanded fixedText(
          {required String text,
          required int maxLines,
          required TextStyle textStyle,
          TextOverflow? textOverflow}) =>
      Expanded(
          child: Text(
        text,
        maxLines: maxLines,
        style: textStyle,
        overflow: textOverflow,
      ));

  static List<BoxShadow> shadow = <BoxShadow>[
    const BoxShadow(color: Color(0xfff8f8f8), blurRadius: 10, spreadRadius: 15),
  ];

  static EdgeInsets padding =
      const EdgeInsets.symmetric(horizontal: 20, vertical: 10);
  static EdgeInsets hPadding = const EdgeInsets.symmetric(
    horizontal: 10,
  );

  static double fullWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double fullHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}

class BuildCircularHeader extends StatelessWidget {
  const BuildCircularHeader(
      {Key? key, required this.headText, required this.normalText}) : super(key: key);

  final Color color1 = const Color(0xffFA696C);
  final Color color2 = const Color(0xffFA8165);
  final Color color3 = const Color(0xffFB8964);

  final String headText;

  final String normalText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            left: -100,
            top: -150,
            child: Container(
              width: 350,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [color1, color2]),
                  boxShadow: [
                    BoxShadow(
                        color: color2,
                        offset: const Offset(4.0, 4.0),
                        blurRadius: 10.0)
                  ]),
            ),
          ),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [color3, color2]),
                boxShadow: [
                  BoxShadow(
                      color: color3,
                      offset: const Offset(1.0, 1.0),
                      blurRadius: 4.0)
                ]),
          ),
          Positioned(
            top: 100,
            right: 200,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [color3, color2]),
                  boxShadow: [
                    BoxShadow(
                        color: color3,
                        offset: const Offset(1.0, 1.0),
                        blurRadius: 4.0)
                  ]),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 60, left: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  headText,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10.0),
                Text(
                  normalText,
                  style: const TextStyle(color: Colors.white, fontSize: 18.0),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
