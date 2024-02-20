abstract class BaseCreateNewAccountRepository{
  Future<bool> createNewAccount(String username, String email, String password, bool rememberMe);
}
