// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:blood_donation/components/assentials/data_validator.dart';
import 'package:blood_donation/components/dialogs/loading.dart';
import 'package:blood_donation/components/dialogs/request_succesful.dart';
import 'package:blood_donation/components/filled_Button.dart';
import 'package:blood_donation/components/outlined_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uuid/uuid.dart';

class BloodRequestDialog extends StatefulWidget {
  const BloodRequestDialog({Key? key}) : super(key: key);

  @override
  State<BloodRequestDialog> createState() => _BloodRequestDialogState();
}

class _BloodRequestDialogState extends State<BloodRequestDialog> {
  final TextEditingController _locationController = new TextEditingController();
  final TextEditingController _hospitalController = new TextEditingController();
  final TextEditingController _mobileController = new TextEditingController();
  final TextEditingController _noteController = new TextEditingController();

  final GlobalKey<FormState> _myFormKey = GlobalKey<FormState>();
  String _selectedBloodGroup = "default";

  @override
  void dispose() {
    // TODO: implement dispose
    _locationController.dispose();
    _hospitalController.dispose();
    _mobileController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
      child: new Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(
          horizontal: 10,
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
                child: new Padding(
                  padding: const EdgeInsets.all(10),
                  child: new Form(
                    key: _myFormKey,
                    child: new Column(
                      children: [
                        new SizedBox(
                          height: 40,
                        ),
                        new Card(
                          elevation: 2,
                          child: new Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: new TextFormField(
                              validator: (location) {
                                if (location!.length > 10) {
                                  return null;
                                }
                                return "Please describe location specificly";
                              },
                              controller: _locationController,
                              keyboardType: TextInputType.text,
                              decoration: new InputDecoration(
                                border: InputBorder.none,
                                hintText: "location",
                                fillColor: Colors.white,
                                filled: true,
                                prefixIcon: new Icon(
                                  Icons.location_city_outlined,
                                  color: new Color(0xFFFF2156),
                                ),
                              ),
                            ),
                          ),
                        ),
                        new SizedBox(
                          height: 10,
                        ),
                        new Card(
                          elevation: 2,
                          child: new Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: new TextFormField(
                              validator: (hospital) {
                                if (hospital!.length > 5) {
                                  return null;
                                }
                                return "Hospital Name must be greater then 5 charechter";
                              },
                              controller: _hospitalController,
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
                        ),
                        new SizedBox(
                          height: 10,
                        ),
                        new Card(
                          elevation: 2,
                          child: new Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: new DropdownButtonFormField<String>(
                              validator: (bloodGroup) {
                                if (bloodGroup != null) {
                                  return null;
                                }
                                return "Please Select Your Blood Group";
                              },
                              decoration: new InputDecoration(
                                border: InputBorder.none,
                                fillColor: Colors.white,
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
                          ),
                        ),
                        new SizedBox(
                          height: 10,
                        ),
                        new Card(
                          elevation: 2,
                          child: new Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: new TextFormField(
                              validator: (mobile) {
                                if (DataValidator.isValidatePhone(mobile!)) {
                                  return null;
                                }
                                return "Invalid Phone Number";
                              },
                              controller: _mobileController,
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
                        ),
                        new SizedBox(
                          height: 10,
                        ),
                        new Card(
                          elevation: 2,
                          child: new TextFormField(
                            controller: _noteController,
                            keyboardType: TextInputType.multiline,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: new InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(20),
                              hintText: "Add a note (optional)",
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
                                child: new Text(
                                  "Add",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    letterSpacing: 1.2,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                size: new Size(0, 0),
                                function: () {
                                  if (_myFormKey.currentState!.validate()) {
                                    addRequest(
                                      location: _locationController.text.trim(),
                                      hospitalName:
                                          _hospitalController.text.trim(),
                                      bloodGroup: _selectedBloodGroup,
                                      phone: _mobileController.text.trim(),
                                      note: (_noteController.text
                                              .trim()
                                              .isNotEmpty)
                                          ? _noteController.text.trim()
                                          : null,
                                      time: DateFormat('kk:mm')
                                          .format(DateTime.now()),
                                      date: DateFormat('yyyy-MM-dd')
                                          .format(DateTime.now()),
                                      id: Uuid().v1(),
                                    );
                                  }
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
      ),
    );
  }

  void addRequest({
    required String location,
    required String hospitalName,
    required String bloodGroup,
    required String phone,
    required String? note,
    required String time,
    required String date,
    required String id,
  }) async {
    showDialog(
        context: context,
        builder: (context) {
          return new Loading();
        });
    Map<String, dynamic> requestInfo = {
      "username": FirebaseAuth.instance.currentUser!.displayName,
      "hospital": hospitalName,
      "bloodGroup": bloodGroup,
      "location": location,
      "phone": phone,
      "requestedTime": time,
      "requestedDate": date,
      "note": note,
      "id": id,
      "uid": FirebaseAuth.instance.currentUser!.uid,
    };
    Map<String, dynamic> sentRequest = {
      "uid": null,
      "status": null,
      "docId": id,
    };

    try {
      await FirebaseFirestore.instance
          .collection("requests")
          .doc(id)
          .set(requestInfo)
          .then((value) {
        Navigator.pop(context);
      });
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("sentRequests")
          .doc(id)
          .set(sentRequest);
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) {
            return new SuccessfulDialog();
          });
    } on FirebaseException catch (e) {
      Navigator.pop(context);
      Get.snackbar("Warning!", e.code);
    }
  }
}
