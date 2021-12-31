import 'package:blood_donation/data/logic/blocs/auth/auth_bloc.dart';
import 'package:blood_donation/data/repositories/auth_repository.dart';
import 'package:blood_donation/pages/authentication/authentication.dart';
import 'package:blood_donation/pages/home/home.dart';
import 'package:blood_donation/pages/update_user_info/update_user_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  AuthRepository _authRepository = AuthRepository(_firebaseAuth);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AuthBloc(_authRepository)..add(AppStartedEvent()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            home: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthenticatedState) {
                  return HomePage();
                }
                if (state is UserInfoUpdateState) {
                  return UpdateUserInfoPage();
                }
                return AuthPage();
              },
            ),
          );
        }
        //TODO: debug necessity
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
