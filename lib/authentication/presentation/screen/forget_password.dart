import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_ecommerce_app/authentication/data/datasource/check_email_datasource.dart';
import 'package:shopping_ecommerce_app/authentication/data/repository/check_email_repository.dart';
import 'package:shopping_ecommerce_app/authentication/domain/repository/base_check_email_repository.dart';
import 'package:shopping_ecommerce_app/authentication/domain/usecase/check_email_usecase.dart';
import 'package:shopping_ecommerce_app/authentication/presentation/controller/reset_password_bloc.dart';

import '../component/forget_password_body.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    BaseCheckEmailDatasource baseCheckEmailDatasource = CheckEmailDatasource();
    BaseCheckEmailRepository baseCheckEmailRepository = CheckEmailRepository(baseCheckEmailDatasource);
    BaseCheckEmailUseCase baseCheckEmailUseCase = CheckEmailUseCase(baseCheckEmailRepository);
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => CheckEmailBloc(baseCheckEmailUseCase),
        child: ForgetPasswordBody()
      ),
    );
  }
}

