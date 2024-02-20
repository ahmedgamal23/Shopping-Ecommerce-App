import 'package:shopping_ecommerce_app/main_content/data/datasource/cart_datasource.dart';
import 'package:shopping_ecommerce_app/main_content/domain/entity/item.dart';
import 'package:shopping_ecommerce_app/main_content/domain/repository/base_cart_repository.dart';

class CartRepository extends BaseCartRepository{
  final BaseCartDatasource baseCartDatasource;
  CartRepository(this.baseCartDatasource);
  @override
  Future<bool> addCart(Item item) async {
    return await baseCartDatasource.addCart(item);
  }

  @override
  Future<bool> checkCartState(int code) async{
    return await baseCartDatasource.checkCartState(code);
  }

  @override
  Future<List<Item>> getAllCartItems() async {
    return await baseCartDatasource.getAllCartItems();
  }

  @override
  Future<bool> removeCartItem(int code) async {
    return await baseCartDatasource.removeCartItem(code);
  }
}
