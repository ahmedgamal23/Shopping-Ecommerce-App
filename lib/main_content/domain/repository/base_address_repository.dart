import '../entity/address.dart';

abstract class BaseAddressRepository{
  Future<bool> setAddressData(Address address);
  Future<Address> getAddressData();
}