import 'package:flutter/material.dart';

class MyTextStyles {
  final Color color;

  MyTextStyles(this.color);

  TextStyle get defaultTextStyle => TextStyle(
        fontSize: 16,
        color: color,
        letterSpacing: 1.25,
        fontWeight: FontWeight.w500,
      );

  TextStyle get largeTextStyle => TextStyle(
        fontSize: 32,
        color: color,
        letterSpacing: 2.0,
        fontWeight: FontWeight.bold,
      );

  TextStyle get buttonTextStyle => TextStyle(
        fontSize: 16,
        color: color,
        fontWeight: FontWeight.w900,
        letterSpacing: 2.0,
      );
}
