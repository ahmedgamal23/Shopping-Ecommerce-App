import 'package:flutter/material.dart';
import '../component/welcome_page_body.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      //backgroundColor: Color(0xFFFFFFFF),
      body: WelcomePageBody(),
    );
  }
}

