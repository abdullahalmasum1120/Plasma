part of 'user_cubit.dart';

class UserState extends Equatable {
  final MyUser _myUser;

  const UserState(this._myUser);

  @override
  List<Object?> get props => [_myUser];
}
