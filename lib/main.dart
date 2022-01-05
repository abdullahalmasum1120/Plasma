import 'package:blood_donation/logic/blocs/app_bloc/app_bloc.dart';
import 'package:blood_donation/ui/authentication/authentication.dart';
import 'package:blood_donation/ui/home/home.dart';
import 'package:blood_donation/ui/update_user_info/update_user_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'logic/blocs/auth_bloc/auth_bloc.dart';
import 'logic/obserber/observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final Observer _blocObserver = Observer();
  final AuthBloc _authBloc = AuthBloc(FirebaseAuth.instance);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppBloc(_authBloc)..add(AppStartedEvent()),
        ),
        BlocProvider(create: (context) => _authBloc),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          if (state is AppAuthenticatedState) {
            return HomePage();
          }
          if (state is AppUserDataUploadState) {
            return UpdateUserDataPage();
          }
          if (state is AppExceptionState) {
            return Center(child: Text("Something went wrong"));
          }
          return AuthenticationPage();
        },
      ),
    );
  }
}
