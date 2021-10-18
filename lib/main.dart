// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:blood_donation/pages/splsh/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    new FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return new MaterialApp(
            debugShowCheckedModeBanner: false,
            home: new MySplash(),
          );
        }
        return new MaterialApp(
          home: new CircularProgressIndicator(
            color: Colors.white,
          ),
        );
      },
    ),
  );
}
