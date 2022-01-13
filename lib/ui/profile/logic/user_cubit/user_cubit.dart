import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:blood_donation/app/app_config/database.dart';
import 'package:blood_donation/data/model/my_user.dart';
import 'package:equatable/equatable.dart';


part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  late StreamSubscription _userStreamSubscription;
  final String uid;

  UserCubit(this.uid) : super(UserState(MyUser())) {
    _userStreamSubscription = Database.database
        .collection("users")
        .doc(this.uid)
        .snapshots()
        .listen((snapshot) {
      emit(UserState(MyUser.fromJson(snapshot.data() as Map<String, dynamic>)));
    });
  }

  @override
  Future<void> close() {
    _userStreamSubscription.cancel();
    return super.close();
  }
}