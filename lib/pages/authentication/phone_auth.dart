// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:blood_donation/components/assentials/data_validator.dart';
import 'package:blood_donation/components/dialogs/loading.dart';
import 'package:blood_donation/components/filled_Button.dart';
import 'package:blood_donation/pages/authentication/verify_code.dart';
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
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final TextEditingController _phoneController = new TextEditingController();
  int? _forceResendingToken;

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
                  key: _formKey,
                  child: new TextFormField(
                    controller: _phoneController,
                    validator: (phone) {
                      if (DataValidator.isValidatePhone(phone!)) {
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
                      contentPadding: EdgeInsets.all(10),
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
                      prefixIconConstraints: new BoxConstraints(
                        maxWidth: 80,
                      ),
                    ),
                  ),
                ),
                new SizedBox(
                  height: 20,
                ),
                new MyFilledButton(
                  child: new Text(
                    "Get Code",
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
                      _authenticateUser(
                        phone: _phoneController.text,
                        context: context,
                      );
                      _phoneController.text= "";
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

  void _authenticateUser(
      {required String phone, required BuildContext context}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Loading();
      },
    );
    FirebaseAuth.instance.verifyPhoneNumber(
      timeout: Duration(minutes: 2),
      forceResendingToken: _forceResendingToken,
      phoneNumber: "+88$phone",
      verificationCompleted: (PhoneAuthCredential _phoneAuthCredential) {
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
          });
        } on FirebaseAuthException catch (e) {
          Navigator.pop(context);
          print(e.code);
        }
      },
      verificationFailed: (FirebaseAuthException _firebaseAuthException) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          new SnackBar(
            duration: Duration(seconds: 5),
            content: Text(_firebaseAuthException.code),
          ),
        );
      },
      codeSent: (String _verificationId, int? _forceResendingToken) {
        this._forceResendingToken = _forceResendingToken;
        Navigator.pop(context);

        Navigator.push(
          context,
          new MaterialPageRoute(
            builder: (context) {
              return new CodeVerify(
                phoneNo: phone,
                verificationId: _verificationId,
                token: _forceResendingToken,
              );
            },
          ),
        );

      },
      codeAutoRetrievalTimeout: (String _verificationId) {
        print("__________time out");
      },
    );
  }
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