import 'package:flutter/material.dart';
import 'package:shopping_ecommerce_app/spash_screen/component/splash_body.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).splashColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).splashColor,
          body: const SplashBody(),
        ),
      ),
    );
  }
}
