import 'package:blood_donation/components/constant/colors.dart';
import 'package:blood_donation/data/model/featured_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'components/appbar.dart';
import 'components/body.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: MyAppBar(
        context: context,
        uid: FirebaseAuth.instance.currentUser!.uid,
      ),
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance.collection("featuredImages").get(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("Error parsing Data"),
              );
            }
            if (snapshot.hasData) {
              List<FeaturedImage> images = <FeaturedImage>[];
              for (var value in snapshot.data!.docs) {
                images.add(FeaturedImage.fromJson(value.data()));
              }
              return MyBody(
                context: context,
                images: images,
              );
            }
            return const Center(
              child: CircularProgressIndicator(
                color: MyColors.primary,
              ),
            );
          }),
    );
  }
}
