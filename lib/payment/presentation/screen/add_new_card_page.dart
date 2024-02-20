import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/datasource/payment_datasource.dart';
import '../../data/repository/payment_repository.dart';
import '../../domain/repository/base_payment_repository.dart';
import '../../domain/usecase/payment_usecase.dart';
import '../component/add_new_card_page_body.dart';
import '../controller/bloc.dart';

class AddNewCardPage extends StatelessWidget {
  const AddNewCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    BasePaymentDatasource basePaymentDatasource = PaymentDatasource();
    BasePaymentRepository basePaymentRepository = PaymentRepository(basePaymentDatasource);
    BasePaymentUseCase basePaymentUseCase = PaymentUseCase(basePaymentRepository);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Card"),
      ),
      body: BlocProvider(
        create: (context) => PaymentBloc(basePaymentUseCase),
        child: AddNewCardPageBody()
      ),
    );
  }
}


