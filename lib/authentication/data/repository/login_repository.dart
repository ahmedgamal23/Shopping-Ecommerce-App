import 'package:shopping_ecommerce_app/authentication/data/datasource/login_datasource.dart';
import 'package:shopping_ecommerce_app/authentication/domain/repository/base_login_repository.dart';

class LoginRepository extends BaseLoginRepository{
  final BaseLoginDatasource baseLoginDatasource;
  LoginRepository(this.baseLoginDatasource);

  @override
  Future<bool> verifyUsernamePassword(String username, String password, bool rememberMe) {
    // TODO: implement verifyUsernamePassword
    return baseLoginDatasource.verifyUsernamePassword(username, password, rememberMe);
  }
}
