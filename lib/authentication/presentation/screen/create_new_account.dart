import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_ecommerce_app/authentication/presentation/controller/authentication_bloc.dart';

import '../../data/datasource/create_new_account_datasource.dart';
import '../../data/repository/create_new_account_repository.dart';
import '../../domain/repository/base_create_new_account_repository.dart';
import '../../domain/usecase/create_new_account_usecase.dart';
import '../component/create_new_account_body.dart';

class CreateNewAccount extends StatelessWidget {
  const CreateNewAccount({super.key});

  @override
  Widget build(BuildContext context) {
    BaseCreateNewAccountDataSource baseCreateNewAccountDataSource = CreateNewAccountDataSource();
    BaseCreateNewAccountRepository baseCreateNewAccountRepository = CreateNewAccountRepository(baseCreateNewAccountDataSource: baseCreateNewAccountDataSource);
    BaseCreateNewAccountUserCase baseCreateNewAccountUserCase=CreateNewAccountUseCase(baseCreateNewAccountRepository: baseCreateNewAccountRepository);
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => CreateNewAccountBloc(baseCreateNewAccountUserCase),
        child: CreateNewAccountBody()
      ),
    );
  }
}


