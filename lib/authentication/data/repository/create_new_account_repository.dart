import 'package:shopping_ecommerce_app/authentication/data/datasource/create_new_account_datasource.dart';
import 'package:shopping_ecommerce_app/authentication/domain/repository/base_create_new_account_repository.dart';

class CreateNewAccountRepository extends BaseCreateNewAccountRepository{
  final BaseCreateNewAccountDataSource baseCreateNewAccountDataSource;
  CreateNewAccountRepository({required this.baseCreateNewAccountDataSource});
  @override
  Future<bool> createNewAccount(String username, String email, String password, bool rememberMe) {
    // TODO: implement createNewAccount
    return baseCreateNewAccountDataSource.createNewAccount(username, email, password, rememberMe);
  }

}