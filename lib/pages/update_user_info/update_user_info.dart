import 'package:blood_donation/components/assentials/data_validator.dart';
import 'package:blood_donation/components/constant/colors.dart';
import 'package:blood_donation/components/constant/size.dart';
import 'package:blood_donation/components/constant/styles.dart';
import 'package:blood_donation/components/dialogs/loading.dart';
import 'package:blood_donation/components/filled_Button.dart';
import 'package:blood_donation/model/my_user.dart';
import 'package:blood_donation/pages/home/home.dart';
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
  //controllers
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  //keys
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _selectedBloodGroup;

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    locationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, //overriding system back button
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
        child: Scaffold(
          backgroundColor: MyColors.white,
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(MySizes.defaultSpace),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: MySizes.defaultSpace * 1.5,
                      ),
                      SvgPicture.asset(
                        "assets/icons/logo.svg",
                        height: MySizes.largeIconSize,
                        width: MySizes.largeIconSize,
                      ),
                      const SizedBox(
                        height: MySizes.defaultSpace,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Dare ",
                            style: TextStyle(
                              color: MyColors.primary,
                              fontSize: 24,
                            ),
                          ),
                          Text(
                            "To ",
                            style: TextStyle(
                              color: MyColors.black,
                              fontSize: 24,
                            ),
                          ),
                          Text(
                            "Donate ",
                            style: TextStyle(
                              color: MyColors.primary,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: MySizes.defaultSpace * 2,
                      ),
                      TextFormField(
                        validator: (username) {
                          if (DataValidator.isValidateUsername(username!)) {
                            return null;
                          }
                          return "Please Enter a valid Username";
                        },
                        keyboardType: TextInputType.name,
                        controller: usernameController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Your name",
                          fillColor: MyColors.textFieldBackground,
                          filled: true,
                          prefixIcon: Icon(
                            Icons.account_circle_outlined,
                            color: MyColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: MySizes.defaultSpace,
                      ),
                      TextFormField(
                        validator: (email) {
                          if (DataValidator.isValidateEmail(email!)) {
                            return null;
                          }
                          return "Please Enter a valid Email";
                        },
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email",
                          fillColor: MyColors.textFieldBackground,
                          filled: true,
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: MyColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: MySizes.defaultSpace,
                      ),
                      TextFormField(
                        validator: (location) {
                          if (DataValidator.isValidateLocation(location!)) {
                            return null;
                          }
                          return "Please Enter a valid Username";
                        },
                        controller: locationController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Location",
                          fillColor: MyColors.textFieldBackground,
                          filled: true,
                          prefixIcon: Icon(
                            Icons.location_city_outlined,
                            color: MyColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: MySizes.defaultSpace,
                      ),
                      DropdownButtonFormField<String>(
                        validator: (bloodGroup) {
                          if (bloodGroup != null) {
                            return null;
                          }
                          return "Please Select Your Blood Group";
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          fillColor: MyColors.textFieldBackground,
                          filled: true,
                          prefixIcon: Icon(
                            Icons.bloodtype,
                            color: MyColors.primary,
                          ),
                        ),
                        hint: const Text("Blood Group"),
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
                      const SizedBox(
                        height: MySizes.defaultSpace * 3,
                      ),
                      MyFilledButton(
                        child: Text(
                          "UPDATE",
                          style: MyTextStyles(MyColors.white).buttonTextStyle,
                        ),
                        size: MySizes.maxButtonSize,
                        borderRadius: MySizes.defaultRadius,
                        function: () {
                          if (_formKey.currentState!.validate()) {
                            _updateUserInfo(
                              username: usernameController.text.trim(),
                              email: emailController.text.trim(),
                              bloodGroup: _selectedBloodGroup,
                              location: locationController.text.trim(),
                              registrationTime:
                                  DateFormat('kk:mm').format(DateTime.now()),
                              registrationDate: DateFormat('yyyy-MM-dd')
                                  .format(DateTime.now()),
                            );
                          }
                        },
                      ),
                      const SizedBox(
                        height: MySizes.defaultSpace * 2,
                      ),
                    ],
                  ),
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
          return const Loading();
        });
    MyUser myUser =  MyUser(
      username: username,
      email:  email,
      bloodGroup: bloodGroup,
      location: location,
      registrationTime: registrationTime,
      registrationDate: registrationDate,
      donated: 0,
      requested: 0,
      isAvailable: false,
      phone: FirebaseAuth.instance.currentUser!.phoneNumber,
      uid: FirebaseAuth.instance.currentUser!.uid,
    );

    try {
      if (FirebaseAuth.instance.currentUser != null) {
        FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set(myUser.toJson()) //TODO: debug point
            .then((value) => {
                  FirebaseAuth.instance.currentUser!
                      .updateDisplayName(username),
                  Navigator.pop(context),
                  Get.offAll(() => const Home()),
                });
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      Get.snackbar("Warning!", e.code);
    }
  }
}
