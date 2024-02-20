import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_ecommerce_app/authentication/data/datasource/verification_code.dart';

abstract class BaseCheckCodeDatasource{
  Future<bool> checkCode(int code);
}

class CheckCodeDatasource extends BaseCheckCodeDatasource{
  @override
  Future<bool> checkCode(int code) async{
    // TODO: implement checkCode
    try{
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection("users")
          .where("code",isEqualTo: code).limit(1).get();
      if(snapshot.docs.isNotEmpty){
        // set code in firebase with 0
        VerificationCode verificationCode = VerificationCode();
        verificationCode.deleteVerificationCode(code);
        return true;
      }
      return false;
    }catch(error){
      print("***********$error*********");
      return false;
    }
  }
}
