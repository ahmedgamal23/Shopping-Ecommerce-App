import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_ecommerce_app/authentication/domain/usecase/check_code_usecase.dart';
import 'package:shopping_ecommerce_app/authentication/domain/usecase/resend_code_usecase.dart';
import 'package:shopping_ecommerce_app/authentication/presentation/controller/reset_password_bloc_event.dart';
import 'package:shopping_ecommerce_app/authentication/presentation/controller/reset_password_bloc_state.dart';
import '../../domain/usecase/check_email_usecase.dart';
import '../../domain/usecase/new_password_usecase.dart';

class CheckEmailBloc extends Bloc<ResetPasswordEvent, ResetPasswordState>{
  final BaseCheckEmailUseCase baseCheckEmailUseCase;
  CheckEmailBloc(this.baseCheckEmailUseCase):super(ResetPasswordInitial()){
    // TODO: check Email Address
    on((event, emit)async{
      if(event is CheckEmailEvent){
        if(await baseCheckEmailUseCase.execute(event.email) == true){
          /// email is exist
          emit(ResetPasswordSuccess());
        }else{
          /// email is not exist
          emit(ResetPasswordFailure());
        }
      }
    });
  }
}

class CheckCodeBloc extends Bloc<ResetPasswordEvent, ResetPasswordState>{
  final BaseCheckCodeUseCase baseCheckCodeUseCase;
  CheckCodeBloc(this.baseCheckCodeUseCase):super(ResetPasswordInitial()){
    on<ResetPasswordEvent>((event, emit)async{
      if(event is CheckCodeEvent){
        if(await baseCheckCodeUseCase.execute(event.code) == true){
          /// code is correct
          emit(ResetPasswordSuccess());
        }else{
          /// code is not correct
          emit(ResetPasswordFailure());
        }
      }
    });
  }
}

class ResendCodeBloc extends Bloc<ResetPasswordEvent, ResetPasswordState>{
  final BaseResendCodeUseCase baseResendCodeUseCase;
  ResendCodeBloc(this.baseResendCodeUseCase):super(ResetPasswordInitial()){
    on<ResetPasswordEvent>((event, emit)async{
      if(event is ResendCodeEvent){
        if(await baseResendCodeUseCase.execute(event.email) == true){
          /// code is resent
          emit(ResetPasswordSuccess());
        }else{
          /// code is not resent
          emit(ResetPasswordFailure());
        }
      }
    });
  }
}

class NewPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState>{
  final BaseNewPasswordUseCase baseNewPasswordUseCase;
  NewPasswordBloc(this.baseNewPasswordUseCase):super(ResetPasswordInitial()){
    on<ResetPasswordEvent>((event, emit)async{
      if(event is NewPasswordEvent){
        if(await baseNewPasswordUseCase.execute(event.email, event.password) == true){
          /// password is updated
          emit(ResetPasswordSuccess());
        }else{
          /// code is not updated
          emit(ResetPasswordFailure());
        }
      }
    });
  }
}
