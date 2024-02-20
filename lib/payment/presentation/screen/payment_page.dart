import 'package:flutter/material.dart';
import '../../../main_content/domain/entity/item.dart';
import '../component/payment_page_body.dart';

class PaymentPage extends StatelessWidget {
  final double price;
  const PaymentPage({super.key, required this.price,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        title: const Text("Payment"),
      ),
      body: PaymentPageBody(price: price),
    );
  }
}


