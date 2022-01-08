import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  static FirebaseFirestore get database => FirebaseFirestore.instance;
}
