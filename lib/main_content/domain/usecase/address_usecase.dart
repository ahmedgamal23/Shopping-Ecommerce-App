import 'package:shopping_ecommerce_app/main_content/domain/repository/base_address_repository.dart';

import '../entity/address.dart';

abstract class BaseAddressUseCase{
  Future<bool> executeSetAddressData(Address address);
  Future<Address> executeGetAddressData();
}

class AddressUseCase extends BaseAddressUseCase{
  BaseAddressRepository baseAddressRepository;
  AddressUseCase(this.baseAddressRepository);
  @override
  Future<bool> executeSetAddressData(Address address) async {
    return await baseAddressRepository.setAddressData(address);
  }

  @override
  Future<Address> executeGetAddressData() async {
    return await baseAddressRepository.getAddressData();
  }
}
