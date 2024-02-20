import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_ecommerce_app/main_content/data/datasource/user_info_datasource.dart';
import 'package:shopping_ecommerce_app/main_content/data/repository/user_info_repository.dart';
import 'package:shopping_ecommerce_app/main_content/domain/repository/base_user_info_repository.dart';
import 'package:shopping_ecommerce_app/main_content/domain/usecase/user_info_usecase.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/controller/user_info_bloc.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/controller/user_info_bloc_event.dart';

import '../component/show_password_page_body.dart';

class ShowPasswordPage extends StatelessWidget {
  const ShowPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    BaseUserInfoDatasource baseUserInfoDatasource = UserInfoDatasource();
    BaseUserInfoRepository baseUserInfoRepository = UserInfoRepository(baseUserInfoDatasource);
    BaseUserInfoUseCase baseUserInfoUseCase = UserInfoUseCase(baseUserInfoRepository);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Password"),
      ),
      body: BlocProvider(
        create: (context) => UserInfoBloc(baseUserInfoUseCase)..add(GetUserInfoEvent()),
        child: const ShowPasswordPageBody()
      ),
    );
  }
}

