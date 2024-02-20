
import 'package:shopping_ecommerce_app/main_content/domain/entity/user.dart';

abstract class UserInfoState{}

class UserInfoInitialization extends UserInfoState{}

class UserInfoSuccess extends UserInfoState{
  final User user;
  UserInfoSuccess(this.user);
}

class UserInfoLoading extends UserInfoState{}

class UserInfoFailure extends UserInfoState{}
