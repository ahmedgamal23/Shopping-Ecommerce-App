import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_ecommerce_app/main_content/domain/entity/address.dart';
import 'package:shopping_ecommerce_app/main_content/domain/entity/item.dart';
import 'package:shopping_ecommerce_app/main_content/domain/entity/review.dart';
import 'package:shopping_ecommerce_app/main_content/domain/usecase/address_usecase.dart';
import 'package:shopping_ecommerce_app/main_content/domain/usecase/cart_usecase.dart';
import 'package:shopping_ecommerce_app/main_content/domain/usecase/categories_usecase.dart';
import 'package:shopping_ecommerce_app/main_content/domain/usecase/review_usecase.dart';
import 'package:shopping_ecommerce_app/main_content/domain/usecase/wishlist_usecase.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/controller/bloc_event.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/controller/bloc_state.dart';
import '../../domain/entity/category.dart';
import '../../domain/usecase/new_arrival_usecase.dart';


class ItemBloc extends Bloc<ItemBlocEvent, ItemBlocState>{
  final BaseNewArrivalUseCase baseNewArrivalUseCase;
  ItemBloc(this.baseNewArrivalUseCase):super(ItemBlocInitial()){
    on<ItemBlocEvent>((event, emit) async {
      if(event is GetItemsDataEvent){
        List<Item> itemList = await baseNewArrivalUseCase.execute();
        if(itemList.isNotEmpty){
          emit(GetItemDataState(itemList));
        }else{
          emit(ItemBlocFailure());
        }
      }
    });
  }
}

class CategoryBloc extends Bloc<ItemBlocEvent, ItemBlocState>{
  final BaseCategoriesUseCase baseCategoriesUseCase;
  CategoryBloc(this.baseCategoriesUseCase):super(ItemBlocInitial()){
    on<ItemBlocEvent>((event, emit) async {
      if(event is GetCategoryEvent){
        List<Category> categoryList = await baseCategoriesUseCase.execute();
        if(categoryList.isNotEmpty){
          emit(GetCategoryState(categoryList));
        }else{
          emit(ItemBlocFailure());
        }
      }else if(event is GetCategoryItemsEvent){
        List<Item> categoryItemList = await baseCategoriesUseCase.executeCategoryItems(event.cateName);
        if(categoryItemList.isNotEmpty){
          emit(GetItemDataState(categoryItemList));
        }else{
          emit(ItemBlocFailure());
        }
      }
    });
  }
}

class CartBloc extends Bloc<ItemBlocEvent, ItemBlocState>{
  final BaseCartUseCase baseCartUseCase;
  CartBloc(this.baseCartUseCase):super(ItemBlocInitial()){
    on<ItemBlocEvent>((event, emit) async {
      if(event is AddCartEvent){
        bool check = await baseCartUseCase.execute(event.item);
        if(check == true){
          // cart is add successfully
          emit(ItemBlocSuccess());
        }
      }else if(event is CheckCartEvent){
        bool check = await baseCartUseCase.executeCheckCartState(event.code);
        if(check == true){
          // cart is exist
          emit(ItemBlocSuccess());
        }else{
          // cart is not exist
          emit(ItemBlocFailure());
        }
      }else if(event is GetAllCartEvent){
        // get all cart items
        List<Item> listItem = await baseCartUseCase.executeGetAllCartItems();
        if(listItem.isNotEmpty){
          emit(GetAllCartState(listItem));
        }else{
          emit(ItemBlocFailure());
        }
      }else if(event is RemoveCartItemEvent){
        // remove this item
        bool result = await baseCartUseCase.removeCartItem(event.code);
        emit(RemoveCartItemState(result));
      }
    });
  }
}

class WishlistBloc extends Bloc<ItemBlocEvent, ItemBlocState>{
  final BaseWishlistUseCase baseWishlistUseCase;
  WishlistBloc(this.baseWishlistUseCase):super(ItemBlocInitial()){
    on<ItemBlocEvent>((event, emit) async{
      if(event is AddWishlistItemEvent){
        bool result = await baseWishlistUseCase.executeAddWishlistItemState(event.item);
        emit(AddWishlistItemState(result));
      }else if(event is GetAllWishlistItemsEvent){
        List<Item> result = await baseWishlistUseCase.executeGetAllWishlistItemsState();
        if(result.isNotEmpty){
          emit(GetAllWishlistItemsState(result));
        }else{
          emit(ItemBlocFailure());
        }
      }else if(event is RemoveWishlistItemEvent){
        bool result = await baseWishlistUseCase.executeRemoveWishlistItem(event.code);
        emit(RemoveWishlistItemState(result));
      }
    });
  }
}

class AddressBloc extends Bloc<ItemBlocEvent, ItemBlocState>{
  BaseAddressUseCase baseAddressUseCase;
  AddressBloc(this.baseAddressUseCase):super(ItemBlocInitial()){
    on<ItemBlocEvent>((event, emit) async {
      if(event is AddAddressDataEvent){
        // add address data to firebase
        bool result = await baseAddressUseCase.executeSetAddressData(event.address);
        emit(AddAddressDataState(result));
      }else if(event is GetAddressDataEvent){
        // get address data
        Address address = await baseAddressUseCase.executeGetAddressData();
        emit(GetAddressDataState(address));
      }
    });
  }
}

class ReviewBloc extends Bloc<ItemBlocEvent, ItemBlocState>{
  BaseReviewUseCase baseReviewUseCase;
  ReviewBloc(this.baseReviewUseCase):super(ItemBlocInitial()){
    on<ItemBlocEvent>((event, emit) async {
      if(event is AddReviewEvent){
        // add address data to firebase
        bool result = await baseReviewUseCase.executeAddReview(event.review);
        emit(AddReviewState(result));
      }else if(event is GetAllReviewsEvent){
        // get all reviews
        List<Review> data = await baseReviewUseCase.getAllReviews();
        emit(GetAllReviewsState(data));
      }
    });
  }
}

