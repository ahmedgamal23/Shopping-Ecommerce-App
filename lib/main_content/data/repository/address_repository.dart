import 'package:shopping_ecommerce_app/main_content/data/datasource/address_datasource.dart';
import 'package:shopping_ecommerce_app/main_content/domain/entity/address.dart';
import 'package:shopping_ecommerce_app/main_content/domain/repository/base_address_repository.dart';

class AddressRepository extends BaseAddressRepository{
  BaseAddressDatasource baseAddressDatasource;
  AddressRepository(this.baseAddressDatasource);
  @override
  Future<bool> setAddressData(Address address) async {
    return await baseAddressDatasource.setAddressData(address);
  }

  @override
  Future<Address> getAddressData()async{
    return await baseAddressDatasource.getAddressData();
  }
}
