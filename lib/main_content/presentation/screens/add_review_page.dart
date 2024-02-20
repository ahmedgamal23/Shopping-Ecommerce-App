import 'package:flutter/material.dart';

import '../component/add_review_page_body.dart';

class AddReviewPage extends StatelessWidget {
  const AddReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Review"),
      ),
      body: AddReviewPageBody(),
    );
  }
}


