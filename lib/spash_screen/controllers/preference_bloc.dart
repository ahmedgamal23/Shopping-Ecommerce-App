import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_ecommerce_app/spash_screen/controllers/preference_bloc_event.dart';
import 'package:shopping_ecommerce_app/spash_screen/controllers/preference_bloc_state.dart';

class PreferenceBloc extends Bloc<PreferenceEvent, PreferenceState>{
  PreferenceBloc():super(PreferenceInitialization()){
    on<PreferenceEvent>((event, emit) async{
      // TODO: check if username and password is exist in shared preference
      if(event is CheckSharedPreferenceEvent){
        if(await checkExistSharedPreference() == true){
          emit(PreferenceSuccess());
        }else{
          emit(PreferenceFailure());
        }
      }
    });
  }

  Future<bool> checkExistSharedPreference()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? user =  sharedPreferences.getString("username");
    String? pass =  sharedPreferences.getString("password");
    print("***$user******$pass***");
    if(user != null && pass != null){
      print("************");
      return true;
    }else{
      return false;
    }
  }

}