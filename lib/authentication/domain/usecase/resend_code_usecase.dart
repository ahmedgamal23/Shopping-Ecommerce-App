import '../repository/base_resend_code_repository.dart';

abstract class BaseResendCodeUseCase{
  Future<bool> execute(String email);
}

class ResendCodeUseCase extends BaseResendCodeUseCase{
  final BaseResendCodeRepository baseResendCodeRepository;
  ResendCodeUseCase(this.baseResendCodeRepository);
  @override
  Future<bool> execute(String email) {
    // TODO: implement execute
    return baseResendCodeRepository.resendCode(email);
  }
}

