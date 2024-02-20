import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entity/address.dart';

abstract class BaseAddressDatasource{
  Future<bool> setAddressData(Address address);
  Future<Address> getAddressData();
}

class AddressDatasource extends BaseAddressDatasource{
  @override
  Future<bool> setAddressData(Address address) async {
    // TODO: implement setAddressData
    try{
      String docId = await getDocId();
      await FirebaseFirestore.instance.collection("users").doc(docId).collection("address_${docId}_data").doc().set({
        "name":address.name,
        "country":address.country,
        "city":address.city,
        "phoneNumber":address.phoneNumber,
        "address":address.address,
        "primaryAddress":address.saveAddress
      });
      return true;
    }catch(error){
      print("******$error*******");
      return false;
    }
  }

  @override
  Future<Address> getAddressData() async {
    // TODO: implement getAddressData
    String docId = await getDocId();
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection("users").doc(docId).
                                        collection("address_${docId}_data").where("primaryAddress",isEqualTo: true).limit(1).get();
    if(snapshot.docs.isNotEmpty){
      // select primary address
      return Address(
        name: snapshot.docs.first["name"],
        country: snapshot.docs.first["country"],
        city: snapshot.docs.first["city"],
        phoneNumber: snapshot.docs.first["phoneNumber"],
        address: snapshot.docs.first["address"],
        saveAddress: snapshot.docs.first["primaryAddress"]
      );
    }else{
      // select any one
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await FirebaseFirestore.instance.collection("users").doc(docId).
                                      collection("address_${docId}_data").doc().get();
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
      return Address(
          name: data["name"],
          country: data["country"],
          city: data["city"],
          phoneNumber: data["phoneNumber"],
          address: data["address"],
          saveAddress: data["address"]
      );
    }
  }

  // TODO: get docId
  Future<String> getDocId()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("docId")!;
  }
}

