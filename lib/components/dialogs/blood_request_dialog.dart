// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:blood_donation/components/dialogs/request_succesful.dart';
import 'package:blood_donation/components/filled_Button.dart';
import 'package:blood_donation/components/outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BloodRequestDialog extends StatelessWidget {
  const BloodRequestDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 40,
      ),
      shape: new RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: new Stack(
        children: [
          new Container(
            margin: EdgeInsets.only(top: 40),
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: new SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: new Column(
                  children: [
                    new SizedBox(
                      height: 30,
                    ),
                    new Card(
                      elevation: 5,
                      child: new TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: new InputDecoration(
                          border: InputBorder.none,
                          hintText: "City",
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: new Icon(
                            Icons.location_city_outlined,
                            color: new Color(0xFFFF2156),
                          ),
                        ),
                      ),
                    ),
                    new SizedBox(
                      height: 10,
                    ),
                    new Card(
                      elevation: 5,
                      child: new TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: new InputDecoration(
                          border: InputBorder.none,
                          hintText: "Hospital",
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: new Icon(
                            Icons.local_hospital_outlined,
                            color: new Color(0xFFFF2156),
                          ),
                        ),
                      ),
                    ),
                    new SizedBox(
                      height: 10,
                    ),
                    new Card(
                      elevation: 5,
                      child: new TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: new InputDecoration(
                          border: InputBorder.none,
                          hintText: "Blood Type",
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: new Icon(
                            Icons.bloodtype_outlined,
                            color: new Color(0xFFFF2156),
                          ),
                        ),
                        maxLength: 3,
                      ),
                    ),
                    new SizedBox(
                      height: 10,
                    ),
                    new Card(
                      elevation: 5,
                      child: new TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: new InputDecoration(
                          border: InputBorder.none,
                          hintText: "Mobile",
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: new Icon(
                            Icons.call_outlined,
                            color: new Color(0xFFFF2156),
                          ),
                        ),
                      ),
                    ),
                    new SizedBox(
                      height: 10,
                    ),
                    new Card(
                      elevation: 5,
                      child: new TextFormField(
                        keyboardType: TextInputType.multiline,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: new InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(20),
                          hintText: "Add a note",
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: new Icon(
                            Icons.note_add_outlined,
                            color: new Color(0xFFFF2156),
                          ),
                        ),
                        maxLines: 3,
                      ),
                    ),
                    new SizedBox(
                      height: 20,
                    ),
                    new Padding(
                      padding: const EdgeInsets.all(10),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          new MyOutlinedButton(
                            text: "Cancel",
                            size: new Size(0, 0),
                            function: () {
                              Navigator.pop(context, "Cancel");
                            },
                            borderRadius: 10,
                          ),
                          new MyFilledButton(
                            text: "Add",
                            size: new Size(0, 0),
                            function: () {
                              Navigator.pop(context, "OK");
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return new SuccessfulDialog();
                                },
                              );
                            },
                            borderRadius: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          new Positioned(
            right: 10,
            left: 10,
            child: new CircleAvatar(
              radius: 40,
              backgroundColor: new Color(0xFFFF2156),
              child: new SvgPicture.asset(
                "assets/icons/drop_extended.svg",
                height: 40,
                width: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
