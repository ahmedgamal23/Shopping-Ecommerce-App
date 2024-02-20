import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shopping_ecommerce_app/payment/presentation/screen/cards_page.dart';
import '../../../core/constant_color.dart';
import '../screens/cart_page.dart';
import '../screens/main_page.dart';
import '../screens/wishlist_page.dart';

class BottomNavigationComponent extends StatelessWidget {
  final int ind;
  BottomNavigationComponent({super.key, required this.ind});

  final StreamController<int> _controller = StreamController<int>.broadcast();

  Stream<int> updateIndex(){
    return _controller.stream;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: updateIndex(),
      builder: (context, snapshot) {
        int currentIndex = snapshot.data ?? ind;
        return BottomNavigationBar(
          currentIndex: currentIndex,
          type: BottomNavigationBarType.shifting,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (value) {
            _controller.add(value);
            if(value == 0){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainPage(),));
            }
            else if(value == 1){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const WishlistPage(),));
            }
            else if(value == 2){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => CartPage(),));
            }
            else if(value == 3){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const CardsPage(),));
            }
          },
          items: [
            // Home
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: currentIndex == 0 ? ConstantColor.bottomNavigationActiveColor :
              ConstantColor.bottomNavigationUnActiveColor,),
              label: "Home",
            ),
            // favourite
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_outlined, color: currentIndex == 1 ? ConstantColor.bottomNavigationActiveColor :
              ConstantColor.bottomNavigationUnActiveColor,),
              label: "wishlist",
            ),
            // cart
            BottomNavigationBarItem(
              icon: Icon(Icons.card_travel, color: currentIndex == 2 ? ConstantColor.bottomNavigationActiveColor :
              ConstantColor.bottomNavigationUnActiveColor,),
              label: "cart",
            ),
            // wallet
            BottomNavigationBarItem(
              icon: Icon(Icons.wallet, color: currentIndex == 3 ? ConstantColor.bottomNavigationActiveColor :
              ConstantColor.bottomNavigationUnActiveColor,),
              label: "wallet",
            ),
          ],
        );
      },
    );
  }
}

