import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider {
  final FirebaseAuth firebaseAuth;

  AuthProvider({
    required this.firebaseAuth,
  });

  Stream<User?> get authState => firebaseAuth.authStateChanges();
}
