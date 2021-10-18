import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider {
  final FirebaseAuth firebaseAuth;

  AuthProvider({
    required this.firebaseAuth,
  });

  get authState => firebaseAuth.authStateChanges();
}
