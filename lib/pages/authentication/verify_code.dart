// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:blood_donation/components/assentials/data_validator.dart';
import 'package:blood_donation/components/dialogs/loading.dart';
import 'package:blood_donation/components/filled_Button.dart';
import 'package:blood_donation/components/outlined_button.dart';
import 'package:blood_donation/pages/home/home.dart';
import 'package:blood_donation/pages/update_user_info/user_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CodeVerify extends StatefulWidget {
  final String phoneNo;
  final String verificationId;
  final int? token;

  const CodeVerify({
    Key? key,
    required this.phoneNo,
    required this.verificationId,
    required this.token,
  }) : super(key: key);

  @override
  State<CodeVerify> createState() => _CodeVerifyState();
}

class _CodeVerifyState extends State<CodeVerify> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _codeEditingController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
        child: new Scaffold(
      body: new Center(
        child: new SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: new Column(
              children: [
                new SizedBox(
                  height: 60,
                ),
                new Image.asset(
                  "assets/images/phone_auth.png",
                  scale: 6.0,
                ),
                new SizedBox(
                  height: 40,
                ),
                new Text(
                  "Verify your phone",
                  style: new TextStyle(
                    color: new Color(0xFFFF2156),
                    fontSize: 25,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                new SizedBox(
                  height: 20,
                ),
                new Text(
                  "We have sent a 6-digits verification code to this number",
                  style: new TextStyle(
                    color: Colors.black,
                    letterSpacing: 1.25,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
                new SizedBox(
                  height: 20,
                ),
                new Form(
                  key: _formKey,
                  child: new PinCodeTextField(
                    controller: _codeEditingController,
                    keyboardType: TextInputType.number,
                    validator: (code) {
                      if (DataValidator.isValidateCode(code!)) {
                        return null;
                      }
                      return "Please Provide full code";
                    },
                    appContext: context,
                    onChanged: (String value) {
                      print(value);
                    },
                    length: 6,
                  ),
                ),
                new SizedBox(
                  height: 20,
                ),
                new MyOutlinedButton(
                  text: "Resend Code",
                  size: new Size(0, 0),
                  function: () {},
                  borderRadius: 10,
                ),
                new SizedBox(
                  height: 20,
                ),
                new MyFilledButton(
                  child: new Text(
                    "Finish",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  size: new Size(double.infinity, 0),
                  function: () {
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Loading();
                        },
                      );
                      final PhoneAuthCredential _phoneAuthCredential =
                          PhoneAuthProvider.credential(
                        verificationId: widget.verificationId,
                        smsCode: _codeEditingController.text,
                      );
                      try {
                        FirebaseAuth.instance
                            .signInWithCredential(_phoneAuthCredential)
                            .then((value) => {
                                  if (value.user != null)
                                    {
                                      _hasUserData(value.user).then((value) => {
                                            if (value)
                                              {
                                                Navigator.pushAndRemoveUntil(
                                                  context,
                                                  new MaterialPageRoute(
                                                    builder: (context) {
                                                      return new MyHome();
                                                    },
                                                  ),
                                                  (route) => false,
                                                ),
                                              }
                                            else
                                              {
                                                Navigator.pushAndRemoveUntil(
                                                  context,
                                                  new MaterialPageRoute(
                                                    builder: (context) {
                                                      return new UpdateUserInfo();
                                                    },
                                                  ),
                                                  (route) => false,
                                                ),
                                              }
                                          }),
                                    }
                                })
                            .catchError(
                              (error) {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  new SnackBar(
                                    duration: Duration(seconds: 5),
                                    content: Text(error.code),
                                  ),
                                );
                              },
                            );
                      } on FirebaseAuthException catch (_firebaseAuthException) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          new SnackBar(
                            duration: Duration(seconds: 5),
                            content: Text(_firebaseAuthException.code),
                          ),
                        );
                      }
                    }
                  },
                  borderRadius: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Future<bool> _hasUserData(User? user) async {
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance
            .collection("users")
            .doc(user!.uid)
            .get();
    if (snapshot.data() != null && snapshot.data()!.isNotEmpty) {
      return true;
    }
    return false;
  }
}
