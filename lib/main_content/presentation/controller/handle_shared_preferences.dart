import 'package:shared_preferences/shared_preferences.dart';

class HandleSharedPreferences{

  static Future<bool> removeDataSharedPreferences()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if(await sharedPreferences.remove("username") == true &&
        await sharedPreferences.remove("password") == true && await sharedPreferences.remove("docId") == true){
      return true;
    }else{
      return false;
    }
  }

}
