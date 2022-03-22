import 'package:flutter/material.dart';

class AppTheme {
  static final dark = ThemeData(
      backgroundColor: Color(0xFF5157b2),
      textTheme: TextTheme(
        button: TextStyle(
          color: Colors.white70.withOpacity(0.5),
          fontSize: 15,
          fontWeight: FontWeight.normal,
        ),
        bodyText1: TextStyle(
          color: Colors.black54,
          fontSize: 15,
          fontWeight: FontWeight.normal,
        ),
        caption: TextStyle(
          color: Colors.black54.withOpacity(0.5),
          fontSize: 13,
          fontWeight: FontWeight.normal,
        ),
        headline1: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ));
}
