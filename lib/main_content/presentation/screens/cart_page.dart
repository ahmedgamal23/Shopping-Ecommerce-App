import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_ecommerce_app/main_content/data/datasource/cart_datasource.dart';
import 'package:shopping_ecommerce_app/main_content/data/repository/cart_repository.dart';
import 'package:shopping_ecommerce_app/main_content/domain/repository/base_cart_repository.dart';
import 'package:shopping_ecommerce_app/main_content/domain/usecase/cart_usecase.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/controller/bloc.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/controller/bloc_event.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/screens/main_page.dart';

import '../component/cart_page_body.dart';

class CartPage extends StatelessWidget {
  String? address;
  String? city;
  CartPage({super.key, this.address, this.city});

  @override
  Widget build(BuildContext context) {
    BaseCartDatasource baseCartDatasource = CartDatasource();
    BaseCartRepository baseCartRepository = CartRepository(baseCartDatasource);
    BaseCartUseCase baseCartUseCase = CartUseCase(baseCartRepository);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        leading: IconButton(
          onPressed: () {
            // TODO: go to main page
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainPage(),));
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: BlocProvider(
        create: (context) => CartBloc(baseCartUseCase)..add(GetAllCartEvent()),
        child: CartPageBody(address: address, city: city,)
      ),
    );
  }
}

