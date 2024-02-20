import 'package:flutter/material.dart';
import '../component/account_info_page_body.dart';

class AccountInfoPage extends StatelessWidget {
  const AccountInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const AccountInfoPageBody(),
    );
  }
}

