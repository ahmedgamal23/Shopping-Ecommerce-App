import 'package:shopping_ecommerce_app/main_content/domain/entity/item.dart';
import '../../domain/entity/address.dart';
import '../../domain/entity/category.dart';
import '../../domain/entity/review.dart';

abstract class ItemBlocState{}

class ItemBlocInitial extends ItemBlocState{}

class ItemBlocSuccess extends ItemBlocState{}

class ItemBlocFailure extends ItemBlocState{}

class ItemBlocLoading extends ItemBlocState{}

class GetItemDataState extends ItemBlocState{
  List<Item> itemList;
  GetItemDataState(this.itemList);
}

class GetAllCartState extends ItemBlocState{
  List<Item> itemList;
  GetAllCartState(this.itemList);
}

class GetCategoryState extends ItemBlocState{
  List<Category> categoryList;
  GetCategoryState(this.categoryList);
}

class RemoveCartItemState extends ItemBlocState{
  bool result;
  RemoveCartItemState(this.result);
}

class AddWishlistItemState extends ItemBlocState{
  bool result;
  AddWishlistItemState(this.result);
}

class GetAllWishlistItemsState extends ItemBlocState{
  List<Item> listItems;
  GetAllWishlistItemsState(this.listItems);
}

class RemoveWishlistItemState extends ItemBlocState{
  bool result;
  RemoveWishlistItemState(this.result);
}

class AddAddressDataState extends ItemBlocState{
  bool result;
  AddAddressDataState(this.result);
}

class GetAddressDataState extends ItemBlocState{
  Address address;
  GetAddressDataState(this.address);
}

class AddReviewState extends ItemBlocState{
  bool result;
  AddReviewState(this.result);
}

class GetAllReviewsState extends ItemBlocState{
  List<Review> listReview;
  GetAllReviewsState(this.listReview);
}
