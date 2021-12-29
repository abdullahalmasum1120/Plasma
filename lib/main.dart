import 'package:blood_donation/pages/authentication/authentication.dart';
import 'package:blood_donation/pages/home/home.dart';
import 'package:blood_donation/pages/update_user_info/update_user_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            home: FutureBuilder<Widget>(
                future: buildScreen(FirebaseAuth.instance.currentUser),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    return snapshot.data!;
                  }
                  return Center(child: CircularProgressIndicator());
                }),
          );
        }
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}

Future<Widget> buildScreen(User? currentUser) async {
  if (currentUser != null) {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      if (snapshot.data() != null && snapshot.data()!.isNotEmpty) {
        return Home();
      } else {
        return UpdateUserInfo();
      }
    } on FirebaseException catch (e) {
      Get.snackbar("Warning!", "${e.code}.\n Please restart your App");
    }
  }
  return Authentication();
}
