// ignore_for_file: unnecessary_new, prefer_const_constructors
import 'package:blood_donation/components/filled_Button.dart';
import 'package:flutter/material.dart';

import 'filter_option.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isVisibleFilters = false;

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      child: new Scaffold(
        appBar: new AppBar(
          leading: new IconButton(
            onPressed: () {},
            icon: new Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          title: new Text(
            "Search",
            style: new TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            decoration: new BoxDecoration(
              color: Colors.white,
              boxShadow: [
                new BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: new Column(
              children: [
                new Container(
                  decoration: new BoxDecoration(
                    boxShadow: [
                      new BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: new Row(
                    children: [
                      new Expanded(
                        child: new TextFormField(
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search",
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: new Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      new Container(
                        color: new Color(0xFFFF2156),
                        child: new IconButton(
                          color: Colors.white,
                          onPressed: () {
                            setState(() {
                              isVisibleFilters
                                  ? isVisibleFilters = false
                                  : isVisibleFilters = true;
                            });
                          },
                          icon: new Icon(Icons.wc),
                        ),
                      ),
                    ],
                  ),
                ),
                new SizedBox(
                  height: 20,
                ),
                new Visibility(
                  visible: isVisibleFilters,
                  child: new Column(
                    children: [
                      new Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: new BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            new BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 10,
                              spreadRadius: 10,
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: new Text(
                          "Filters",
                          style: new TextStyle(
                            fontSize: 20,
                            letterSpacing: 1.25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      new SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        height: 300,
                        child: new SingleChildScrollView(
                          child: new Column(
                            children: [
                              new FilterOptions(
                                itemList: ["A+", "B+", "O+", "AB+"],
                                title: "Blood Type",
                              ),
                              new FilterOptions(
                                itemList: ["Dhaka", "Cumilla"],
                                title: "Location",
                              ),
                              new FilterOptions(
                                itemList: [
                                  "BLood bank name",
                                  "Blood bank name"
                                ],
                                title: "Blood Bank",
                              ),
                              new FilterOptions(
                                itemList: ["Name", "Name"],
                                title: "Donors",
                              ),
                              new SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      new MyFilledButton(
                        text: "Apply",
                        size: new Size(0, 0),
                        borderRadius: 50,
                        function: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
