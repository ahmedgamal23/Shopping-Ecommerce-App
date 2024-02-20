import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseCreateNewAccountDataSource{
  Future<bool> createNewAccount(String username, String email, String password, bool rememberMe);
}

class CreateNewAccountDataSource extends BaseCreateNewAccountDataSource{

  @override
  Future<bool> createNewAccount(String username, String email, String password, bool rememberMe) {
    // TODO: implement createNewAccount
    return registerUser(username, email, password, rememberMe);
  }

  // TODO: register user in firebase
  Future<bool> registerUser(String username, String email, String password, bool rememberMe)async{
    try{
      // save email, password and username
      DocumentReference<Map<String, dynamic>> userDocRef = await FirebaseFirestore.instance.collection('users').add({
        'username': username,
        'email': email,
        'password': password,
      });
      // save docId in shared preference

      await docIdSharedPreference(userDocRef.id);
      print("============= ${userDocRef.id} ==============");
      // register user in shared preference if rememberMe is true
      if(rememberMe){
        bool result = await registerUserSharedPreference(username, password);
        if(result){
          return true;
        }else{
          return false;
        }
      }
      return true;
    }catch(error){
      print("Error in register this user in firebase: $error");
      return false;
    }
  }


  // TODO: register user in shared preference
  Future<bool> registerUserSharedPreference(String username, String password)async{
    try{
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      bool x = await sharedPreferences.setString("username", username);
      bool y = await sharedPreferences.setString("password", password);
      print("===========$x================$y");
      return true;
    }catch(error){
      print("Error in register this user in shared preference : $error");
      return false;
    }
  }

  // TODO: register docID in shared preference
  Future<bool> docIdSharedPreference(String docId)async{
    try{
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      bool x = await sharedPreferences.setString("docId", docId);
      print("===========$x===============");
      return true;
    }catch(error){
      print("Error in register this docID in shared preference : $error");
      return false;
    }
  }

}
