import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entity/user.dart';

abstract class BaseUserInfoDatasource{
  Future<User> getUserInfo();
}

class UserInfoDatasource extends BaseUserInfoDatasource{
  @override
  Future<User> getUserInfo() async{
    // TODO: implement getUserInfo
    try{
      // get docId from shared preferences
      Object docId = await getDocId();
      // read data
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await FirebaseFirestore.instance.collection("users").doc(docId.toString()).get();
      if(documentSnapshot.exists){
        // extract info
        Map<String, dynamic> data = documentSnapshot.data()!;
        return User(username: data["username"], email: data["email"], password: data["password"]);
      }
      throw Future.error(Exception("************* documentSnapshot is not exist ***********"));
    }catch(error){
      print("********$error********");
      throw Future.error(error);
    }
  }

  Future<Object> getDocId()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Object docId = sharedPreferences.get("docId")!;
    return docId;
  }

}

