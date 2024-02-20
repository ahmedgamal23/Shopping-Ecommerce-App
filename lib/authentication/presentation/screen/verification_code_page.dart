import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_ecommerce_app/authentication/data/datasource/check_code_datasource.dart';
import 'package:shopping_ecommerce_app/authentication/data/repository/check_code_repository.dart';
import 'package:shopping_ecommerce_app/authentication/domain/repository/base_check_code_repository.dart';
import 'package:shopping_ecommerce_app/authentication/domain/usecase/check_code_usecase.dart';
import 'package:shopping_ecommerce_app/authentication/presentation/controller/reset_password_bloc.dart';
import '../../data/datasource/resend_code_datasource.dart';
import '../../data/repository/resend_code_repository.dart';
import '../../domain/repository/base_resend_code_repository.dart';
import '../../domain/usecase/resend_code_usecase.dart';
import '../component/verification_code_page_body.dart';

class VerificationCodePage extends StatelessWidget {
  final String email;
  const VerificationCodePage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    BaseCheckCodeDatasource baseCheckCodeDatasource = CheckCodeDatasource();
    BaseCheckCodeRepository baseCheckCodeRepository = CheckCodeRepository(baseCheckCodeDatasource);
    BaseCheckCodeUseCase baseCheckCodeUseCase = CheckCodeUseCase(baseCheckCodeRepository);
    BaseResendCodeDatasource baseResendCodeDatasource = ResendCodeDatasource();
    BaseResendCodeRepository baseResendCodeRepository = ResendCodeRepository(baseResendCodeDatasource);
    BaseResendCodeUseCase baseResendCodeUseCase = ResendCodeUseCase(baseResendCodeRepository);
    return BlocProvider(
      create: (context) => ResendCodeBloc(baseResendCodeUseCase),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocProvider(
          create: (context) => CheckCodeBloc(baseCheckCodeUseCase),
          child: VerificationCodePageBody(email: email,)
        ),
      ),
    );
  }
}

