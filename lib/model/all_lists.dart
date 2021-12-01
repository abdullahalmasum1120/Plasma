// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:blood_donation/pages/assistant/asistant.dart';
import 'package:blood_donation/pages/find_donors/donor_list.dart';
import 'package:blood_donation/pages/report/report.dart';

class DataLists {
  static final List<Map> _gridItems = [
    {
      "src": "assets/icons/find_donors.svg",
      "label": "Find Donors",
      "onTap": new DonorList(),
    },
    {
      "src": "assets/icons/assistant.svg",
      "label": "Assistant",
      "onTap": new Assistant(),
    },
    {
      "src": "assets/icons/report.svg",
      "label": "Report",
      "onTap": new Report(
        reportData: DataLists.getReport(),
      ),
    },
    {
      "src": "assets/icons/campaign.svg",
      "label": "Campaign",
      "onTap": DonorList(),
    },
  ];

  static final List<String> _imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  static final Map _report = {
    "center": "Dhaka Medical College",
    "glucose": "5 mmol/L",
    "cholesterol": "6.9 mmol/L",
    "bilirubin": "11 mmol/L",
    "rbc": "3.0 m/L",
    "mcv": "99 fl",
    "platelets": "270 bL",
  };

  static List<String> getImageList() {
    return _imgList;
  }

  static List<Map> getGridItems() {
    return _gridItems;
  }

  static Map getReport() {
    return _report;
  }
}
