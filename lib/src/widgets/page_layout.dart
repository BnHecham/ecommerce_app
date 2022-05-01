import 'package:flutter/material.dart';

import '../config/themes/theme.dart';
import 'build_text.dart';

Widget buildPage(BuildContext? context,
    {required Widget child,
    Widget? customTitleWidget,
    String? topText,
    String? bottomText,
    bool customTitle = false}) {
  return Stack(
    fit: StackFit.expand,
    children: [
      customTitle == false
          ? Container(
              padding: const EdgeInsets.only(top: 10),
              margin: AppTheme.padding,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      titleText(
                        text: topText!,
                        fontSize: 27,
                        fontWeight: FontWeight.w400,
                      ),
                      titleText(
                        text: bottomText!,
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              ))
          : customTitleWidget!,
      DraggableScrollableSheet(
        initialChildSize: 0.87,
        maxChildSize: 0.88,
        builder: (context, scrollController) => child,
      )
    ],
  );
}
