import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_ecommerce_app/authentication/data/datasource/login_datasource.dart';
import 'package:shopping_ecommerce_app/authentication/data/repository/login_repository.dart';
import 'package:shopping_ecommerce_app/authentication/domain/repository/base_login_repository.dart';
import 'package:shopping_ecommerce_app/authentication/domain/usecase/login_usecase.dart';
import 'package:shopping_ecommerce_app/authentication/presentation/controller/authentication_bloc.dart';

import '../component/login_page_body.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    BaseLoginDatasource baseLoginDatasource = LoginDatasource();
    BaseLoginRepository baseLoginRepository = LoginRepository(baseLoginDatasource);
    BaseLoginUseCase baseLoginUseCase = LoginUseCase(baseLoginRepository);
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => LoginBloc(baseLoginUseCase),
        child: LoginPageBody()
      ),
    );
  }
}

