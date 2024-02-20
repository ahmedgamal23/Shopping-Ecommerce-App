import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_ecommerce_app/authentication/data/datasource/verification_code.dart';

abstract class BaseCheckEmailDatasource{
  Future<bool> checkEmail(String email);
}

class CheckEmailDatasource extends BaseCheckEmailDatasource{
  @override
  Future<bool> checkEmail(String email) async {
    // TODO: implement checkEmail
    try{
      final QuerySnapshot<Map<String , dynamic>> snapshot = await FirebaseFirestore.instance.collection("users")
                                                                                  .where("email",isEqualTo: email).limit(1).get();
      if(snapshot.docs.isNotEmpty){
        /// email is exist
        /// Send Verification code
        VerificationCode verificationCode = VerificationCode();
        if(await verificationCode.sendVerificationCode(email) == true){
          return true;
        }
        return false;
      }else{
        /// email not exist
        return false;
      }
    }catch(error){
      print("****$error***");
      return false;
    }
  }
}

