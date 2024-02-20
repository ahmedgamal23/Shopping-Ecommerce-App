import 'package:shopping_ecommerce_app/main_content/data/datasource/wishlist_datsource.dart';
import 'package:shopping_ecommerce_app/main_content/domain/entity/item.dart';
import '../../domain/repository/base_wishlist_repository.dart';

class WishlistRepository extends BaseWishlistRepository{
  BaseWishlistDatasource baseWishlistDatasource;
  WishlistRepository(this.baseWishlistDatasource);
  @override
  Future<bool> addWishlistItemState(Item item) async{
    return await baseWishlistDatasource.addWishlistItemState(item);
  }

  @override
  Future<List<Item>> getAllWishlistItemsState() async {
    return await baseWishlistDatasource.getAllWishlistItemsState();
  }

  @override
  Future<bool> removeWishlistItem(int code) async {
    return await baseWishlistDatasource.removeWishlistItem(code);
  }
}
