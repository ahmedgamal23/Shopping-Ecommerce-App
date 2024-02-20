import 'package:shopping_ecommerce_app/authentication/domain/repository/base_check_email_repository.dart';

abstract class BaseCheckEmailUseCase{
  Future<bool> execute(String email);
}

class CheckEmailUseCase extends BaseCheckEmailUseCase{
  final BaseCheckEmailRepository baseCheckEmailRepository;
  CheckEmailUseCase(this.baseCheckEmailRepository);

  @override
  Future<bool> execute(String email) {
    // TODO: implement checkEmail
    return baseCheckEmailRepository.checkEmail(email);
  }
}
