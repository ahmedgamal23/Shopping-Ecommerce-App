import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entity/item.dart';

abstract class BaseWishlistDatasource{
  Future<bool> addWishlistItemState(Item item);
  Future<List<Item>> getAllWishlistItemsState();
  Future<bool> removeWishlistItem(int code);
}

class WishlistDatasource extends BaseWishlistDatasource{

  @override
  Future<bool> addWishlistItemState(Item item)async{
    /// TODO: add item to WishList
    try{
      String docID = await getDocId();
      // TODO: check if item is exist or not
      bool result = await checkItemWishlist(docID, item.code);
      if(result == false){
        // TODO: add this item to wishlist
        await FirebaseFirestore.instance.collection("users").doc(docID).collection("wishlist_${docID}_items").doc().set({
          "code":item.code,
          "name":item.name,
          "image":item.image,
          "price":item.price
        });
        // item added successfully
        return true;
      }else{
        // TODO: this item is already exist
        // not add it
        return false;
      }
    }catch(error){
      print("not add this item to wishlist $error");
      throw Exception("****** error not add this item to wishlist");
    }
  }

  @override
  Future<List<Item>> getAllWishlistItemsState() async {
    // TODO: implement getAllWishlistItemsState
    String docId = await getDocId();
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection("users").doc(docId).
                                                                        collection("wishlist_${docId}_items").get();
    List<Item> data = [];
    if(snapshot.docs.isNotEmpty){
      for(DocumentSnapshot doc in snapshot.docs){
        Map<String, dynamic> item = doc.data() as Map<String, dynamic>;
        data.add(Item(name: item["name"], image: item["image"], price: item["price"], code: item["code"]));
      }
      return data;
    }
    else{
      throw Exception("No wishlist items ********");
    }
  }

  @override
  Future<bool> removeWishlistItem(int code) async {
    // TODO: implement removeWishlistItem
    String docId = await getDocId();
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection("users").doc(docId).
                                                    collection("wishlist_${docId}_items").where("code",isEqualTo: code).limit(1).get();
    if(snapshot.docs.isNotEmpty){
      try{
        await FirebaseFirestore.instance.collection("users").doc(docId).collection("wishlist_${docId}_items").
                                          doc(snapshot.docs.first.id).delete();
        return true;
      }catch(error){
        print("*******$error*******");
        return false;
      }
    }else{
      return false;
    }
  }

  /// TODO: check item in WishList
  Future<bool> checkItemWishlist(String docID, int code) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection("users").doc(docID).
                                    collection("wishlist_${docID}_items").where("code",isEqualTo: code).limit(1).get();
    if(snapshot.docs.isNotEmpty){
      // this cart is exist
      return true;
    }else{
      // this cart is not exist
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
