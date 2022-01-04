import 'package:blood_donation/data/model/my_user.dart';

abstract class UserRepoInterface{
  Future<bool> updateUserInfo(MyUser user);
  Future<MyUser> get currentUser;
}