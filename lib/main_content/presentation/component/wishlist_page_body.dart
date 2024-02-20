import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_ecommerce_app/main_content/domain/entity/item.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/controller/bloc.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/controller/bloc_event.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/controller/bloc_state.dart';
import '../../../core/constant_color.dart';
import '../../data/datasource/wishlist_datsource.dart';
import '../../data/repository/wishlist_repository.dart';
import '../../domain/repository/base_wishlist_repository.dart';
import '../../domain/usecase/wishlist_usecase.dart';
import '../screens/item_details_page.dart';

class WishlistPageBody extends StatelessWidget {
  const WishlistPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    BaseWishlistDatasource baseWishlistDatasource = WishlistDatasource();
    BaseWishlistRepository baseWishlistRepository = WishlistRepository(baseWishlistDatasource);
    BaseWishlistUseCase baseWishlistUseCase = WishlistUseCase(baseWishlistRepository);
    return Container(
      padding: const EdgeInsets.all(20),
      child: BlocProvider(
        create: (context) => WishlistBloc(baseWishlistUseCase)..add(GetAllWishlistItemsEvent()),
        child: BlocBuilder<WishlistBloc, ItemBlocState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            if(state is RemoveWishlistItemState){
              BlocProvider.of<WishlistBloc>(context).add(GetAllWishlistItemsEvent());
            }
            List<Item> listItem = state is GetAllWishlistItemsState?state.listItems:[];
            return listItem.isEmpty?const Center(child: CircularProgressIndicator(),):Column(
              children: [
                // item count
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${listItem.length} items", style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w700),),
                        const Text("Available in stock", style: TextStyle(color: ConstantColor.splashContainerSubTitleColor),),
                      ],
                    ),
                    Container(
                      width: 80,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F6FA),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.filter_list),
                          SizedBox(width: 5,),
                          Text("Sort", style: TextStyle(fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                // items
                LayoutBuilder(
                  builder: (context, constraints) {
                    double screenHeight = MediaQuery.of(context).size.height;
                    double remainingHeight = screenHeight - constraints.minHeight;

                    return listItem.isEmpty?const Center(child: Text("No data found"),):Container(
                      width: MediaQuery.of(context).size.width,
                      height: remainingHeight*0.65,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Number of columns in the grid
                            crossAxisSpacing: 10.0, // Spacing between columns
                            mainAxisSpacing: 10.0, // Spacing between rows
                            childAspectRatio: 0.6
                        ),
                        itemCount: listItem.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              color: ConstantColor.categoriesBgColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: InkWell(
                              onTap: (){
                                // TODO: when clicked on any item go to item details page
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ItemDetailsPage(
                                  item: Item(
                                      image: listItem[index].image,
                                      name: listItem[index].name,
                                      price: listItem[index].price,
                                      code: listItem[index].code
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
                                        image: NetworkImage(listItem[index].image),
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
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5, right: 5),
                                        child: IconButton(
                                          onPressed: () {
                                            // TODO: Remove item from wishlist
                                            BlocProvider.of<WishlistBloc>(context).add(RemoveWishlistItemEvent(listItem[index].code));
                                          },
                                          icon: const Icon(Icons.favorite, size: 35),
                                          color: ConstantColor.categoriesFavouriteActiveIconColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    listItem[index].name,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: ConstantColor.categoriesImageTitleColor,
                                    ),
                                  ),
                                  Text(
                                    listItem[index].price,
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
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

