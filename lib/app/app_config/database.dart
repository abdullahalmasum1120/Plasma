import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Database {
  static FirebaseFirestore get database => FirebaseFirestore.instance;
  static FirebaseStorage get storage => FirebaseStorage.instance;
}
