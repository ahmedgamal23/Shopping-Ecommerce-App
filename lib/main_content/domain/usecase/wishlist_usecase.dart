import 'package:shopping_ecommerce_app/main_content/domain/entity/item.dart';
import 'package:shopping_ecommerce_app/main_content/domain/repository/base_wishlist_repository.dart';

abstract class BaseWishlistUseCase{
  Future<bool> executeAddWishlistItemState(Item item);
  Future<List<Item>> executeGetAllWishlistItemsState();
  Future<bool> executeRemoveWishlistItem(int code);
}

class WishlistUseCase extends BaseWishlistUseCase{
  BaseWishlistRepository baseWishlistRepository;
  WishlistUseCase(this.baseWishlistRepository);
  @override
  Future<bool> executeAddWishlistItemState(Item item) async {
    return await baseWishlistRepository.addWishlistItemState(item);
  }

  @override
  Future<List<Item>> executeGetAllWishlistItemsState() async {
    return await baseWishlistRepository.getAllWishlistItemsState();
  }

  @override
  Future<bool> executeRemoveWishlistItem(int code) async {
    return await baseWishlistRepository.removeWishlistItem(code);
  }
}
