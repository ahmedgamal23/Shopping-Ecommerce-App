import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_ecommerce_app/authentication/data/datasource/new_password_datasource.dart';
import 'package:shopping_ecommerce_app/authentication/data/repository/new_password_repository.dart';
import 'package:shopping_ecommerce_app/authentication/domain/repository/base_new_password_repository.dart';
import 'package:shopping_ecommerce_app/authentication/domain/usecase/new_password_usecase.dart';
import 'package:shopping_ecommerce_app/authentication/presentation/controller/reset_password_bloc.dart';

import '../component/new_password_page_body.dart';

class NewPasswordPage extends StatelessWidget {
  final String email;
  const NewPasswordPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    BaseNewPasswordDatasource baseNewPasswordDatasource = NewPasswordDatasource();
    BaseNewPasswordRepository baseNewPasswordRepository = NewPasswordRepository(baseNewPasswordDatasource);
    BaseNewPasswordUseCase baseNewPasswordUseCase = NewPasswordUseCase(baseNewPasswordRepository);
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => NewPasswordBloc(baseNewPasswordUseCase),
        child: NewPasswordPageBody(email: email,)
      ),
    );
  }
}

