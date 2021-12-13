import 'package:flutter/material.dart';

enum WidgetType {
  dialog,
  screen,
}

class GridData {
  Icon icon;
  String label;
  Widget widget;
  String badgeText;
  WidgetType widgetType;

  GridData({
    required this.icon,
    required this.label,
    required this.widget,
    required this.badgeText,
    this.widgetType = WidgetType.screen,
  });
}
