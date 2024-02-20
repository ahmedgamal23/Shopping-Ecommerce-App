import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entity/item.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class BaseNewArrivalDatasource{
  Future<List<Item>> getItemData();
}

class NewArrivalDatasource extends BaseNewArrivalDatasource{

  @override
  Future<List<Item>> getItemData() async {
    final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    final Reference ref = firebaseStorage.ref().child("new arrivals");

    ListResult listResult = await ref.listAll();
    List<Reference> imageRefs = listResult.items;
    /// read images from firebase storage
    List<String> imageUrls = await Future.wait(imageRefs.map((e) => e.getDownloadURL()).toList());
    
    /// read data for each image
    List<Item> data = [];
    QuerySnapshot<Map<String , dynamic>> querySnapshots = await FirebaseFirestore.instance.collection("new arrival data").get();
    if(querySnapshots.docs.isEmpty){
      throw Exception("****************no data exist***********");
    }else{
      print("******************");
      print(querySnapshots);
      print("******************");
      int i=0;
      for(DocumentSnapshot documentSnapshot in querySnapshots.docs){
        Map<String, dynamic> mapData = documentSnapshot.data() as Map<String , dynamic>;
        data.add(Item(name: mapData["name"], image: imageUrls[i], price: mapData["price"], code: mapData["code"]));
        i++;
      }
      return data;
    }
  }



}

