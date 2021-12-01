import 'dart:async';
import 'package:blood_donation/components/assentials/data_validator.dart';
import 'package:blood_donation/components/constant/colors.dart';
import 'package:blood_donation/components/constant/size.dart';
import 'package:blood_donation/components/constant/styles.dart';
import 'package:blood_donation/components/dialogs/loading.dart';
import 'package:blood_donation/components/filled_Button.dart';
import 'package:blood_donation/pages/home/home.dart';
import 'package:blood_donation/pages/update_user_info/update_user_info.dart';
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
  //keys
  final GlobalKey<FormState> _codeFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _phoneFormKey = GlobalKey<FormState>();

  //controllers
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  //variables
  int? _forceResendingToken;
  int resendDuration = 2 * 60; //2 minutes
  AuthState authState = AuthState.idle;
  late Timer _timer;
  late String _verificationId;

  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();
    _timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, //override system back button
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusScopeNode());
        },
        child: Scaffold(
          backgroundColor: MyColors.white,
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(MySizes.defaultSpace),
                child: Column(
                  children: [
                    const SizedBox(
                      height: MySizes.defaultSpace * 1.5,
                    ),
                    Image.asset(
                      "assets/images/phone_auth.png",
                      scale: context.height * 0.01,
                    ),
                    const SizedBox(
                      height: MySizes.defaultSpace * 2,
                    ),
                    Text(
                      "Verify your phone",
                      style: MyTextStyles(MyColors.primary).largeTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: MySizes.defaultSpace,
                    ),
                    Text(
                      "We ${(authState == AuthState.codeSent) ? "have sent" : "will send"} you a 6-digits verification code to this number",
                      style: MyTextStyles(MyColors.black).defaultTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: MySizes.defaultSpace,
                    ),
                    Form(
                      key: _phoneFormKey,
                      child: TextFormField(
                        controller: _phoneController,
                        validator: (phone) {
                          if (DataValidator.isValidatePhone(phone!.trim())) {
                            return null;
                          }
                          return "Please provide a valid Phone number";
                        },
                        keyboardType: TextInputType.phone,
                        maxLength: 11,
                        style: MyTextStyles(MyColors.black).buttonTextStyle,
                        decoration: InputDecoration(
                          fillColor: MyColors.textFieldBackground,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(MySizes.defaultRadius),
                          ),
                          hintText: "Phone No",
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: MySizes.defaultSpace,
                          ),
                          prefixIcon: const Padding(
                            padding: EdgeInsets.only(
                              left: MySizes.defaultSpace,
                              right: MySizes.defaultSpace * 0.5,
                            ),
                            child: Icon(
                              Icons.call_rounded,
                              color: MyColors.primary,
                            ),
                          ),
                          suffix: Material(
                            child: InkWell(
                              onTap: (authState != AuthState.idle)
                                  ? null
                                  : () {
                                      //Clickable when authState is Idle
                                      if (_phoneFormKey.currentState!
                                          .validate()) {
                                        setState(() {
                                          authState = AuthState.sendingCode;
                                        });

                                        verifyPhoneNo(); //send verification code
                                      }
                                    },
                              child: (authState == AuthState.sendingCode)
                                  ? Text(
                                      "Sending...",
                                      style: MyTextStyles(MyColors.grey)
                                          .defaultTextStyle,
                                    )
                                  : Text(
                                      (authState == AuthState.codeSent)
                                          ? "$resendDuration s"
                                          //then authState is idle
                                          : "Get Code",
                                      style: MyTextStyles(
                                              (authState == AuthState.codeSent)
                                                  ? MyColors.grey
                                                  : MyColors.primary)
                                          .defaultTextStyle,
                                    ),
                            ),
                          ),
                        ),
                        readOnly: (authState == AuthState.codeSent),
                      ),
                    ),
                    (authState == AuthState.codeSent)
                        ? Form(
                            key: _codeFormKey,
                            child: TextFormField(
                              controller: _codeController,
                              validator: (code) {
                                if (DataValidator.isValidateCode(code!)) {
                                  return null;
                                }
                                return "Invalid Code";
                              },
                              keyboardType: TextInputType.number,
                              maxLength: 6,
                              style:
                                  MyTextStyles(MyColors.black).buttonTextStyle,
                              decoration: InputDecoration(
                                fillColor: MyColors.textFieldBackground,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      MySizes.defaultRadius),
                                ),
                                hintText: "6-digit Verification Code",
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: MySizes.defaultSpace,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    const SizedBox(
                      height: MySizes.defaultSpace,
                    ),
                    MyFilledButton(
                      child: Text(
                        "Confirm",
                        style: MyTextStyles(MyColors.white).buttonTextStyle,
                      ),
                      size: MySizes.maxButtonSize,
                      function: (authState == AuthState.codeSent)
                          ? () async {
                              if (_codeFormKey.currentState!.validate()) {
                                if (_verificationId.isNotEmpty) {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return const Loading();
                                      });

                                  signIn(_verificationId); //signing in
                                } else {
                                  Get.snackbar("Warning!",
                                      "Something went wrong, Try again after some time.");
                                }
                              }
                            }
                          : null,
                      borderRadius: MySizes.defaultRadius,
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

  void verifyPhoneNo() {
    FirebaseAuth.instance.verifyPhoneNumber(
      forceResendingToken: _forceResendingToken,
      timeout: const Duration(minutes: 2),
      phoneNumber: "+88${_phoneController.text.trim()}",
      verificationCompleted: (PhoneAuthCredential _phoneAuthCredential) async {
        // TODO: implement auto signIn();
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

  void signIn(String _verificationId) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: _codeController.text.trim(),
      ));
      //navigating to desired page after signIn
      if (userCredential.user != null) {
        try {
          DocumentSnapshot<Map<String, dynamic>> snapshot =
              await FirebaseFirestore.instance
                  .collection("users")
                  .doc(userCredential.user!.uid)
                  .get();
          if (snapshot.data() != null && snapshot.data()!.isNotEmpty) {
            Navigator.pop(context);
            Get.offAll(() => const Home());
          } else {
            Get.offAll(() => const UpdateUserInfo());
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
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
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
