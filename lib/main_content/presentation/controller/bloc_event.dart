import 'package:shopping_ecommerce_app/main_content/domain/entity/item.dart';
import 'package:shopping_ecommerce_app/main_content/domain/entity/review.dart';

import '../../domain/entity/address.dart';

abstract class ItemBlocEvent{}

class GetItemsDataEvent extends ItemBlocEvent{}

class GetCategoryEvent extends ItemBlocEvent{}

class GetCategoryItemsEvent extends ItemBlocEvent{
  String cateName;
  GetCategoryItemsEvent(this.cateName);
}

class AddCartEvent extends ItemBlocEvent{
  Item item;
  AddCartEvent(this.item);
}

class CheckCartEvent extends ItemBlocEvent{
  int code;
  CheckCartEvent(this.code);
}

class GetAllCartEvent extends ItemBlocEvent{}

class RemoveCartItemEvent extends ItemBlocEvent{
  int code;
  RemoveCartItemEvent(this.code);
}

class AddWishlistItemEvent extends ItemBlocEvent{
  Item item;
  AddWishlistItemEvent(this.item);
}

class GetAllWishlistItemsEvent extends ItemBlocEvent{}

class RemoveWishlistItemEvent extends ItemBlocEvent{
  int code;
  RemoveWishlistItemEvent(this.code);
}

class AddAddressDataEvent extends ItemBlocEvent{
  Address address;
  AddAddressDataEvent(this.address);
}

class GetAddressDataEvent extends ItemBlocEvent{}

class AddReviewEvent extends ItemBlocEvent{
  Review review;
  AddReviewEvent(this.review);
}

class GetAllReviewsEvent extends ItemBlocEvent{}
