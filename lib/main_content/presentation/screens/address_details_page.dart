import 'package:flutter/material.dart';

import '../component/address_details_page_body.dart';

class AddressDetailsPage extends StatelessWidget {
  const AddressDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Address"),
      ),
      body: AddressDetailsPageBody(),
    );
  }
}

