import 'package:shopping_ecommerce_app/authentication/domain/repository/base_create_new_account_repository.dart';

abstract class BaseCreateNewAccountUserCase{
  Future<bool> execute(String username, String email, String password, bool rememberMe);
}

class CreateNewAccountUseCase extends BaseCreateNewAccountUserCase{
  final BaseCreateNewAccountRepository baseCreateNewAccountRepository;
  CreateNewAccountUseCase({required this.baseCreateNewAccountRepository});
  @override
  Future<bool> execute(String username, String email, String password, bool rememberMe) {
    // TODO: implement execute to createNewAccount
    return baseCreateNewAccountRepository.createNewAccount(username, email, password, rememberMe);
  }

}
