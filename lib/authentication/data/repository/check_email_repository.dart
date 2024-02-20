import 'package:shopping_ecommerce_app/authentication/data/datasource/check_email_datasource.dart';
import 'package:shopping_ecommerce_app/authentication/domain/repository/base_check_email_repository.dart';

class CheckEmailRepository extends BaseCheckEmailRepository{
  final BaseCheckEmailDatasource baseCheckEmailDatasource;
  CheckEmailRepository(this.baseCheckEmailDatasource);
  @override
  Future<bool> checkEmail(String email) {
    // TODO: implement checkEmail
    return baseCheckEmailDatasource.checkEmail(email);
  }
}