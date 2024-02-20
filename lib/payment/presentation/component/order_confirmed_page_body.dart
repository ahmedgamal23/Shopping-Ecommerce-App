import 'package:flutter/material.dart';
import 'package:shopping_ecommerce_app/core/constant_color.dart';
import 'package:shopping_ecommerce_app/main_content/presentation/screens/main_page.dart';

class OrderConfirmedPageBody extends StatelessWidget {
  const OrderConfirmedPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // image
          const Image(
            image: AssetImage("assets/images/order.jpg"),
          ),
          Column(
            children: [
              const Text(
                "Order Confirmed!",
                style: TextStyle(
                    color: ConstantColor.splashContainerTitleColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                ),
              ),
              const Text(
                "Your order has been confirmed, we will send you confirmation email shortly.",
                style: TextStyle(
                  color: ConstantColor.splashContainerSubTitleColor,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: (){
                  /// TODO: when clicked on it go to orders page
                },
                child: const Text("Go To Orders", style: TextStyle(color: Color(0xFFB6B9BF)),),
              ),
            ],
          ),
          // button to continue shopping
          InkWell(
            onTap: (){
              // TODO: when click on it return to main page
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainPage(),));
            },
            child: Container(
              width: MediaQuery.of(context).size.width-50,
              height: 70,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: ConstantColor.splashGgColor,
              ),
              child: const Text(
                "Continue Shopping",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

