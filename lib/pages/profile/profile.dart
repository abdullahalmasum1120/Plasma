import 'dart:io';
import 'package:blood_donation/components/constant/colors.dart';
import 'package:blood_donation/components/constant/size.dart';
import 'package:blood_donation/components/constant/styles.dart';
import 'package:blood_donation/components/dialogs/loading.dart';
import 'package:blood_donation/components/dialogs/request_succesful.dart';
import 'package:blood_donation/pages/authentication/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

class Profile extends StatelessWidget {
  final String uid;

  const Profile({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        titleTextStyle: MyTextStyles(MyColors.primary).titleTextStyle,
        iconTheme: const IconThemeData(
          color: MyColors.primary,
        ),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: MyColors.white,
        title: const Text("Profile"),
        actions: [
          IconButton(
            onPressed: () {
              //TODO: implement Edit profile
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MySizes.defaultSpace / 2),
          child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text("Error loading Data"));
                }
                if (snapshot.hasData && !snapshot.data!.exists) {
                  return const Center(child: Text("Document does not exist"));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: MyColors.primary,
                    ),
                  );
                }

                Map<String, dynamic> userData =
                    snapshot.data!.data() as Map<String, dynamic>;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            offset: const Offset(16, 16),
                            blurRadius: 40,
                            spreadRadius: 16,
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(MySizes.defaultRadius),
                            child: (userData["image"] != null)
                                ? Image.network(
                                    userData["image"],
                                    fit: BoxFit.cover,
                                    height: (context.width * 0.32),
                                    width: (context.width * 0.32),
                                  )
                                : const Icon(
                                    Icons.account_box,
                                    size: MySizes.largeIconSize,
                                    color: MyColors.primary,
                                  ),
                          ),
                          (FirebaseAuth.instance.currentUser!.uid == uid)
                              ? Positioned(
                                  bottom: 5,
                                  right: 5,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: MyColors.white,
                                      border: Border.all(
                                        color: MyColors.primary,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: GestureDetector(
                                      onTap: () async {
                                        try {
                                          XFile? file = await ImagePicker()
                                              .pickImage(
                                                  source: ImageSource.gallery);
                                          Get.snackbar(
                                              "Message", "Uploading...");
                                          uploadImage(
                                              File(file!.path)); //uploading

                                        } on FirebaseException catch (e) {
                                          Get.snackbar("Warning!", e.code);
                                        }
                                      },
                                      //hardCoded sized
                                      child: const Padding(
                                        padding: EdgeInsets.all(6),
                                        child: Icon(
                                          Icons.camera_alt,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: MySizes.defaultSpace,
                    ),
                    Text(
                      userData["username"],
                      style: MyTextStyles(MyColors.black).titleTextStyle,
                    ),
                    const SizedBox(
                      height: MySizes.defaultSpace / 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: MyColors.primary,
                        ),
                        Text(
                          "Location",
                          style: MyTextStyles(Colors.black).defaultTextStyle,
                        ),
                      ],
                    ),
                    Text(
                      userData["location"],
                      style: MyTextStyles(MyColors.grey).defaultTextStyle,
                    ),
                    const SizedBox(
                      height: MySizes.defaultSpace * 2,
                    ),
                    (FirebaseAuth.instance.currentUser!.uid != uid)
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                  primary: MyColors.grey,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        MySizes.defaultRadius),
                                  ),
                                ),
                                onPressed: () {
                                  launch("tel:${userData["phone"]}");
                                },
                                child: Row(
                                  children: [
                                    const Icon(Icons.call_outlined),
                                    const SizedBox(
                                      width: MySizes.defaultSpace / 2,
                                    ),
                                    Text(
                                      "Call Now",
                                      style: MyTextStyles(MyColors.white)
                                          .buttonTextStyle,
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                  primary: MyColors.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        MySizes.defaultRadius),
                                  ),
                                ),
                                onPressed: () async {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return const Loading();
                                      });
                                  String id = const Uuid().v1();

                                  Map<String, dynamic> receivedRequest = {
                                    "time": DateFormat('kk:mm')
                                        .format(DateTime.now()),
                                    "date": DateFormat('yyyy-MM-dd')
                                        .format(DateTime.now()),
                                    "uid":
                                        FirebaseAuth.instance.currentUser!.uid,
                                    "status": "unread",
                                    "docId": id,
                                  };
                                  Map<String, dynamic> sentRequest = {
                                    "uid": uid,
                                    "status": "unread",
                                    "docId": id,
                                  };
                                  try {
                                    uploadRequests(sentRequest, receivedRequest,
                                        userData, id);
                                    Navigator.pop(context);
                                    showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) {
                                          return const SuccessfulDialog();
                                        });
                                  } on FirebaseException catch (e) {
                                    Navigator.pop(context);
                                    Get.snackbar("Warning!", e.code);
                                  }
                                },
                                child: Row(
                                  children: [
                                    const Icon(Icons.screen_share_outlined),
                                    const SizedBox(
                                      width: MySizes.defaultSpace / 2,
                                    ),
                                    Text(
                                      "Request",
                                      style: MyTextStyles(MyColors.white)
                                          .buttonTextStyle,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(),
                    const SizedBox(
                      height: MySizes.defaultSpace,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Card(
                          elevation: 3,
                          child: Padding(
                            padding: EdgeInsets.all(context.width * .03),
                            child: Column(
                              children: [
                                Text(
                                  userData["bloodGroup"],
                                  style: MyTextStyles(MyColors.black)
                                      .buttonTextStyle,
                                ),
                                Text(
                                  "blood Type",
                                  style: MyTextStyles(MyColors.grey)
                                      .defaultTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          elevation: 3,
                          child: Padding(
                            padding: EdgeInsets.all(context.width * .03),
                            child: Column(
                              children: [
                                Text(
                                  userData["donated"].toString(),
                                  style: MyTextStyles(MyColors.black)
                                      .buttonTextStyle,
                                ),
                                Text(
                                  "Donated",
                                  style: MyTextStyles(MyColors.grey)
                                      .defaultTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          elevation: 3,
                          child: Padding(
                            padding: EdgeInsets.all(context.width * .03),
                            child: Column(
                              children: [
                                Text(
                                  userData["requested"].toString(),
                                  style: MyTextStyles(MyColors.black)
                                      .buttonTextStyle,
                                ),
                                Text(
                                  "Requested",
                                  style: MyTextStyles(MyColors.grey)
                                      .defaultTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: MySizes.defaultSpace,
                    ),
                    Card(
                      elevation: 3,
                      child: Container(
                        height: MySizes.defaultSpace * 3,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: MySizes.defaultSpace,
                          vertical: MySizes.defaultSpace / 2,
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.timelapse_outlined,
                              color: MyColors.primary,
                            ),
                            const SizedBox(
                              width: MySizes.defaultSpace / 2,
                            ),
                            const Expanded(
                              child: Text(
                                "Available for Donate",
                              ),
                            ),
                            FlutterSwitch(
                              width: 56,
                              activeColor: MyColors.primary,
                              value: userData["isAvailable"],
                              onToggle: (isOpen) async {
                                if (FirebaseAuth.instance.currentUser!.uid ==
                                    uid) {
                                  try {
                                    await FirebaseFirestore.instance
                                        .collection("users")
                                        .doc(uid)
                                        .update({"isAvailable": isOpen});
                                  } on FirebaseException catch (e) {
                                    Get.snackbar("Warning!", e.code);
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: MySizes.defaultSpace / 2,
                    ),
                    GestureDetector(
                      onTap: () {
                        //TODO: implement to inVite
                      },
                      child: Card(
                        elevation: 3,
                        child: Container(
                          height: MySizes.defaultSpace * 3,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: MySizes.defaultSpace,
                            vertical: MySizes.defaultSpace / 2,
                          ),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.share_outlined,
                                color: MyColors.primary,
                              ),
                              SizedBox(
                                width: MySizes.defaultSpace / 2,
                              ),
                              Expanded(
                                child: Text(
                                  "Invite a friend (Coming Soon)",
                                  style: TextStyle(color: Colors.green),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: MySizes.defaultSpace / 2,
                    ),
                    Card(
                      elevation: 3,
                      child: Container(
                        height: MySizes.defaultSpace * 3,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: MySizes.defaultSpace,
                          vertical: MySizes.defaultSpace / 2,
                        ),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.help_outline,
                              color: MyColors.primary,
                            ),
                            SizedBox(
                              width: MySizes.defaultSpace / 2,
                            ),
                            Expanded(
                              child: Text(
                                "Get help (Coming soon)",
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: MySizes.defaultSpace / 2,
                    ),
                    Card(
                      elevation: 3,
                      child: Container(
                        height: MySizes.defaultSpace * 3,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: MySizes.defaultSpace,
                          vertical: MySizes.defaultSpace / 2,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          MySizes.defaultRadius),
                                    ),
                                    title: Row(
                                      children: const [
                                        Icon(
                                          Icons.warning,
                                          color: Colors.amber,
                                        ),
                                        SizedBox(
                                          width: MySizes.defaultSpace / 2,
                                        ),
                                        Text("Warning!"),
                                      ],
                                    ),
                                    content:
                                        const Text("Do you want to Sign out?"),
                                    actions: [
                                      GestureDetector(
                                        onTap: () {
                                          FirebaseAuth.instance.signOut();
                                          Get.offAll(() => const Authentication());
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(
                                              MySizes.defaultSpace / 2),
                                          child: Text(
                                            "Sign out",
                                            style: MyTextStyles(MyColors.black)
                                                .defaultTextStyle,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(
                                              MySizes.defaultSpace / 2),
                                          child: Text(
                                            "Cancel",
                                            style:
                                                MyTextStyles(MyColors.primary)
                                                    .buttonTextStyle,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: Row(
                            children: const [
                              Icon(
                                Icons.exit_to_app_outlined,
                                color: MyColors.primary,
                              ),
                              SizedBox(
                                width: MySizes.defaultSpace / 2,
                              ),
                              Expanded(
                                child: Text("Sign out"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                );
              }),
        ),
      ),
    );
  }

  void uploadImage(File file) async {
    Reference reference = FirebaseStorage.instance
        .ref("profileImagesOfUser")
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child("profileImage.${path.extension(file.path)}");

    await reference.putFile(File(file.path));

    String url = await reference.getDownloadURL();

    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .update({"image": url});

    FirebaseAuth.instance.currentUser!.updatePhotoURL(url);
  }

  void uploadRequests(
    Map<String, dynamic> sentRequest,
    Map<String, dynamic> receivedRequest,
    Map<String, dynamic> userData,
    String id,
  ) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("receivedRequests")
        .doc(id)
        .set(receivedRequest);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("sentRequests")
        .doc(id)
        .set(sentRequest);

    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"requested": userData["requested"]++});
  }
}
