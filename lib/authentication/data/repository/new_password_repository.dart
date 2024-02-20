import 'package:shopping_ecommerce_app/authentication/data/datasource/new_password_datasource.dart';
import 'package:shopping_ecommerce_app/authentication/domain/repository/base_new_password_repository.dart';

class NewPasswordRepository extends BaseNewPasswordRepository{
  final BaseNewPasswordDatasource baseNewPasswordDatasource;
  NewPasswordRepository(this.baseNewPasswordDatasource);
  @override
  Future<bool> setNewPassword(String email, String password) {
    // TODO: implement setNewPassword
    return baseNewPasswordDatasource.setNewPassword(email, password);
  }
}
