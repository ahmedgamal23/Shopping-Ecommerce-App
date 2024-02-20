import 'package:shopping_ecommerce_app/authentication/data/datasource/resend_code_datasource.dart';
import 'package:shopping_ecommerce_app/authentication/domain/repository/base_resend_code_repository.dart';

class ResendCodeRepository extends BaseResendCodeRepository{
  final BaseResendCodeDatasource baseResendCodeDatasource;
  ResendCodeRepository(this.baseResendCodeDatasource);
  @override
  Future<bool> resendCode(String email) {
    // TODO: implement resendCode
    return baseResendCodeDatasource.resendCode(email);
  }
}
