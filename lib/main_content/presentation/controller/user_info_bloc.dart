import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/controller/user_info_bloc_event.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/controller/user_info_bloc_state.dart';
import '../../domain/entity/user.dart';
import '../../domain/usecase/user_info_usecase.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState>{
  final BaseUserInfoUseCase baseUserInfoUseCase;
  UserInfoBloc(this.baseUserInfoUseCase):super(UserInfoInitialization()){
    on<UserInfoEvent>((event, emit) async {
      if(event is GetUserInfoEvent){
        User user = await baseUserInfoUseCase.execute();
        if(user.email != "" && user.username != ""){
          emit(UserInfoSuccess(user));
        }else{
          emit(UserInfoFailure());
        }
      }
    });
  }
}


