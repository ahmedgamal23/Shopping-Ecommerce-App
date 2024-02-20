import 'package:shopping_ecommerce_app/main_content/domain/repository/base_user_info_repository.dart';

import '../entity/user.dart';

abstract class BaseUserInfoUseCase{
  Future<User> execute();
}

class UserInfoUseCase extends BaseUserInfoUseCase{
  final BaseUserInfoRepository baseUserInfoRepository;
  UserInfoUseCase(this.baseUserInfoRepository);
  @override
  Future<User> execute() {
    // TODO: implement execute
    return baseUserInfoRepository.getUserInfo();
  }
}
