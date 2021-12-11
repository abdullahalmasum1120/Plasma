// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:blood_donation/pages/assistant/asistant.dart';
import 'package:blood_donation/pages/find_donors/donors.dart';
import 'package:blood_donation/pages/home/components/blood_request_dialog.dart';
import 'package:blood_donation/pages/report/report.dart';

class GridsData {
  static final List<Map> _gridItems = [
    {
      "src": "assets/icons/find_donors.svg",
      "label": "Find Donors",
      "onTap": new Donors(),
    },
    {
      "src": "assets/icons/assistant.svg",
      "label": "Assistant",
      "onTap": new Assistant(),
    },
    {
      "src": "assets/icons/report.svg",
      "label": "Request",
      "onTap": new BloodRequestDialog(),
    },
    {
      "src": "assets/icons/campaign.svg",
      "label": "Campaign",
      "onTap": Donors(),
    },
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

  static List<Map> getGridItems() {
    return _gridItems;
  }

  static Map getReport() {
    return _report;
  }
}
