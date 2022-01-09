import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:blood_donation/app/app_config/database.dart';
import 'package:blood_donation/data/model/my_user.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  late StreamSubscription _userStreamSubscription;

  UserCubit() : super(UserState(MyUser())) {
    _userStreamSubscription = Database.database
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((snapshot) {
      emit(UserState(MyUser.fromJson(snapshot.data() as Map<String, dynamic>)));
    });
  }
}
