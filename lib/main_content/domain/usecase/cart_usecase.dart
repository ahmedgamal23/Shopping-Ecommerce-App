import '../entity/item.dart';
import '../repository/base_cart_repository.dart';

abstract class BaseCartUseCase{
  Future<bool> execute(Item item);
  Future<bool> executeCheckCartState(int code);
  Future<List<Item>> executeGetAllCartItems();
  Future<bool> removeCartItem(int code);
}

class CartUseCase extends BaseCartUseCase{
  final BaseCartRepository baseCartRepository;
  CartUseCase(this.baseCartRepository);
  @override
  Future<bool> execute(Item item) async {
    return await baseCartRepository.addCart(item);
  }

  @override
  Future<bool> executeCheckCartState(int code) async {
    return await baseCartRepository.checkCartState(code);
  }

  @override
  Future<List<Item>> executeGetAllCartItems() async {
    return await baseCartRepository.getAllCartItems();
  }

  @override
  Future<bool> removeCartItem(int code) async {
    return await baseCartRepository.removeCartItem(code);
  }
}
