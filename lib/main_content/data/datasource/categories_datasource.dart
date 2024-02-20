import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shopping_ecommerce_app/main_content/domain/entity/item.dart';
import '../../domain/entity/category.dart';

abstract class BaseCategoriesDatasource{
  Future<List<Category>> getCategory();
  Future<List<Item>> getCategoryItem(String cateName);
}

class CategoriesDatasource extends BaseCategoriesDatasource{
  @override
  Future<List<Category>> getCategory() async {
    // TODO: implement getCategory
    Reference reference = FirebaseStorage.instance.ref().child("categories");
    ListResult listResult = await reference.listAll();
    List<Reference> imgRef = listResult.items;
    List<String> imagePathList = await Future.wait(imgRef.map((e) => e.getDownloadURL()).toList());

    // read from fireStore
    List<Category> data = [];
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection("categories").get();
    if(snapshot.docs.isEmpty){
      throw Exception("****************no data exist***********");
    }else{
      for(DocumentSnapshot documentSnapshot in snapshot.docs){
        Map<String, dynamic> cateName = documentSnapshot.data() as Map<String, dynamic>;
        String categoryName = cateName["cate_name"];
        int j = imgRef.indexWhere((ref) => ref.fullPath.contains(categoryName));
        if(j != -1){
          data.add(Category(imagePathList[j], categoryName));
        }else{
          print("No image found for category: $categoryName");
        }
      }
      return data;
    }
  }
  
  @override
  Future<List<Item>> getCategoryItem(String cateName)async{
    // load items image
    Reference reference = FirebaseStorage.instance.ref().child("categories/categories items/$cateName");
    ListResult listResult = await reference.listAll();
    List<Reference> listRef = listResult.items;
    List<String> imagePaths = await Future.wait(listRef.map((ref) => ref.getDownloadURL()).toList());

    // get id for specific document
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection("categories").
                                                            where("cate_name", isEqualTo: cateName).limit(1).get();
    String docId = snapshot.docs.first.id;
    // load data for each item
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection("categories").
                                          doc(docId).collection("$cateName items").get();
    List<Item> data = [];
    if(querySnapshot.docs.isEmpty){
      throw Exception("************** no data **************");
    }else{
      for(DocumentSnapshot doc in querySnapshot.docs){
        Map<String, dynamic> cateItems = doc.data() as Map<String, dynamic>;
        int code = cateItems["code"];
        int j = listRef.indexWhere((ref) => ref.fullPath.contains("_$code"));
        if(j != -1){
          data.add(Item(
            name: listRef[j].fullPath.split("/").last.split("_")[0],
            image: imagePaths[j],
            price: cateItems["price"],
            code: code
          ));
        }else{
          print("No image found for category item code : $code");
        }
      }
      return data;
    }

  }
  
}
