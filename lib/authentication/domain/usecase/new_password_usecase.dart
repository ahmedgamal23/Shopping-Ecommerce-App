import '../repository/base_new_password_repository.dart';

abstract class BaseNewPasswordUseCase{
  Future<bool> execute(String email, String password);
}

class NewPasswordUseCase extends BaseNewPasswordUseCase{
  final BaseNewPasswordRepository baseNewPasswordRepository;
  NewPasswordUseCase(this.baseNewPasswordRepository);
  @override
  Future<bool> execute(String email, String password) {
    // TODO: implement execute
    return baseNewPasswordRepository.setNewPassword(email, password);
  }
}

