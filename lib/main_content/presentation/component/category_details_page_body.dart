import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_ecommerce_app/core/constant_color.dart';
import 'package:shopping_ecommerce_app/main_content/domain/entity/item.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/controller/bloc.dart';
import '../controller/bloc_state.dart';
import '../screens/item_details_page.dart';

class CategoryDetailsPageBody extends StatelessWidget {
  final String cateName;
  CategoryDetailsPageBody({super.key, required this.cateName});

  List<bool> allFavouriteSelected = [false,false,false,false,false,false,false,false,false,false,false,false];
  final List<StreamController<bool>> _controllerList = List.generate(12, (index) => StreamController<bool>.broadcast());

  Stream<bool> changeFavouriteValue(int index){
    return _controllerList[index].stream;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, ItemBlocState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        List<Item> itemsList = state is GetItemDataState?state.itemList:[];
        return itemsList.isEmpty?const Center(child: CircularProgressIndicator(),):Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // item count
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${itemsList.length} items", style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w700),),
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

                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: remainingHeight*0.75,
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
                      itemCount: itemsList.length,
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
                                  name: itemsList[index].name,
                                  image: itemsList[index].image,
                                  price: itemsList[index].price,
                                  code: itemsList[index].code
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
                                    itemsList.isEmpty?const Center(child: CircularProgressIndicator(),):Image(
                                      image: NetworkImage(itemsList[index].image),
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
                                      fit: BoxFit.cover,
                                    ),
                                    StreamBuilder(
                                      stream: changeFavouriteValue(index),
                                      builder: (context, snapshot) {
                                        bool currentValue = snapshot.data ?? false;
                                        return Padding(
                                          padding: const EdgeInsets.only(top: 10, right: 10),
                                          child: IconButton(
                                            onPressed: () {
                                              allFavouriteSelected[index] = !allFavouriteSelected[index];
                                              _controllerList[index].add(allFavouriteSelected[index]);
                                            },
                                            icon: const Icon(Icons.favorite, size: 35),
                                            color: currentValue ? ConstantColor.categoriesFavouriteActiveIconColor
                                                : ConstantColor.categoriesFavouriteUnActiveIconColor,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                itemsList.isEmpty?const Center(child: CircularProgressIndicator(),):Text(
                                  itemsList[index].name,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: ConstantColor.categoriesImageTitleColor,
                                  ),
                                ),
                                itemsList.isEmpty?const Center(child: CircularProgressIndicator(),):Text(
                                  itemsList[index].price,
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
          ),
        );
      },
    );
  }
}
