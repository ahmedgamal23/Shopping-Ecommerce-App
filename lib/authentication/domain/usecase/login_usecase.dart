import 'package:shopping_ecommerce_app/authentication/domain/repository/base_login_repository.dart';

abstract class BaseLoginUseCase{
  Future<bool> execute(String username, String password, bool rememberMe);
}

class LoginUseCase extends BaseLoginUseCase{
  final BaseLoginRepository baseLoginRepository;
  LoginUseCase(this.baseLoginRepository);

  @override
  Future<bool> execute(String username, String password, bool rememberMe) {
    return baseLoginRepository.verifyUsernamePassword(username, password, rememberMe);
  }
}
