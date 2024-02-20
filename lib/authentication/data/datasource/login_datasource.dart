import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseLoginDatasource{
  Future<bool> verifyUsernamePassword(String username, String password, bool rememberMe);
}

class LoginDatasource extends BaseLoginDatasource{
  @override
  Future<bool> verifyUsernamePassword(String username, String password, bool rememberMe) async{
    // TODO: implement verifyUsernamePassword
    // this user not exist in shared preference not need to check in firebase
    if(await checkUserNamePassword(username, password, rememberMe) == true){
      return true;
    }else{
      return false;
    }
  }

  // TODO: store user in shared preference
  Future<void> saveDataSharedPreference(String username, String password)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString("username", username);
    await sharedPreferences.setString("password", password);
  }

  // TODO: store docId in shared preference
  Future<void> saveDocIdSharedPreference(String docID)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString("docId", docID);
  }

  // TODO: check if user store in firebase
  Future<bool> checkUserNamePassword(String username, String password, bool rememberMe)async{
    try{
      final QuerySnapshot<Map<String , dynamic>> snapshot = await FirebaseFirestore.instance.
                                                                  collection("users").where("username",isEqualTo: username).
                                                                  limit(1).get();
      if(snapshot.docs.isNotEmpty){
        // username is exist
        final userData = snapshot.docs.first.data();
        final pass = userData['password'];
        if(pass == password){
          if(rememberMe == true){
            // save this data in shared preference
            saveDataSharedPreference(username, password);
          }// save docID
          saveDocIdSharedPreference(snapshot.docs.first.id);
          return true;
        }else{
          return false;
        }
      }else{
        return false;
      }
    }catch(error){
      print("Faild: $error");
      return false;
    }
  }

  /*
  // TODO: check if user store in shared preference return it
  Future<bool> checkExistSharedPreference(String username, String password)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? user = sharedPreferences.getString("username");
    String? pass = sharedPreferences.getString("password");
    if(user != null && pass != null){
      return true;
    }else{
      return false;
    }
  }
  */

}
