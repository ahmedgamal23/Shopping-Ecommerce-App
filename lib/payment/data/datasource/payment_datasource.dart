import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_ecommerce_app/payment/domain/entity/card_info.dart';

abstract class BasePaymentDatasource{
  Future<bool> setPaymentInfo(CardInfo card);
  Future<List<CardInfo>> getAllCards();
}

class PaymentDatasource extends BasePaymentDatasource{
  @override
  Future<bool> setPaymentInfo(CardInfo card) async {
    // TODO: implement setPaymentInfo
    try{
      String docID = await getDocID();
      await FirebaseFirestore.instance.collection("users").doc(docID).collection("cards_$docID").doc().set({
        "cardOwner":card.cardOwner,
        "cardNumber":card.cardNumber,
        "exp":card.exp,
        "cvv":card.cvv
      });
      return true;
    }catch(error){
      return false;
    }
  }

  @override
  Future<List<CardInfo>> getAllCards() async {
    // TODO: implement getAllCards
    try{
      String docID = await getDocID();
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection("users").doc(docID).
                              collection("cards_$docID").get();
      List<CardInfo> data = [];
      if(snapshot.docs.isNotEmpty){
        for(DocumentSnapshot doc in snapshot.docs){
          data.add(CardInfo(
            doc["cardOwner"],
            doc["cardNumber"],
            doc["exp"],
            doc["cvv"]
          ));
        }
      }
      return data;
    }catch(error){
      throw Exception("Error *** $error ****");
    }
  }

  // TODO: get docID
  Future<String> getDocID()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("docId")!;
  }
}
