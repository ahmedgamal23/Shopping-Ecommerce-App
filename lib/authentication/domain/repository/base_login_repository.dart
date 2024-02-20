abstract class BaseLoginRepository{
  Future<bool> verifyUsernamePassword(String username, String password, bool rememberMe);
}
