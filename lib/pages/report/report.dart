// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:blood_donation/components/filled_Button.dart';
import 'package:flutter/material.dart';

class Report extends StatelessWidget {
  final Map reportData;
  const Report({
    Key? key,
    required this.reportData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        centerTitle: true,
        titleTextStyle: new TextStyle(
          color: Colors.black,
          fontSize: 24,
        ),
        title: new Text("Report"),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: new IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: new Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: new SingleChildScrollView(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              new ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    new Icon(
                      Icons.location_on,
                      color: new Color(0xFFFF2156),
                    ),
                    new Text("Research center"),
                  ],
                ),
                subtitle: new Text(
                  reportData["center"],
                  textAlign: TextAlign.center,
                ),
              ),
              new Image.asset(
                "assets/images/report.png",
                height: 250,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
              new SizedBox(
                height: 20,
              ),
              new Table(
                children: [
                  new TableRow(
                    children: [
                      new TableCell(
                        child: new Card(
                          elevation: 5,
                          child: Container(
                            alignment: Alignment.center,
                            child: new ListTile(
                              title: new Text(
                                reportData["glucose"],
                                textAlign: TextAlign.center,
                                style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: new Text(
                                "Glucose",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                      new TableCell(
                        child: new Card(
                          elevation: 5,
                          child: Container(
                            alignment: Alignment.center,
                            child: new ListTile(
                              title: new Text(
                                reportData["cholesterol"],
                                textAlign: TextAlign.center,
                                style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: new Text(
                                "Cholesterol",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                      new TableCell(
                        child: new Card(
                          elevation: 5,
                          child: Container(
                            alignment: Alignment.center,
                            child: new ListTile(
                              title: new Text(
                                reportData["bilirubin"],
                                textAlign: TextAlign.center,
                                style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: new Text(
                                "Bilirubin",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  new TableRow(
                    children: [
                      new TableCell(
                        child: new Card(
                          elevation: 5,
                          child: Container(
                            alignment: Alignment.center,
                            child: new ListTile(
                              title: new Text(
                                reportData["rbc"],
                                textAlign: TextAlign.center,
                                style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: new Text(
                                "RBC",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                      new TableCell(
                        child: new Card(
                          elevation: 5,
                          child: Container(
                            alignment: Alignment.center,
                            child: new ListTile(
                              title: new Text(
                                reportData["mcv"],
                                textAlign: TextAlign.center,
                                style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: new Text(
                                "MCV",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                      new TableCell(
                        child: new Card(
                          elevation: 5,
                          child: Container(
                            alignment: Alignment.center,
                            child: new ListTile(
                              title: new Text(
                                reportData["platelets"],
                                textAlign: TextAlign.center,
                                style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: new Text(
                                "Platelets",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              new SizedBox(
                height: 40,
              ),
              new MyFilledButton(
                child: new Text(
                  "My Report",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                size: new Size(0, 0),
                borderRadius: 50,
                function: () {},
              ),
              new SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
