import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/screens/main_page.dart';
import 'package:shopping_ecommerce_app/payment/presentation/controller/bloc.dart';
import 'package:shopping_ecommerce_app/payment/presentation/controller/bloc_event.dart';
import '../../data/datasource/payment_datasource.dart';
import '../../data/repository/payment_repository.dart';
import '../../domain/repository/base_payment_repository.dart';
import '../../domain/usecase/payment_usecase.dart';
import '../component/cards_page_body.dart';

class CardsPage extends StatelessWidget {
  const CardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    BasePaymentDatasource basePaymentDatasource = PaymentDatasource();
    BasePaymentRepository basePaymentRepository = PaymentRepository(basePaymentDatasource);
    BasePaymentUseCase basePaymentUseCase = PaymentUseCase(basePaymentRepository);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cards"),
        leading: IconButton(
          onPressed: () {
            // TODO: go to main page
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainPage(),));
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: BlocProvider(
        create: (context) => PaymentBloc(basePaymentUseCase)..add(GetAllCardsEvent()),
        child: const CardsPageBody()
      ),
    );
  }
}
