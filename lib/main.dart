// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:blood_donation/pages/authentication/authentication.dart';
import 'package:blood_donation/pages/bording/boarding.dart';
import 'package:blood_donation/pages/home/home.dart';
import 'package:blood_donation/pages/splsh/splash.dart';
import 'package:blood_donation/pages/update_user_info/update_user_info.dart';
import 'package:blood_donation/providers/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return new MultiProvider(
            providers: [
              Provider(
                  create: (context) =>
                      AuthProvider(firebaseAuth: FirebaseAuth.instance)),
            ],
            child: new GetMaterialApp(
              debugShowCheckedModeBanner: false,
              routes: {
                "/": (context) => new Home(),
                "/splash": (context) => new Splash(),
                "/authentication": (context) => new Authentication(),
                "/userInfoUpdate": (context) => new UpdateUserInfo(),
                "/boarding": (context) => new Boarding(),
              },
              initialRoute: "/splash",
            ),
          );
        }
        return new MaterialApp(
          debugShowCheckedModeBanner: false,
          home: new Center(
            child: new CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
