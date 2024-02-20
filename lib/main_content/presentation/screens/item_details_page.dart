import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_ecommerce_app/main_content/data/datasource/cart_datasource.dart';
import 'package:shopping_ecommerce_app/main_content/data/repository/cart_repository.dart';
import 'package:shopping_ecommerce_app/main_content/domain/entity/item.dart';
import 'package:shopping_ecommerce_app/main_content/domain/repository/base_cart_repository.dart';
import 'package:shopping_ecommerce_app/main_content/domain/usecase/cart_usecase.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/controller/bloc.dart';

import '../component/item_details_page_body.dart';
import '../controller/bloc_event.dart';

class ItemDetailsPage extends StatelessWidget {
  final Item item;
  const ItemDetailsPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    BaseCartDatasource baseCartDatasource = CartDatasource();
    BaseCartRepository baseCartRepository = CartRepository(baseCartDatasource);
    BaseCartUseCase baseCartUseCase = CartUseCase(baseCartRepository);
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => CartBloc(baseCartUseCase)..add(
          CheckCartEvent(item.code)
        ),
        child: ItemDetailsPageBody(item: item,)
      ),
    );
  }
}

