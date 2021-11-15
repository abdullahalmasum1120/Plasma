// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'dart:async';

import 'package:blood_donation/components/assentials/data_validator.dart';
import 'package:blood_donation/components/dialogs/loading.dart';
import 'package:blood_donation/components/filled_Button.dart';
import 'package:blood_donation/pages/home/home.dart';
import 'package:blood_donation/pages/update_user_info/user_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({Key? key}) : super(key: key);

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  bool isCodeVerifyingState = false;
  bool isLoading = false;
  String _verificationId = "default";
  final GlobalKey<FormState> _phoneFormKey = new GlobalKey<FormState>();
  final TextEditingController _phoneController = new TextEditingController();
  final GlobalKey<FormState> _codeFormKey = GlobalKey<FormState>();
  final TextEditingController _codeController = new TextEditingController();
  int? _forceResendingToken;

  int resendCounter = 120;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _phoneController.dispose();
    _codeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusScopeNode());
      },
      child: new SafeArea(
          child: new Scaffold(
        body: new Center(
          child: new SingleChildScrollView(
            child: Padding(
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
                            onTap: (isCodeVerifyingState)
                                ? null
                                : () {
                                    if (_phoneFormKey.currentState!
                                        .validate()) {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      FirebaseAuth.instance.verifyPhoneNumber(
                                        forceResendingToken:
                                            _forceResendingToken,
                                        timeout: Duration(minutes: 2),
                                        phoneNumber:
                                            "+88${_phoneController.text.trim()}",
                                        verificationCompleted:
                                            (PhoneAuthCredential
                                                _phoneAuthCredential) {
                                          setState(() {
                                            isCodeVerifyingState = false;
                                            isLoading = false;
                                          });
                                          showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (context) {
                                              return Loading();
                                            },
                                          );
                                          signInAndNavigate(
                                            phoneAuthCredential:
                                                _phoneAuthCredential,
                                            context: context,
                                          );
                                        },
                                        verificationFailed:
                                            (FirebaseAuthException
                                                _firebaseAuthException) {
                                          setState(() {
                                            isCodeVerifyingState = false;
                                            isLoading = false;
                                          });
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            new SnackBar(
                                              duration: Duration(seconds: 5),
                                              content: Text(
                                                  _firebaseAuthException.code),
                                            ),
                                          );
                                        },
                                        codeSent: (String _verificationId,
                                            int? _forceResendingToken) {
                                          this._verificationId =
                                              _verificationId;
                                          this._forceResendingToken =
                                              _forceResendingToken;
                                          setState(() {
                                            isCodeVerifyingState = true;
                                            isLoading = false;
                                          });
                                          Timer.periodic(Duration(seconds: 1),
                                              (timer) {
                                            if (isCodeVerifyingState) {
                                              if (resendCounter <= 0) {
                                                timer.cancel();
                                                resendCounter = 120;
                                              }
                                              setState(() {
                                                resendCounter--;
                                              });
                                            } else {
                                              timer.cancel();
                                              resendCounter = 120;
                                            }
                                          });
                                        },
                                        codeAutoRetrievalTimeout:
                                            (String _verificationId) {
                                          setState(() {
                                            isCodeVerifyingState = false;
                                            isLoading = false;
                                          });
                                        },
                                      );
                                    }
                                  },
                            child: isLoading
                                ? CircularProgressIndicator(
                                  color: new Color(0xFFFF2156),
                                )
                                : new Text(
                                    isCodeVerifyingState
                                        ? "$resendCounter s"
                                        : "Get Code",
                                    style: new TextStyle(
                                      color: (isCodeVerifyingState)
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
                      ),
                    ),
                  ),
                  isCodeVerifyingState
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
                    function: isCodeVerifyingState
                        ? () {
                            if (_codeFormKey.currentState!.validate()) {
                              if (_verificationId != "default") {
                                setState(() {
                                  isCodeVerifyingState = false;
                                });
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return new Loading();
                                    });
                                signInAndNavigate(
                                  phoneAuthCredential:
                                      PhoneAuthProvider.credential(
                                    verificationId: _verificationId,
                                    smsCode: _codeController.text.trim(),
                                  ),
                                  context: context,
                                );
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
      )),
    );
  }
}

Future<bool> _hasUserData(User? user) async {
  final DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection("users").doc(user!.uid).get();
  if (snapshot.data() != null && snapshot.data()!.isNotEmpty) {
    return true;
  }
  return false;
}

void signInAndNavigate({
  required PhoneAuthCredential phoneAuthCredential,
  required BuildContext context,
}) {
  FirebaseAuth.instance
      .signInWithCredential(phoneAuthCredential)
      .then((value) => {
            if (value.user != null)
              {
                _hasUserData(value.user).then((value) => {
                      Navigator.pop(context),
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
      .catchError((error) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      new SnackBar(
        duration: Duration(seconds: 5),
        content: Text(error.code),
      ),
    );
  });
}
