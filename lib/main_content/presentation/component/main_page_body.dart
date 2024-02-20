import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_ecommerce_app/core/constant_color.dart';
import 'package:shopping_ecommerce_app/main_content/data/datasource/categories_datasource.dart';
import 'package:shopping_ecommerce_app/main_content/data/datasource/new_arrival_datasource.dart';
import 'package:shopping_ecommerce_app/main_content/data/datasource/wishlist_datsource.dart';
import 'package:shopping_ecommerce_app/main_content/data/repository/categories_repository.dart';
import 'package:shopping_ecommerce_app/main_content/data/repository/new_arrival_repository.dart';
import 'package:shopping_ecommerce_app/main_content/data/repository/wishlist_repository.dart';
import 'package:shopping_ecommerce_app/main_content/domain/entity/category.dart';
import 'package:shopping_ecommerce_app/main_content/domain/repository/base_categories_repository.dart';
import 'package:shopping_ecommerce_app/main_content/domain/repository/base_new_arrival_repository.dart';
import 'package:shopping_ecommerce_app/main_content/domain/repository/base_wishlist_repository.dart';
import 'package:shopping_ecommerce_app/main_content/domain/usecase/categories_usecase.dart';
import 'package:shopping_ecommerce_app/main_content/domain/usecase/new_arrival_usecase.dart';
import 'package:shopping_ecommerce_app/main_content/domain/usecase/wishlist_usecase.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/controller/bloc.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/controller/bloc_event.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/controller/bloc_state.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/controller/user_info_bloc.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/controller/user_info_bloc_event.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/screens/cart_page.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/screens/category_details_page.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/screens/item_details_page.dart';
import '../../domain/entity/item.dart';

