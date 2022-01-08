import 'package:blood_donation/data/model/my_user.dart';

abstract class UserRepoInterface {
  Future<void> updateUserInfo(MyUser user);

  Future<MyUser> get currentUserInfo;
}
