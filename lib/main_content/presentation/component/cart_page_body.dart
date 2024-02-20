import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_ecommerce_app/core/constant_color.dart';
import 'package:shopping_ecommerce_app/main_content/domain/entity/address.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/controller/bloc.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/controller/bloc_event.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/controller/bloc_state.dart';
import '../../../payment/presentation/screen/payment_page.dart';
import '../../data/datasource/address_datasource.dart';
import '../../data/repository/address_repository.dart';
import '../../domain/entity/item.dart';
import '../../domain/repository/base_address_repository.dart';
import '../../domain/usecase/address_usecase.dart';
import '../screens/address_details_page.dart';


class CartPageBody extends StatelessWidget {
  String? address;
  String? city;
  CartPageBody({super.key,this.address, this.city});

  double price=0;

  @override
  Widget build(BuildContext context) {

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // list view
          listViewBody(context),
          // Delivery address
          deliveryAddress(context),
          // set address
          setAddress(context),
          // Payment Method
          paymentMethod(context),
          // set payment
          setPayment(context),
        ],
      ),
    );
  }

  Widget listViewBody(BuildContext context){
    return BlocBuilder<CartBloc, ItemBlocState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if(state is RemoveCartItemState){
          /// TODO: when click add cart event again
          BlocProvider.of<CartBloc>(context).add(GetAllCartEvent());
        }
        List<Item> itemList = state is GetAllCartState?state.itemList:[];
        return Container(
          width: MediaQuery.of(context).size.width,
          height: (MediaQuery.of(context).size.height-150)/2,
          decoration: const BoxDecoration(

          ),
          child: itemList.isEmpty?const Center(child: CircularProgressIndicator(),):ListView.builder(
            itemCount: itemList.length,
            itemBuilder: (context, index) {
              price = price + double.parse(itemList[index].price.substring(1));
              return Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEFEFE),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    // image
                    itemList[index].image.isEmpty?const Center(child: CircularProgressIndicator(),):Container(
                      width: MediaQuery.of(context).size.width*0.25,
                      height: 120,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(itemList[index].image),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    // column
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // title
                          Text(
                            itemList[index].name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          // price
                          Text(
                            itemList[index].price,
                            style: const TextStyle(
                              fontSize: 14,
                              color: ConstantColor.splashContainerSubTitleColor,
                            ),
                          ),
                          // Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // item count
                              Builder(
                                builder: (context) {
                                  return Row(
                                    children: [
                                      // button decrease counter
                                      IconButton(
                                        onPressed: (){
                                          /// TODO: when click decrease counter
                                        },
                                        icon: const Icon(Icons.keyboard_arrow_down_outlined),
                                        style: const ButtonStyle(
                                          backgroundColor: MaterialStatePropertyAll(Color(0xFFFEFEFE)),
                                          side: MaterialStatePropertyAll(BorderSide(color: Color(0xFFE6E6E6))),
                                        ),
                                      ),
                                      const SizedBox(width: 4,),
                                      // Counter
                                      const Text(
                                        "1",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      const SizedBox(width: 4,),
                                      // button increase counter
                                      IconButton(
                                        onPressed: (){
                                          /// TODO: when click increase counter
                                        },
                                        icon: const Icon(Icons.keyboard_arrow_up_outlined),
                                        style: const ButtonStyle(
                                          backgroundColor: MaterialStatePropertyAll(Color(0xFFFEFEFE)),
                                          side: MaterialStatePropertyAll(BorderSide(color: Color(0xFFE6E6E6))),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              // remove item
                              IconButton(
                                onPressed: (){
                                  /// TODO: when click remove this item
                                  BlocProvider.of<CartBloc>(context).add(RemoveCartItemEvent(itemList[index].code));
                                },
                                icon: const Icon(Icons.delete_outline),
                                style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(Color(0xFFFEFEFE)),
                                  side: MaterialStatePropertyAll(BorderSide(color: Color(0xFFE6E6E6))),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget deliveryAddress(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Delivery Address",
          style: TextStyle(
            fontSize: 18,
            color: ConstantColor.splashContainerTitleColor,
          ),
        ),
        IconButton(
          onPressed: (){
            // TODO: when clicked go to address details page
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddressDetailsPage(),));
          },
          icon: const Icon(Icons.arrow_forward_ios_outlined, size: 18,),
        ),
      ],
    );
  }

  Widget setAddress(BuildContext context){
    BaseAddressDatasource baseAddressDatasource = AddressDatasource();
    BaseAddressRepository baseAddressRepository = AddressRepository(baseAddressDatasource);
    BaseAddressUseCase baseAddressUseCase = AddressUseCase(baseAddressRepository);
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: BlocProvider(
        create: (context) => AddressBloc(baseAddressUseCase)..add(GetAddressDataEvent()),
        child: BlocBuilder<AddressBloc, ItemBlocState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            Address? addressData = state is GetAddressDataState? state.address:null;
            address = address ?? "address";
            city = city ?? "city";
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Image(image: AssetImage("assets/images/googleMaps.jpg"),width: 80,height: 80, fit: BoxFit.fill),
                    const SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          address == null?addressData!.address:address!,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          city == null?addressData!.city:city!,
                          style: const TextStyle(
                            fontSize: 18,
                            color: ConstantColor.splashContainerSubTitleColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Image(
                  image: AssetImage(
                      (address == null || address == "address") &&
                          addressData == null?"assets/images/cross.png":"assets/images/accept.png"
                  ),
                  width: 20,
                  height: 20,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget paymentMethod(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Payment Method",
          style: TextStyle(
            fontSize: 18,
            color: ConstantColor.splashContainerTitleColor,
          ),
        ),
        IconButton(
          onPressed: (){
            // TODO: when clicked go to payment details page
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaymentPage(price: price),));
          },
          icon: const Icon(Icons.arrow_forward_ios_outlined, size: 18,),
        ),
      ],
    );
  }

  Widget setPayment(BuildContext context){
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image(image: AssetImage("assets/images/visa.png"),width: 80,height: 80, fit: BoxFit.fill),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Visa Classic",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "**** 7690",
                    style: TextStyle(
                      fontSize: 18,
                      color: ConstantColor.splashContainerSubTitleColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

