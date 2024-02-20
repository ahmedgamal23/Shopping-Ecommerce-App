import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_ecommerce_app/main_content/data/datasource/address_datasource.dart';
import 'package:shopping_ecommerce_app/main_content/data/repository/address_repository.dart';
import 'package:shopping_ecommerce_app/main_content/domain/repository/base_address_repository.dart';
import 'package:shopping_ecommerce_app/main_content/domain/usecase/address_usecase.dart';
import '../component/address_details_page_body.dart';
import '../controller/bloc.dart';

class AddressDetailsPage extends StatelessWidget {
  const AddressDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    BaseAddressDatasource baseAddressDatasource = AddressDatasource();
    BaseAddressRepository baseAddressRepository = AddressRepository(baseAddressDatasource);
    BaseAddressUseCase baseAddressUseCase = AddressUseCase(baseAddressRepository);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Address"),
      ),
      body: BlocProvider(
        create: (context) => AddressBloc(baseAddressUseCase),
        child: AddressDetailsPageBody()
      ),
    );
  }
}

