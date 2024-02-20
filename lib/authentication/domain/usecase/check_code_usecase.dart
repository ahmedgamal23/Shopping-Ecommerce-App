import 'package:shopping_ecommerce_app/authentication/domain/repository/base_check_code_repository.dart';

abstract class BaseCheckCodeUseCase{
  Future<bool> execute(int code);
}

class CheckCodeUseCase extends BaseCheckCodeUseCase{
  final BaseCheckCodeRepository baseCheckCodeRepository;
  CheckCodeUseCase(this.baseCheckCodeRepository);
  @override
  Future<bool> execute(int code) {
    // TODO: implement execute
    return baseCheckCodeRepository.checkCode(code);
  }
}

