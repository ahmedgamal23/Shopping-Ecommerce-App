abstract class BaseNewPasswordRepository{
  Future<bool> setNewPassword(String email, String password);
}
