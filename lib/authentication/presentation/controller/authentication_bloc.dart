import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopping_ecommerce_app/authentication/domain/usecase/create_new_account_usecase.dart';
import 'package:shopping_ecommerce_app/authentication/presentation/controller/auth_bloc_event.dart';
import 'package:shopping_ecommerce_app/authentication/presentation/controller/auth_bloc_state.dart';
import '../../domain/usecase/login_usecase.dart';

class CreateNewAccountBloc extends Bloc<AuthenticationEvent, AuthenticationState>{
  final BaseCreateNewAccountUserCase baseCreateNewAccountUserCase;
  CreateNewAccountBloc(this.baseCreateNewAccountUserCase):super(AuthenticationInitial()){
    // TODO: Add event create new account
    on<AuthenticationEvent>((event, emit)async{
      if(event is CreateNewAccountEvent){
        if(await baseCreateNewAccountUserCase.execute(event.userName, event.email, event.password, event.rememberMe) == true){
          emit(AuthenticationSuccess());
        }else if(await baseCreateNewAccountUserCase.execute(event.userName, event.email, event.password, event.rememberMe) == false){
          emit(AuthenticationFailure());
        }else{
          emit(AuthenticationLoading());
        }
      }
    });
  }
}

class LoginBloc extends Bloc<AuthenticationEvent, AuthenticationState>{
  final BaseLoginUseCase baseLoginUseCase;
  LoginBloc(this.baseLoginUseCase):super(AuthenticationInitial()){
    // TODO: verify username and password
    on<AuthenticationEvent>((event, emit) async {
      if(event is LoginEvent){
        if(await baseLoginUseCase.execute(event.userName, event.password, event.rememberMe) == true){
          emit(AuthenticationSuccess());
        }else if(await baseLoginUseCase.execute(event.userName, event.password, event.rememberMe) == false){
          emit(AuthenticationFailure());
        }else{
          emit(AuthenticationLoading());
        }
      }
    });
  }
}

class AuthBloc extends Bloc<AuthenticationEvent, AuthenticationState>{
  AuthBloc():super(AuthenticationInitial()){
    // TODO: Add event sign in with facebook, twitter and google
    on<AuthenticationEvent>((event, emit)async{
      if(event is SignInWithFacebookEvent){
        emit(await _mapSignInWithFacebookToState());
      }else if(event is SignInWithGoogleEvent){
        emit(await _mapSignInWithGoogleToState());
      }
    });

  }

  // TODO: Sign In with facebook
  Future<AuthenticationState> _mapSignInWithFacebookToState() async {
    // Implement your sign-in logic here
    try{
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        return AuthenticationSuccess();
      } else {
        return AuthenticationFailure();
      }
    }catch(error){
      return AuthenticationFailure();
    }
  }

  // TODO: Sign In with google
  Future<AuthenticationState> _mapSignInWithGoogleToState() async {
    // Implement your sign-in logic here
    try{
      final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
      await googleSignIn.signIn();
      return AuthenticationSuccess();
    }catch(error){
      return AuthenticationFailure();
    }
  }

}
