// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:blood_donation/components/assentials/data_validator.dart';
import 'package:blood_donation/components/filled_Button.dart';
import 'package:blood_donation/pages/login/login.dart';
import 'package:blood_donation/pages/register/account_verify/verify.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  DatabaseReference databaseReference =
      FirebaseDatabase().reference().child("users");

  Color _eyeColor = Colors.grey;
  bool _isPassHidden = true;
  //controlers
  TextEditingController usernameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController mobileController = new TextEditingController();
  TextEditingController bloodGroupController = new TextEditingController();
  TextEditingController locationController = new TextEditingController();
  //keys
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      child: new Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child: new SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: new Form(
                key: _formKey,
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                        return "Pleae Enter a valid Username";
                      },
                      keyboardType: TextInputType.name,
                      controller: usernameController,
                      decoration: new InputDecoration(
                        border: InputBorder.none,
                        hintText: "Username",
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
                        return "Pleae Enter a valid Email";
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
                      validator: (password) {
                        if (DataValidator.isValidatePassword(password!)) {
                          return null;
                        }
                        return "Pleae Enter a valid Password";
                      },
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: _isPassHidden,
                      decoration: new InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password",
                        fillColor: new Color(0xFFF8F8F8),
                        filled: true,
                        prefixIcon: new Icon(
                          Icons.lock_outline,
                          color: new Color(0xFFFF2156),
                        ),
                        suffixIcon: new IconButton(
                          color: _eyeColor,
                          onPressed: () {
                            setState(() {
                              if (_isPassHidden) {
                                _eyeColor = new Color(0xFFFF2156);
                                _isPassHidden = false;
                              } else {
                                _eyeColor = Colors.grey;
                                _isPassHidden = true;
                              }
                            });
                          },
                          icon: new Icon(Icons.remove_red_eye),
                        ),
                      ),
                    ),
                    new SizedBox(
                      height: 20,
                    ),
                    new TextFormField(
                      validator: (mobile) {
                        if (DataValidator.isValidatePhone(mobile!)) {
                          return null;
                        }
                        return "Pleae Enter a valid Mobile";
                      },
                      controller: mobileController,
                      keyboardType: TextInputType.phone,
                      decoration: new InputDecoration(
                        border: InputBorder.none,
                        hintText: "Mobile no",
                        fillColor: new Color(0xFFF8F8F8),
                        filled: true,
                        prefixIcon: new Icon(
                          Icons.call_outlined,
                          color: new Color(0xFFFF2156),
                        ),
                      ),
                    ),
                    new SizedBox(
                      height: 20,
                    ),
                    new TextFormField(
                      validator: (bloodGroup) {
                        if (DataValidator.isValidateBloodGroup(bloodGroup!)) {
                          return null;
                        }
                        return "Pleae Enter a valid Blood Group";
                      },
                      controller: bloodGroupController,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.characters,
                      maxLength: 3,
                      decoration: new InputDecoration(
                        border: InputBorder.none,
                        hintText: "Blood group",
                        fillColor: new Color(0xFFF8F8F8),
                        filled: true,
                        prefixIcon: new Icon(
                          Icons.bloodtype_outlined,
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
                        return "Pleae Enter a valid Username";
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
                      height: 50,
                    ),
                    new MyFilledButton(
                      text: "REGISTER",
                      size: new Size(double.infinity, 0),
                      borderRadius: 10,
                      function: () {
                        if (_formKey.currentState!.validate()) {
                          _registerUser(
                            usernameController.text.trim(),
                            emailController.text.trim(),
                            passwordController.text.trim(),
                            mobileController.text.trim(),
                            bloodGroupController.text.trim(),
                            locationController.text.trim(),
                            DateFormat('yyyy-MM-dd – kk:mm')
                                .format(DateTime.now()),
                          );
                        }
                      },
                    ),
                    new SizedBox(
                      height: 40,
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        new Text(
                          "Already have an account? ",
                          style: new TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        new GestureDetector(
                          child: new Text(
                            "Log In",
                            style: new TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: new Color(0xFFFF2156),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              new MaterialPageRoute(
                                builder: (context) {
                                  return new LogIn();
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    new SizedBox(
                      height: 20,
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

  void _registerUser(
    String username,
    String email,
    String password,
    String mobile,
    String bloodGroup,
    String location,
    String time,
  ) {
    //Sign in with firebase then update UI
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) {
          return new Verify();
        },
      ),
    );
  }
}
