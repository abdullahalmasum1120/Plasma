// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'dart:async';
import 'package:blood_donation/components/assentials/data_validator.dart';
import 'package:blood_donation/components/dialogs/loading.dart';
import 'package:blood_donation/components/filled_Button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum AuthState {
  codeSent,
  sendingCode,
  idle,
}

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  AuthState authState = AuthState.idle;
  String _verificationId = "default";
  final GlobalKey<FormState> _phoneFormKey = new GlobalKey<FormState>();
  final TextEditingController _phoneController = new TextEditingController();
  final GlobalKey<FormState> _codeFormKey = GlobalKey<FormState>();
  final TextEditingController _codeController = new TextEditingController();
  int? _forceResendingToken;
  int resendDuration = 120;

  @override
  void dispose() {
    // TODO: implement dispose
    _phoneController.dispose();
    _codeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusScopeNode());
      },
      child: new Scaffold(
        body: new Center(
          child: new SingleChildScrollView(
            child: new Padding(
              padding: EdgeInsets.all(20),
              child: new Column(
                children: [
                  new SizedBox(
                    height: 40,
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
                    "We will send you a 6-digits verification code to this number",
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
                    key: _phoneFormKey,
                    child: new TextFormField(
                      controller: _phoneController,
                      validator: (phone) {
                        if (DataValidator.isValidatePhone(phone!.trim())) {
                          return null;
                        }
                        return "Please provide a valid Phone number";
                      },
                      keyboardType: TextInputType.phone,
                      maxLength: 11,
                      style: new TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        letterSpacing: 2.0,
                      ),
                      decoration: new InputDecoration(
                        fillColor: new Color(0xFFF8F8F8),
                        filled: true,
                        border: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: "Phone No",
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        prefixIcon: new Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: new Text(
                            "+88",
                            style: new TextStyle(
                              fontSize: 18,
                              color: new Color(0xFFFF2156),
                              letterSpacing: 2.0,
                            ),
                          ),
                        ),
                        suffix: new Material(
                          child: new InkWell(
                            onTap: (authState == AuthState.codeSent)
                                ? null
                                : () {
                                    if (_phoneFormKey.currentState!
                                        .validate()) {
                                      setState(() {
                                        authState = AuthState.sendingCode;
                                      });
                                      verifyPhoneNo();
                                    }
                                  },
                            child: (authState == AuthState.sendingCode)
                                ? CircularProgressIndicator(
                                    color: new Color(0xFFFF2156),
                                  )
                                : new Text(
                                    (authState == AuthState.codeSent)
                                        ? "$resendDuration s"
                                        : "Get Code",
                                    style: new TextStyle(
                                      color: (authState == AuthState.codeSent)
                                          ? Colors.grey
                                          : new Color(0xFFFF2156),
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1.25,
                                    ),
                                  ),
                          ),
                        ),
                        prefixIconConstraints: new BoxConstraints(
                          maxWidth: 80,
                        ),
                        alignLabelWithHint: true,
                      ),
                      readOnly: (authState == AuthState.codeSent),
                    ),
                  ),
                  (authState == AuthState.codeSent)
                      ? new Form(
                          key: _codeFormKey,
                          child: new TextFormField(
                            controller: _codeController,
                            validator: (code) {
                              if (DataValidator.isValidateCode(code!)) {
                                return null;
                              }
                              return "Please provide a valid Phone number";
                            },
                            keyboardType: TextInputType.number,
                            maxLength: 6,
                            style: new TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              letterSpacing: 2.0,
                            ),
                            decoration: new InputDecoration(
                              fillColor: new Color(0xFFF8F8F8),
                              filled: true,
                              border: new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: "6-digit Verification Code",
                              contentPadding: EdgeInsets.all(10),
                            ),
                          ),
                        )
                      : new SizedBox(),
                  new SizedBox(
                    height: 20,
                  ),
                  new MyFilledButton(
                    child: new Text(
                      "Confirm",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    size: new Size(double.infinity, 0),
                    function: (authState == AuthState.codeSent)
                        ? () async {
                            if (_codeFormKey.currentState!.validate()) {
                              if (_verificationId != "default") {
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return new Loading();
                                    });

                                signIn();
                              }
                            }
                          }
                        : null,
                    borderRadius: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void verifyPhoneNo() {
    FirebaseAuth.instance.verifyPhoneNumber(
      forceResendingToken: _forceResendingToken,
      timeout: Duration(minutes: 2),
      phoneNumber: "+88${_phoneController.text.trim()}",
      verificationCompleted: (PhoneAuthCredential _phoneAuthCredential) {
        setState(() {
          authState = AuthState.idle;
        });
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return new Loading();
          },
        );
        signIn();
      },
      verificationFailed: (FirebaseAuthException e) {
        setState(() {
          authState = AuthState.idle;
        });

        Get.snackbar("Warning!", e.code);
      },
      codeSent: (String _verificationId, int? _forceResendingToken) {
        this._verificationId = _verificationId;
        this._forceResendingToken = _forceResendingToken;

        setState(() {
          authState = AuthState.codeSent;
        });
        activateTimer();
      },
      codeAutoRetrievalTimeout: (String _verificationId) {
        setState(() {
          authState = AuthState.idle;
        });
      },
    );
  }

  void signIn() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: _codeController.text.trim(),
      ));
      if (userCredential.user != null) {
        try {
          DocumentSnapshot<Map<String, dynamic>> snapshot =
              await FirebaseFirestore.instance
                  .collection("users")
                  .doc(userCredential.user!.uid)
                  .get();
          if (snapshot.data() != null && snapshot.data()!.isNotEmpty) {
            //data exist
            Navigator.pop(context);
            Get.offAllNamed("/");
          } else {
            Get.offAllNamed("/userInfoUpdate");
          }
        } on FirebaseException catch (e) {
          Navigator.of(context).pop();
          Get.snackbar("Warning!", e.code);
        }
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      Get.snackbar("Warning!", e.code);
    }
  }

  void activateTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (authState == AuthState.codeSent) {
        if (resendDuration <= 0) {
          timer.cancel();
          resendDuration = 120;
        }
        setState(() {
          resendDuration--;
        });
      } else {
        timer.cancel();
        resendDuration = 120;
      }
    });
  }
}
