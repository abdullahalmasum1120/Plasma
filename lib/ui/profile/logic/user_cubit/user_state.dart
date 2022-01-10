part of 'user_cubit.dart';

class UserState extends Equatable {
  final MyUser myUser;

  UserState(this.myUser);

  @override
  List<Object?> get props => [myUser];
}
