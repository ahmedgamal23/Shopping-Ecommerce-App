import 'package:flutter/material.dart';
import '../component/bottom_navigation_component.dart';
import '../component/wishlist_page_body.dart';


class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wishlist"),
        actions: const [
          Icon(Icons.card_travel),
          SizedBox(width: 5,),
        ],
      ),
      bottomNavigationBar: BottomNavigationComponent(ind: 1),
      body: const WishlistPageBody(),
    );
  }
}

