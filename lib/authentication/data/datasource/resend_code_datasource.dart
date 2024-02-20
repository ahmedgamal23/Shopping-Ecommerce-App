import 'package:shopping_ecommerce_app/authentication/data/datasource/verification_code.dart';

abstract class BaseResendCodeDatasource{
  Future<bool> resendCode(String email);
}

class ResendCodeDatasource extends BaseResendCodeDatasource{
  @override
  Future<bool> resendCode(String email) async {
    // TODO: implement resendCode
    /// Send Verification code
    VerificationCode verificationCode = VerificationCode();
    if(await verificationCode.sendVerificationCode(email) == true){
      return true;
    }else{
      return false;
    }
  }
}
