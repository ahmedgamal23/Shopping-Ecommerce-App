abstract class AuthenticationEvent {}

class SignInWithFacebookEvent extends AuthenticationEvent {}

class SignInWithGoogleEvent extends AuthenticationEvent {}

class CreateNewAccountEvent extends AuthenticationEvent{
  final String userName;
  final String password;
  final String email;
  final bool rememberMe;
  CreateNewAccountEvent({required this.userName, required this.email, required this.password, required this.rememberMe});
}

class LoginEvent extends AuthenticationEvent{
  final String userName;
  final String password;
  final bool rememberMe;
  LoginEvent({required this.userName, required this.password, required this.rememberMe});
}
