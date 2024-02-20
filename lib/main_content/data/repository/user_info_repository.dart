import 'package:shopping_ecommerce_app/main_content/data/datasource/user_info_datasource.dart';
import 'package:shopping_ecommerce_app/main_content/domain/entity/user.dart';
import 'package:shopping_ecommerce_app/main_content/domain/repository/base_user_info_repository.dart';

class UserInfoRepository extends BaseUserInfoRepository{
  final BaseUserInfoDatasource baseUserInfoDatasource;
  UserInfoRepository(this.baseUserInfoDatasource);
  @override
  Future<User> getUserInfo() {
    // TODO: implement getUserInfo
    return baseUserInfoDatasource.getUserInfo();
  }
}