class MainPageBody extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const MainPageBody({super.key, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // header (menu and cart)
            headerMenuCart(context),

            // welcome text
            welcomeText(),

            // search
            searchContainer(context),

            // categories
            categoriesHeader(context),

            // all categories
            categoriesContainer(context),

            // new arrivals
            newArrivalsHeader(context),

            // GridView: part of image data
            // items
            itemsGridView(context),
          ],
        ),
      ),
    );
  }

  Widget headerMenuCart(BuildContext context){
    return Container(
      margin: const EdgeInsets.only(top: 30, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // menu
          IconButton(
            onPressed: (){
              // TODO: add UserInfo event
              BlocProvider.of<UserInfoBloc>(context).add(GetUserInfoEvent());
              // TODO: when clicked on it go to menu widget
              scaffoldKey.currentState?.openDrawer();
            },
            icon : const Icon(Icons.menu, size: 30),
            color: ConstantColor.menuIconColor,
          ),
          // cart
          IconButton(
            onPressed: (){
              // TODO: when clicked on it go to cart widget
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => CartPage(),));
            },
            icon : const Icon(Icons.card_travel, size: 30),
            color: ConstantColor.cartIconColor,
          ),
        ],
      ),
    );
  }

  Widget welcomeText(){
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Hello",
          style: TextStyle(
            fontSize: 22,
            color: ConstantColor.splashContainerTitleColor,
          ),
        ),
        Text(
          "welcome to shopping.",
          style: TextStyle(
            fontSize: 18,
            color: ConstantColor.splashContainerSubTitleColor,
          ),
        ),
      ],
    );
  }

  Widget searchContainer(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width-50,
      height: 70,
      margin: const EdgeInsets.only(top: 20, bottom: 10),
      padding: const EdgeInsets.only(left: 20,),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: ConstantColor.searchColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        style: const TextStyle(fontSize: 20, ),
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search, size: 40,),
          prefixIconColor: ConstantColor.searchIconColor,
          border: InputBorder.none,
          hintText: "Search..",
          hintStyle: TextStyle(fontSize: 18, color:ConstantColor.searchIconColor, ),
        ),
      ),
    );
  }

  Widget categoriesHeader (BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Choose Brand",
          style: TextStyle(
            fontSize: 18,
            color: ConstantColor.splashContainerTitleColor,
          ),
        ),
        TextButton(
          onPressed: (){
            // TODO: when clicked view all categories
          },
          child: const Text(
            "View All",
            style: TextStyle(
              fontSize: 15,
              color: ConstantColor.splashContainerSubTitleColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget categoriesContainer(BuildContext context){
    BaseCategoriesDatasource baseCategoriesDatasource = CategoriesDatasource();
    BaseCategoriesRepository baseCategoriesRepository = CategoriesRepository(baseCategoriesDatasource);
    BaseCategoriesUseCase baseCategoriesUseCase = CategoriesUseCase(baseCategoriesRepository);
    return BlocProvider(
      create: (context) => CategoryBloc(baseCategoriesUseCase)..add(GetCategoryEvent()),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 60,
        child: BlocBuilder<CategoryBloc, ItemBlocState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            List<Category> listCategory = state is GetCategoryState? state.categoryList:[];
            return listCategory.isEmpty?const Center(child: CircularProgressIndicator(),):ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: listCategory.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 150,
                  height: 60,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: ConstantColor.categoriesBgColor,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: ConstantColor.categoriesBorderColor),
                  ),
                  child: InkWell(
                    onTap: (){
                      /// TODO: when click go to category details
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => CategoryDetailsPage(
                          imagePath: listCategory[index].image, cateName:listCategory[index].name))
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image(
                          image: NetworkImage(listCategory[index].image),
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              // image is loaded return image
                              return child;
                            } else{
                              return const Center(child: CircularProgressIndicator(),);
                            }
                          },
                          width: 60,
                          height: 60,
                        ),
                        Text(
                          listCategory[index].name,
                          style: const TextStyle(
                            color: ConstantColor.splashContainerTitleColor,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget newArrivalsHeader(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "New Arrival",
          style: TextStyle(
            fontSize: 18,
            color: ConstantColor.splashContainerTitleColor,
          ),
        ),
        TextButton(
          onPressed: (){
            // TODO: when clicked view all categories
          },
          child: const Text(
            "View All",
            style: TextStyle(
              fontSize: 15,
              color: ConstantColor.splashContainerSubTitleColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget itemsGridView(BuildContext context){
    BaseNewArrivalDatasource baseNewArrivalDatasource = NewArrivalDatasource();
    BaseNewArrivalRepository baseNewArrivalRepository = NewArrivalRepository(baseNewArrivalDatasource);
    BaseNewArrivalUseCase baseNewArrivalUseCase = NewArrivalUseCase(baseNewArrivalRepository);
    BaseWishlistDatasource baseWishlistDatasource = WishlistDatasource();
    BaseWishlistRepository baseWishlistRepository = WishlistRepository(baseWishlistDatasource);
    BaseWishlistUseCase baseWishlistUseCase = WishlistUseCase(baseWishlistRepository);
    return BlocProvider(
      create: (context) => ItemBloc(baseNewArrivalUseCase)..add(GetItemsDataEvent()),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 230,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: BlocBuilder<ItemBloc, ItemBlocState>(
          buildWhen: (previous, current) => previous != current,
          builder:(context, state) {
            List<Item> itemList = state is GetItemDataState?state.itemList:[];
            return itemList.isEmpty?const Center(child: CircularProgressIndicator(),):GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns in the grid
                  crossAxisSpacing: 10.0, // Spacing between columns
                  mainAxisSpacing: 10.0, // Spacing between rows
                  childAspectRatio: 0.6
              ),
              itemCount: itemList.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: ConstantColor.categoriesBgColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child:InkWell(
                    onTap: (){
                      // TODO: when clicked on any item go to item details page
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ItemDetailsPage(
                        item: Item(
                          name: itemList[index].name,
                          image: itemList[index].image,
                          price: itemList[index].price,
                          code: itemList[index].code
                        ),
                      ),));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Image(
                              image: NetworkImage(itemList[index].image),
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  // image is loaded return image
                                  return child;
                                } else{
                                  return const Center(child: CircularProgressIndicator(),);
                                }
                              },
                              width: double.infinity,
                              height: 150,
                              fit: BoxFit.fill,
                            ),
                            BlocProvider(
                              create: (context) => WishlistBloc(baseWishlistUseCase),
                              child: BlocBuilder<WishlistBloc, ItemBlocState>(
                                buildWhen: (previous, current) => previous != current,
                                builder: (context, state) {
                                  bool? result = state is AddWishlistItemState? state.result:null;
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 5, right: 5),
                                    child: IconButton(
                                      onPressed: () {
                                        // TODO: add event to add item in wishlist
                                        BlocProvider.of<WishlistBloc>(context).add(AddWishlistItemEvent(itemList[index]));
                                      },
                                      icon: const Icon(Icons.favorite, size: 35),
                                      color: result == true?ConstantColor.categoriesFavouriteActiveIconColor
                                                : ConstantColor.categoriesFavouriteUnActiveIconColor,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        Text(
                          itemList[index].name,
                          style: const TextStyle(
                            fontSize: 20,
                            color: ConstantColor.categoriesImageTitleColor,
                          ),
                        ),
                        Text(
                          itemList[index].price,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: ConstantColor.categoriesImageTitleColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

}


