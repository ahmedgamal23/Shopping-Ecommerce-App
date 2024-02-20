import 'package:flutter/material.dart';

import '../component/order_confirmed_page_body.dart';

class OrderConfirmedPage extends StatelessWidget {
  const OrderConfirmedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: OrderConfirmedPageBody(),
    );
  }
}

