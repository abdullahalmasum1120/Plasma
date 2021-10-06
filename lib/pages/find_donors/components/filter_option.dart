// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';

class FilterOptions extends StatefulWidget {
  final List<String> itemList;
  final String title;

  const FilterOptions({
    Key? key,
    required this.itemList,
    required this.title,
  }) : super(key: key);

  @override
  State<FilterOptions> createState() => _FilterOptionsState();
}

class _FilterOptionsState extends State<FilterOptions> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: [
        new Container(
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
          padding: EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: new Row(
            children: [
              new Expanded(
                child: new Text(
                  widget.title,
                  style: new TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.25,
                  ),
                ),
              ),
              new IconButton(
                onPressed: () {
                  setState(() {
                    isExpanded ? isExpanded = false : isExpanded = true;
                  });
                },
                icon: new Icon(Icons.arrow_drop_down),
              ),
            ],
          ),
        ),
        new Visibility(
          visible: isExpanded,
          child: new Container(
            padding: EdgeInsets.all(10),
            width: 200,
            height: 100,
            child: ListView.builder(
              itemCount: widget.itemList.length,
              itemBuilder: (context, index) {
                return new GestureDetector(
                  onTap: () {
                    //handle selection here
                  },
                  child: new Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    alignment: Alignment.center,
                    decoration: new BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: new Text(
                      widget.itemList[index],
                      style: new TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
