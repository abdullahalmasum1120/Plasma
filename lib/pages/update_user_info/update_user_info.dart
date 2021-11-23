// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:blood_donation/components/assentials/data_validator.dart';
import 'package:blood_donation/components/dialogs/loading.dart';
import 'package:blood_donation/components/filled_Button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UpdateUserInfo extends StatefulWidget {
  const UpdateUserInfo({
    Key? key,
  }) : super(key: key);

  @override
  State<UpdateUserInfo> createState() => _UpdateUserInfoState();
}

class _UpdateUserInfoState extends State<UpdateUserInfo> {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController locationController = new TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _selectedBloodGroup = "default";

  @override
  void dispose() {
    // TODO: implement dispose
    usernameController.dispose();
    emailController.dispose();
    locationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
      child: new Scaffold(
        backgroundColor: Colors.white,
        body: new Center(
          child: new SingleChildScrollView(
            child: new Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: new Form(
                key: _formKey,
                child: new Column(
                  children: [
                    new SizedBox(
                      height: 40,
                    ),
                    new SvgPicture.asset(
                      "assets/icons/logo.svg",
                      height: 100,
                      width: 100,
                    ),
                    new SizedBox(
                      height: 20,
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        new Text(
                          "Dare ",
                          style: new TextStyle(
                            color: new Color(0xFFFF2156),
                            fontSize: 25,
                          ),
                        ),
                        new Text(
                          "To ",
                          style: new TextStyle(
                            color: new Color(0xFF000000),
                            fontSize: 25,
                          ),
                        ),
                        new Text(
                          "Donate ",
                          style: new TextStyle(
                            color: new Color(0xFFFF2156),
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                    new SizedBox(
                      height: 40,
                    ),
                    new TextFormField(
                      validator: (username) {
                        if (DataValidator.isValidateUsername(username!)) {
                          return null;
                        }
                        return "Please Enter a valid Username";
                      },
                      keyboardType: TextInputType.name,
                      controller: usernameController,
                      decoration: new InputDecoration(
                        border: InputBorder.none,
                        hintText: "Your name",
                        fillColor: new Color(0xFFF8F8F8),
                        filled: true,
                        prefixIcon: new Icon(
                          Icons.account_circle_outlined,
                          color: new Color(0xFFFF2156),
                        ),
                      ),
                    ),
                    new SizedBox(
                      height: 20,
                    ),
                    new TextFormField(
                      validator: (email) {
                        if (DataValidator.isValidateEmail(email!)) {
                          return null;
                        }
                        return "Please Enter a valid Email";
                      },
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: new InputDecoration(
                        border: InputBorder.none,
                        hintText: "Email",
                        fillColor: new Color(0xFFF8F8F8),
                        filled: true,
                        prefixIcon: new Icon(
                          Icons.email_outlined,
                          color: new Color(0xFFFF2156),
                        ),
                      ),
                    ),
                    new SizedBox(
                      height: 20,
                    ),
                    new TextFormField(
                      validator: (location) {
                        if (DataValidator.isValidateLocation(location!)) {
                          return null;
                        }
                        return "Please Enter a valid Username";
                      },
                      controller: locationController,
                      keyboardType: TextInputType.text,
                      decoration: new InputDecoration(
                        border: InputBorder.none,
                        hintText: "Location",
                        fillColor: new Color(0xFFF8F8F8),
                        filled: true,
                        prefixIcon: new Icon(
                          Icons.location_city_outlined,
                          color: new Color(0xFFFF2156),
                        ),
                      ),
                    ),
                    new SizedBox(
                      height: 10,
                    ),
                    new DropdownButtonFormField<String>(
                      validator: (bloodGroup) {
                        if (bloodGroup != null) {
                          return null;
                        }
                        return "Please Select Your Blood Group";
                      },
                      decoration: new InputDecoration(
                        border: InputBorder.none,
                        fillColor: new Color(0xFFF8F8F8),
                        filled: true,
                        prefixIcon: new Icon(
                          Icons.bloodtype,
                          color: new Color(0xFFFF2156),
                        ),
                      ),
                      hint: new Text("Blood Group"),
                      items: <String>[
                        'A+',
                        'A-',
                        'B+',
                        'B-',
                        'O+',
                        'O-',
                        'AB+',
                        'AB-',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          if (value != null) {
                            _selectedBloodGroup = value;
                          }
                        });
                      },
                    ),
                    new SizedBox(
                      height: 50,
                    ),
                    new MyFilledButton(
                      child: new Text(
                        "UPDATE",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      size: new Size(double.infinity, 0),
                      borderRadius: 10,
                      function: () {
                        if (_formKey.currentState!.validate()) {
                          _updateUserInfo(
                            username: usernameController.text.trim(),
                            email: emailController.text.trim(),
                            bloodGroup: _selectedBloodGroup,
                            location: locationController.text.trim(),
                            registrationTime:
                                DateFormat('kk:mm').format(DateTime.now()),
                            registrationDate:
                                DateFormat('yyyy-MM-dd').format(DateTime.now()),
                          );
                        }
                      },
                    ),
                    new SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _updateUserInfo({
    required String username,
    required String email,
    required String bloodGroup,
    required String location,
    required String registrationTime,
    required String registrationDate,
  }) async {
    showDialog(
        context: context,
        builder: (context) {
          return Loading();
        });
    Map<String, dynamic> userInfo = {
      "username": username,
      "email": email,
      "bloodGroup": bloodGroup,
      "location": location,
      "image": null,
      "registrationTime": registrationTime,
      "registrationDate": registrationDate,
      "donated": 0,
      "requested": 0,
      "isAvailable": false,
      "phone": FirebaseAuth.instance.currentUser!.phoneNumber,
      "uid": FirebaseAuth.instance.currentUser!.uid,
    };
    try {
      if (FirebaseAuth.instance.currentUser != null) {
        FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set(userInfo)
            .then((value) => {
                  FirebaseAuth.instance.currentUser!
                      .updateDisplayName(username),
                  Navigator.pop(context),
                  Get.offAllNamed("/"),
                });
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      Get.snackbar("Warning!", e.code);
    }
  }
}
