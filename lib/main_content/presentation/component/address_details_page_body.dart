import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_ecommerce_app/main_content/data/datasource/address_datasource.dart';
import 'package:shopping_ecommerce_app/main_content/data/repository/address_repository.dart';
import 'package:shopping_ecommerce_app/main_content/domain/entity/address.dart';
import 'package:shopping_ecommerce_app/main_content/domain/repository/base_address_repository.dart';
import 'package:shopping_ecommerce_app/main_content/domain/usecase/address_usecase.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/controller/bloc.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/controller/bloc_event.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/controller/bloc_state.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/screens/cart_page.dart';
import '../../../core/constant_color.dart';


class AddressDetailsPageBody extends StatelessWidget {
  AddressDetailsPageBody({super.key});

  final StreamController<bool> _controller = StreamController<bool>.broadcast();
  final List<TextEditingController> textEditingControllerList = List.generate(5, (index) => TextEditingController());
  final _formKey = GlobalKey<FormState>();

  Stream<bool> changeSwitch(){
    return _controller.stream;
  }

  @override
  Widget build(BuildContext context) {
    bool isPrimaryAddress = false;
    BaseAddressDatasource baseAddressDatasource = AddressDatasource();
    BaseAddressRepository baseAddressRepository = AddressRepository(baseAddressDatasource);
    BaseAddressUseCase baseAddressUseCase = AddressUseCase(baseAddressRepository);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: [
          Column(
            children: [
              // register new address
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // username
                    createTextFormField("Name", textEditingControllerList[0]),
                    const SizedBox(height: 15,),
                    // Country and city
                    Row(
                      children: [
                        Expanded(child: createTextFormField("Country", textEditingControllerList[1])),
                        const SizedBox(width: 20,),
                        Expanded(child: createTextFormField("City", textEditingControllerList[2])),
                      ],
                    ),
                    const SizedBox(height: 15,),
                    // Phone Number
                    createTextFormField("Phone Number", textEditingControllerList[3]),
                    const SizedBox(height: 15,),
                    // Address
                    createTextFormField("Address", textEditingControllerList[4]),
                    const SizedBox(height: 15,),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              // toggle button for save as primary address
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "save as primary address",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  StreamBuilder(
                    stream: changeSwitch(),
                    builder: (context, snapshot) {
                      isPrimaryAddress = snapshot.data ?? false;
                      return Switch(
                        value: snapshot.data ?? false,
                        onChanged: (value) {
                          _controller.add(value);
                        },
                        activeColor: const Color(0xFF32CA5B),
                        thumbColor: const MaterialStatePropertyAll(Colors.white),
                        inactiveTrackColor: Colors.black12,
                        trackOutlineColor: const MaterialStatePropertyAll(Colors.black12),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 50,),
          // button to save address
          BlocProvider(
            create: (context) => AddressBloc(baseAddressUseCase),
            child: BlocBuilder<AddressBloc, ItemBlocState>(
              buildWhen: (previous, current) => previous != current,
              builder: (context, state) {
                if(state is AddAddressDataState){
                  if(state.result == true){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                      return CartPage(
                        address: textEditingControllerList[4].text.trim(),
                        city: textEditingControllerList[2].text.trim(),
                      );
                    },));
                  }
                }
                return InkWell(
                  onTap: (){
                    // TODO: when click on it save the address data
                    if(_formKey.currentState!.validate()){
                      BlocProvider.of<AddressBloc>(context).add(AddAddressDataEvent(Address(
                          name: textEditingControllerList[0].text.trim(),
                          country: textEditingControllerList[1].text.trim(),
                          city: textEditingControllerList[2].text.trim(),
                          phoneNumber: textEditingControllerList[3].text.trim(),
                          address: textEditingControllerList[4].text.trim(),
                          saveAddress: isPrimaryAddress
                      )));
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Error: complete all fields")));
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width-50,
                    height: 70,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: ConstantColor.splashGgColor,
                    ),
                    child: const Text(
                      "save address",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget createTextFormField(String labelName, TextEditingController textEditingController){
    return TextFormField(
      controller: textEditingController,
      validator: (value) {
        if(value!.isEmpty){
          return "complete all fields";
        }
      },
      decoration: InputDecoration(
        label: Text(labelName),
        labelStyle: const TextStyle(color: ConstantColor.splashContainerSubTitleColor, fontSize: 20),
        border: InputBorder.none,
        fillColor: const Color(0xFFF5F6FA),
        filled: true,
      ),
      style: const TextStyle(fontSize: 20),
    );
  }
}

