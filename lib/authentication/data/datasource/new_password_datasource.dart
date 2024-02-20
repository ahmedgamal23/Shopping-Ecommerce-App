import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseNewPasswordDatasource{
  Future<bool> setNewPassword(String email, String password);
}

class NewPasswordDatasource extends BaseNewPasswordDatasource{
  @override
  Future<bool> setNewPassword(String email, String password) async {
    // TODO: implement setNewPassword
    try{
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection("users").
                                                                      where("email",isEqualTo: email).limit(1).get();
      if(snapshot.docs.isNotEmpty){
        await FirebaseFirestore.instance.collection("users").doc(snapshot.docs.first.id).update({'password':password});
        return true;
      }
      return false;
    }catch(error){
      print("***********$error***********");
      return false;
    }
  }

}
