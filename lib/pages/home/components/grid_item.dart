// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:badges/badges.dart';
import 'package:blood_donation/components/constant/colors.dart';
import 'package:blood_donation/components/constant/size.dart';
import 'package:blood_donation/components/constant/styles.dart';
import 'package:blood_donation/data/model/grid_item.dart';
import 'package:flutter/material.dart';

class MyGridCard extends StatelessWidget {
  final BuildContext context;
  final Icon icon;
  final String label;
  final Widget widgetToNavigate;
  final String badgeText;
  final WidgetType widgetType;

  const MyGridCard({
    Key? key,
    required this.context,
    required this.icon,
    required this.label,
    required this.widgetToNavigate,
    required this.badgeText,
    required this.widgetType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: (widgetType == WidgetType.dialog)
          ? () {
              showDialog(
                  context: this.context,
                  barrierDismissible: false,
                  builder: (context) {
                    return widgetToNavigate;
                  });
            }
          : () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) {
                    return widgetToNavigate;
                  },
                ),
              );
            },
      child: new Card(
        elevation: 2,
        shape: new RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MySizes.defaultRadius / 2),
        ),
        child: Badge(
          shape: BadgeShape.square,
          borderRadius: BorderRadius.circular(MySizes.defaultRadius),
          position: BadgePosition(
            top: -4,
            end: -16,
          ),
          badgeContent: Text(
            badgeText,
            style: MyTextStyles(MyColors.white).badgeTextStyle,
          ),
          showBadge: badgeText.isNotEmpty,
          child: Container(
            padding: EdgeInsets.all(MySizes.defaultSpace / 2),
            child: new Column(
              children: [
                new Expanded(
                  flex: 3,
                  child: icon,
                ),
                new Expanded(
                  flex: 1,
                  child: new Text(
                    label,
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      color: MyColors.grey,
                      letterSpacing: 1.25,
                      fontWeight: FontWeight.bold,
                    ),
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
