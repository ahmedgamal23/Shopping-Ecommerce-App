import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'dart:math';

class VerificationCode{
  // TODO: send verification code
  Future<bool> sendVerificationCode(String email)async{
    String myEmail = "gimy1.5.2001@gmail.com";
    String myPass = "iquc qyvj zknm ldlc";

    // generate verification code
    int verificationCode = generateCode();
    // save this verification code
    if(await saveVerificationCode(email, verificationCode)==true){
      // send verification code to this email
      final smtpServer = gmail(myEmail, myPass);
      final message = Message()
        ..from = Address(myEmail, 'Shopping app')
        ..recipients.add(email)
        ..subject = 'Verification Code for Password Reset'
        ..text = 'Your verification code is: $verificationCode';
      try {
        final sendReport = await send(message, smtpServer);
        print('**************Message sent: ${sendReport.mail}');
        return true;
      } catch (e) {
        print('Error occurred while sending email: $e');
        return false;
      }
    }
    return false;
  }

  // TODO: generate verification code
  int generateCode(){
    Random random = Random();
    return 1000 + random.nextInt(9000);
  }

  // TODO: save verification code in firebase
  Future<bool> saveVerificationCode(String email, int code)async{
    try{
      // get user id
      final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection("users")
                                                                  .where("email",isEqualTo: email).limit(1).get();
      if(snapshot.docs.isNotEmpty){
        String userId = snapshot.docs.first.id;
        CollectionReference users = FirebaseFirestore.instance.collection("users");
        DocumentReference userRef = users.doc(userId);
        await userRef.set({"code":code}, SetOptions(merge: true));
        return true;
      }
      return false;
    }catch(error){
      print("******$error*******");
      return false;
    }
  }

  // TODO: delete verification code in firebase
  Future<bool> deleteVerificationCode(int code)async{
    try{
      // get user id
      final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection("users")
          .where("code",isEqualTo: code).limit(1).get();
      if(snapshot.docs.isNotEmpty){
        String userId = snapshot.docs.first.id;
        CollectionReference users = FirebaseFirestore.instance.collection("users");
        DocumentReference userRef = users.doc(userId);
        await userRef.set({"code":0}, SetOptions(merge: true));
        return true;
      }
      return false;
    }catch(error){
      print("******$error*******");
      return false;
    }
  }

}