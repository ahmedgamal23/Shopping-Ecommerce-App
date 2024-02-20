import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_ecommerce_app/main_content/domain/entity/item.dart';

abstract class BaseCartDatasource{
  Future<bool> addCart(Item item);
  Future<bool> checkCartState(int code);
  Future<List<Item>> getAllCartItems();
  Future<bool> removeCartItem(int code);
}

class CartDatasource extends BaseCartDatasource{
  @override
  Future<bool> addCart(Item item) async {
    // TODO: create collection for each user
    try{
      if(await checkCartState(item.code)==true){
        // cart is exist not need to add it
        return false;
      }else{
        String docID = await getDocId();
        DocumentReference documentReference = FirebaseFirestore.instance.collection("users").doc(docID);
        documentReference.collection("cart_${docID}_items").add({
          "image":item.image,
          "name":item.name,
          "price":item.price,
          "code":item.code
        });
        return true;
      }
    }catch(error){
      return false;
    }
  }

  @override
  Future<bool> checkCartState(int code)async{
    /// TODO: check cart state
    String docID = await getDocId();
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection("users").doc(docID).collection("cart_${docID}_items").
                          where("code",isEqualTo: code).limit(1).get();
    if(snapshot.docs.isNotEmpty){
      // this cart is exist
      return true;
    }else{
      // this cart is not exist
      return false;
    }
  }

  @override
  Future<List<Item>> getAllCartItems() async {
    // TODO: get all cart items
    try{
      String docID = await getDocId();
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection("users").doc(docID).
                                                            collection("cart_${docID}_items").get();
      List<Item> listItem=[];
      for(DocumentSnapshot doc in snapshot.docs){
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        listItem.add(Item(name: data["name"], image: data["image"], price: data["price"], code: data["code"]));
      }
      return listItem;
    }catch(error){
      throw Exception(error);
    }
  }

  @override
  Future<bool> removeCartItem(int code) async {
    // TODO: implement removeCartItem
    try{
      String docId = await getDocId();
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection("users").doc(docId).
                                                      collection("cart_${docId}_items").where("code",isEqualTo: code).limit(1).get();
      DocumentReference documentReference = FirebaseFirestore.instance.collection("users").doc(docId).
                                                      collection("cart_${docId}_items").doc(snapshot.docs.first.id);
      documentReference.delete();
      return true;
    }catch(error){
      print("Failed to delete document: $error");
      return false;
    }
  }
  
  /// TODO: get docId from shared preference
  Future<String> getDocId()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String docID = preferences.getString("docId")!;
    if(docID.isNotEmpty){
      return docID;
    }else{
      throw Exception("********** not find doc id for this user *****");
    }
  }

}
