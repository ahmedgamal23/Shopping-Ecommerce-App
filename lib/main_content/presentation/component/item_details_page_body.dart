import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_ecommerce_app/core/constant_color.dart';
import 'package:shopping_ecommerce_app/main_content/domain/entity/item.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/controller/bloc.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/controller/bloc_event.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/controller/bloc_state.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/screens/review_page.dart';

class ItemDetailsPageBody extends StatelessWidget {
  final Item item;
  ItemDetailsPageBody({super.key, required this.item});
  int rating=0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height - 180,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // stack
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Image(
                        image: NetworkImage(item.image),
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            // image is loaded return image
                            return child;
                          } else{
                            return const Center(child: CircularProgressIndicator(),);
                          }
                        }
                      ),
                      IconButton(
                        onPressed: (){
                          // TODO: when user clicked go to card page
                        },
                        icon: const Icon(Icons.card_travel, size: 30,),
                      ),
                    ],
                  ),

                  // text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Men's Printed Pullover Hoodie",
                            style: TextStyle(
                              fontSize: 12,
                              color: ConstantColor.splashContainerSubTitleColor,
                            ),
                          ),
                          Text(
                            item.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: ConstantColor.splashContainerTitleColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Price",
                            style: TextStyle(
                              fontSize: 15,
                              color: ConstantColor.splashContainerSubTitleColor,
                            ),
                          ),
                          Text(
                            item.price,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: ConstantColor.splashContainerTitleColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // parts from image
                  Container(
                    width: double.infinity,
                    height: 100,
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: (MediaQuery.of(context).size.width-50)/4,
                          height: 80,
                          child: const Image(
                            image: AssetImage("assets/images/facebook.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(
                          width: (MediaQuery.of(context).size.width-50)/4,
                          height: 80,
                          child: const Image(
                            image: AssetImage("assets/images/facebook.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(
                          width: (MediaQuery.of(context).size.width-50)/4,
                          height: 80,
                          child: const Image(
                            image: AssetImage("assets/images/facebook.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(
                          width: (MediaQuery.of(context).size.width-50)/4,
                          height: 80,
                          child: const Image(
                            image: AssetImage("assets/images/facebook.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // text
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Size",
                        style: TextStyle(
                          fontSize: 20,
                          color: ConstantColor.splashContainerTitleColor,
                        ),
                      ),
                      Text(
                        "View All",
                        style: TextStyle(
                          fontSize: 18,
                          color: ConstantColor.splashContainerSubTitleColor,
                        ),
                      ),
                    ],
                  ),

                  // sized available
                  Container(
                    width: double.infinity,
                    height: 50,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: (MediaQuery.of(context).size.width-50)/5,
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: ConstantColor.searchColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            "S",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Container(
                          width: (MediaQuery.of(context).size.width-50)/5,
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: ConstantColor.searchColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            "M",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Container(
                          width: (MediaQuery.of(context).size.width-50)/5,
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: ConstantColor.searchColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            "L",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Container(
                          width: (MediaQuery.of(context).size.width-50)/5,
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: ConstantColor.searchColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            "XL",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Container(
                          width: (MediaQuery.of(context).size.width-50)/5,
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: ConstantColor.searchColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            "2XL",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10,),
                  // description
                  const Text("Description", style: TextStyle(fontSize: 25, ),),
                  const Text(
                    "The Nike Throwback Pullover Hoodie is made from premium French terry fabric that blends a performance feel with Read More..",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 10,),
                  // text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Reviews",
                        style: TextStyle(
                          fontSize: 20,
                          color: ConstantColor.splashContainerTitleColor,
                        ),
                      ),
                      TextButton(
                        onPressed: (){
                          // TODO: when clicked on view all reviews go to review page
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ReviewPage(),));
                        },
                        child: const Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 18,
                            color: ConstantColor.splashContainerSubTitleColor,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // review parts
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Image(image: AssetImage("assets/images/twitter.png"), width: 50, height: 50),
                          const SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Ronald Richards", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                              Row(
                                children: [
                                  const Icon(Icons.access_time, size: 10,),
                                  Text("${DateTime.now()}", style: const TextStyle(fontSize: 10),),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Text("4.8", style: TextStyle(fontWeight: FontWeight.bold),),
                              SizedBox(width: 2,),
                              Text("rating"),
                            ],
                          ),
                          Row(
                            children: List.generate(5, (index) {
                              return GestureDetector(
                                child: Icon(
                                  index < 4 ? Icons.star : Icons.star_border,
                                  color: Colors.amber,
                                  size: 10,
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // text review Comment
                  const Text(
                    "Lorem ipsum dolor sit amet, consecrate adipiscing elite. Interpellates malesuada get vitae amet...",
                    style: TextStyle(
                      color: ConstantColor.splashContainerSubTitleColor,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 20,),
                ],
              ),
            ),
          ),

          // button to add to cart
          BlocBuilder<CartBloc, ItemBlocState>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) {
              return InkWell(
                onTap: (){
                  // TODO: when click on it add this item to cart
                  BlocProvider.of<CartBloc>(context).add(
                    AddCartEvent(
                      Item(
                        name: item.name,
                        image: item.image,
                        price: item.price,
                        code: item.code
                      )
                    )
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width-50,
                  height: 70,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: state is ItemBlocSuccess?Colors.red:ConstantColor.splashGgColor,
                  ),
                  child: Text(
                    state is ItemBlocSuccess?"cart is added":"Add to cart",
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

