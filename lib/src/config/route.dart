import 'package:ecommerce_app/main.dart';
import 'package:flutter/material.dart';

push(Widget child) async => Navigator.of(navigator.currentContext!)
    .push(MaterialPageRoute(builder: (context) => child));

replacement(Widget child) => Navigator.of(navigator.currentContext!)
    .pushReplacement(MaterialPageRoute(builder: (context) => child));

pushAndRemoveUntil(Widget child) =>
    Navigator.of(navigator.currentContext!).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => child), (route) => false);

pushReplacement(Widget child) => Navigator.of(navigator.currentContext!)
    .pushReplacement(MaterialPageRoute(builder: (context) => child));