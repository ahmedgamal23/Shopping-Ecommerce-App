abstract class ResetPasswordEvent {}

class CheckEmailEvent extends ResetPasswordEvent{
  final String email;
  CheckEmailEvent({required this.email});
}

class CheckCodeEvent extends ResetPasswordEvent{
  final int code;
  CheckCodeEvent({required this.code});
}

class ResendCodeEvent extends ResetPasswordEvent{
  final String email;
  ResendCodeEvent({required this.email});
}

class NewPasswordEvent extends ResetPasswordEvent{
  final String email;
  final String password;
  NewPasswordEvent({required this.email, required this.password});
}
