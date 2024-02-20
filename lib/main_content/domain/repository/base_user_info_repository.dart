import '../entity/user.dart';

abstract class BaseUserInfoRepository{
  Future<User> getUserInfo();
}
