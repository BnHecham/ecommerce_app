import 'package:flutter/material.dart';

extension OnPressed on Widget {
  Widget onTap(VoidCallback onPressed,
          {BorderRadius borderRadius =
              const BorderRadius.all(Radius.circular(10))}) =>
      Stack(
        children: <Widget>[
          this,
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: InkWell(
              borderRadius: borderRadius,
              onTap: onPressed,
            ),
          )
        ],
      );
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
