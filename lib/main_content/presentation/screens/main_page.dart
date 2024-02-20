import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_ecommerce_app/main_content/data/datasource/user_info_datasource.dart';
import 'package:shopping_ecommerce_app/main_content/data/repository/user_info_repository.dart';
import 'package:shopping_ecommerce_app/main_content/domain/repository/base_user_info_repository.dart';
import 'package:shopping_ecommerce_app/main_content/domain/usecase/user_info_usecase.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/component/drawer_page.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/controller/user_info_bloc.dart';
import '../component/bottom_navigation_component.dart';
import '../component/main_page_body.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    BaseUserInfoDatasource baseUserInfoDatasource = UserInfoDatasource();
    BaseUserInfoRepository baseUserInfoRepository = UserInfoRepository(baseUserInfoDatasource);
    BaseUserInfoUseCase baseUserInfoUseCase = UserInfoUseCase(baseUserInfoRepository);
    return BlocProvider(
      create: (context) => UserInfoBloc(baseUserInfoUseCase),
      child: Scaffold(
        key: scaffoldKey,
        drawer: DrawerPage(scaffoldKey: scaffoldKey),
        bottomNavigationBar: BottomNavigationComponent(ind: 0),
        body: MainPageBody(scaffoldKey: scaffoldKey),
      ),
    );
  }

}

