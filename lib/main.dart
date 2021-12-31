import 'package:blood_donation/data/repositories/auth_repository.dart';
import 'package:blood_donation/pages/authentication/authentication.dart';
import 'package:blood_donation/pages/home/home.dart';
import 'package:blood_donation/pages/update_user_info/update_user_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'data/blocs/app_bloc/app_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final AuthRepository _authRepository = AuthRepository(FirebaseAuth.instance);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppBloc(_authRepository),
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
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          if (state == AppState.authenticated()) {
            return HomePage();
          }
          if (state == AppState.updateUserData()) {
            return UpdateUserDataPage();
          }
          return AuthenticationPage();
        },
      ),
    );
  }
}
