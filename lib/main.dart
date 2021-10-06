// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:blood_donation/pages/splsh/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new MySplash(),
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
    ),
  );
}
