import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_ecommerce_app/main_content/domain/entity/review.dart';

abstract class BaseReviewDatasource{
  Future<bool> addReview(Review review);
  Future<List<Review>> getAllReviews();
}

class ReviewDatasource extends BaseReviewDatasource{
  @override
  Future<bool> addReview(Review review) async {
    // TODO: implement addReview
    try{
      String docId = await getDocId();
      await FirebaseFirestore.instance.collection("reviews").doc().set({
        "id":docId,
        "name":review.name,
        "description":review.description,
        "stars":review.stars,
      });
      return true;
    }catch(error){
      return false;
    }
  }

  @override
  Future<List<Review>> getAllReviews() async {
    // TODO: implement getAllReviews
    try{
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection("reviews").get();
      List<Review> data = [];
      for(DocumentSnapshot doc in querySnapshot.docs){
        Map<String, dynamic> review = doc.data() as Map<String, dynamic>;
        data.add(Review(name: review["name"], description: review["description"], stars: review["stars"]));
      }
      return data;
    }catch(error){
      return [];
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
