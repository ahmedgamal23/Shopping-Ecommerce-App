import '../entity/item.dart';

abstract class BaseWishlistRepository{
  Future<bool> addWishlistItemState(Item item);
  Future<List<Item>> getAllWishlistItemsState();
  Future<bool> removeWishlistItem(int code);
}
