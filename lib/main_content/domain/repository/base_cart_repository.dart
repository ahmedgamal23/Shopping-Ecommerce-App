import 'package:shopping_ecommerce_app/main_content/domain/entity/item.dart';

abstract class BaseCartRepository{
  Future<bool> addCart(Item item);
  Future<bool> checkCartState(int code);
  Future<List<Item>> getAllCartItems();
  Future<bool> removeCartItem(int code);
}
