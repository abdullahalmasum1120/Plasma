// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:blood_donation/components/assentials/data_validator.dart';
import 'package:blood_donation/components/filled_Button.dart';
import 'package:blood_donation/pages/home/home.dart';
import 'package:blood_donation/pages/login/forgot_password/forgot_password.dart';
import 'package:blood_donation/pages/register/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LogIn extends StatefulWidget {
  const LogIn({
    Key? key,
  }) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  Color _eyeColor = Colors.grey;
  bool _isPassHidden = true;
  //controllers
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

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
            child: new Padding(
              padding: const EdgeInsets.all(20),
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
                      height: 100,
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
                      obscureText: _isPassHidden,
                      keyboardType: TextInputType.text,
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
                      height: 40,
                    ),
                    new MyFilledButton(
                      text: "LOG IN",
                      size: new Size(double.infinity, 0),
                      borderRadius: 50,
                      function: () {
                        if (_formKey.currentState!.validate()) {
                          _signInUser(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          );
                        }
                      },
                    ),
                    new SizedBox(
                      height: 20,
                    ),
                    new GestureDetector(
                      child: new Text(
                        "Forgot Password?",
                        style: new TextStyle(
                          fontSize: 20,
                          color: new Color(0xFFFF2156),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                            builder: (context) {
                              return new ForgotPassword();
                            },
                          ),
                        );
                      },
                    ),
                    new SizedBox(
                      height: 40,
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        new Text(
                          "Don't have an account? ",
                          style: new TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        new GestureDetector(
                          child: new Text(
                            "Register Now",
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
                                  return new Register();
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

  void _signInUser(
    String email,
    String password,
  ) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        if (value.user != null) {
          Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (context) {
                return new MyHome();
              },
            ),
          );
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showDialog(
          context: context,
          builder: (context) {
            return new AlertDialog(
              title: new Text("Warning!"),
              content: new Text("No user found for that email."),
            );
          },
        );
      } else if (e.code == 'wrong-password') {
        showDialog(
          context: context,
          builder: (context) {
            return new AlertDialog(
              title: new Text("Warning!"),
              content: new Text("Wrong password provided for that user."),
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return new AlertDialog(
              title: new Text("Warning!"),
              content: new Text(e.code),
            );
          },
        );
      }
    }
  }
}
