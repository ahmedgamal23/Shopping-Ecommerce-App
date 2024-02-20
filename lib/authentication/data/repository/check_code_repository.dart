import 'package:shopping_ecommerce_app/authentication/domain/repository/base_check_code_repository.dart';
import '../datasource/check_code_datasource.dart';

class CheckCodeRepository extends BaseCheckCodeRepository{
  final BaseCheckCodeDatasource baseCheckCodeDatasource;
  CheckCodeRepository(this.baseCheckCodeDatasource);

  @override
  Future<bool> checkCode(int code) {
    // TODO: implement checkCode
    return baseCheckCodeDatasource.checkCode(code);
  }
}
