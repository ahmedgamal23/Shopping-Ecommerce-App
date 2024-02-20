import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
import 'package:shopping_ecommerce_app/payment/presentation/screen/add_new_card_page.dart';
import '../../../core/constant_color.dart';
import '../screen/order_confirmed_page.dart';

class PaymentPageBody extends StatelessWidget {
  final double price;
  PaymentPageBody({super.key, required this.price});

  final StreamController<bool> _controller = StreamController<bool>.broadcast();
  bool isRememberMe = false;

  Stream<bool> changeSwitch(){
    return _controller.stream;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            // list view, button add new card, add card data , toggle button for save Save card info
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height-180,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    // list view
                    cardsListView(context),
                    // button add new card
                    buttonAddNewCard(context),
                    // pay with paypal
                    payWithPaypal(context),
                    // add card data
                    cardFormData(context),
                    // toggle button for save Save card info
                    toggleButton(context),
                  ],
                ),
              ),
            ),
            // button to save card
            saveCardButton(context),
          ],
        ),
      ),
    );
  }

  Widget cardsListView(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 220,
      margin: const EdgeInsets.only(top:10,),
      child: ListView.builder(
        addAutomaticKeepAlives: true,
        scrollDirection: Axis.horizontal,
        itemCount: 2,
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width-50,
            height: 200,
            margin: const EdgeInsets.only(right: 10, left: 20),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/mvisa.jpg"),
                fit: BoxFit.fill,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buttonAddNewCard(BuildContext context){
    return InkWell(
      onTap: (){
        /// TODO: when clicked on it go to add new card page
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddNewCardPage(),));
      },
      child: Container(
        width: MediaQuery.of(context).size.width-50,
        height: 70,
        margin: const EdgeInsets.only(top:20, bottom: 20),
        decoration: BoxDecoration(
          color: const Color(0xFFF6F1FF),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFCBADFB), width: 2,),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_box_outlined, color: Color(0xFFCBADFB)),
            SizedBox(width: 5,),
            Text(
              "Add new card",
              style: TextStyle(
                  color: Color(0xFFCBADFB),
                  fontSize: 20,
                  fontWeight: FontWeight.w700
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget payWithPaypal(BuildContext context){
    return Column(
      children: [
        TextButton(
          onPressed: () {
            // TODO: go to pay with paypal
            //Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PaymentCheckoutPage(),));
            // apply payment with paypal
            paypalCheckout(context);
          },
          child: const Text(
            "Pay with paypal",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900,color: Colors.blue),
          ),
        ),
        const SizedBox(height: 15,),
        const Text("---------- OR ------------"),
        const SizedBox(height: 20,),
      ],
    );
  }

  void paypalCheckout(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => PaypalCheckout(
        sandboxMode: true,
        clientId: "AZqHfX_ypZtKUKf6YUO6qDo-dY7_zowxMgtVCcZWl3282raZI-fQLi0z_MR0-7Kd_euIog0fC2-3RPic",
        secretKey: "EPME4UvW91upY2HNo0exYi17ankLUztjqzI7pcN9EV4emBCmU91S7TVBBa2TmJWXL-kk453MIFWyQFNS",
        returnURL: "success.snippetcoder.com",
        cancelURL: "cancel.snippetcoder.com",
        transactions: const [
          {
            "amount": {
              "total": '70',
              "currency": "USD",
              "details": {
                "subtotal": '70',
                "shipping": '0',
                "shipping_discount": 0
              }
            },
            "description": "The payment transaction description.",
            "item_list": {
              "items": [
                {
                  "name": "Apple",
                  "quantity": 4,
                  "price": '5',
                  "currency": "USD"
                },
                {
                  "name": "Pineapple",
                  "quantity": 5,
                  "price": '10',
                  "currency": "USD"
                }
              ],
            }
          }
        ],
        note: "Contact us for any questions on your order.",
        onSuccess: (Map params) async {
          print("onSuccess: $params");
        },
        onError: (error) {
          print("onError: $error");
          Navigator.pop(context);
        },
        onCancel: () {
          print('cancelled:');
        },
      ),
    ));
  }

  Widget cardFormData(BuildContext context){
    return Form(
      child: Column(
        children: [
          // Card Owner
          createTextFormField("Card Owner", TextInputType.name),
          const SizedBox(height: 5,),
          // Phone Number
          createTextFormField("Card Number", TextInputType.number),
          const SizedBox(height: 5,),
          // EXP and CVV
          Row(
            children: [
              Expanded(child: createTextFormField("EXP", TextInputType.datetime)),
              const SizedBox(width: 20,),
              Expanded(child: createTextFormField("CVV", TextInputType.number)),
            ],
          ),
        ],
      ),
    );
  }

  Widget createTextFormField(String labelName, TextInputType type){
    return TextFormField(
      keyboardType: type,
      decoration: InputDecoration(
        label: Text(labelName),
        labelStyle: const TextStyle(color: ConstantColor.splashContainerSubTitleColor, fontSize: 20),
        border: InputBorder.none,
        fillColor: const Color(0xFFF5F6FA),
        filled: true,
      ),
      style: const TextStyle(fontSize: 20),
    );
  }

  Widget toggleButton(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Save card info",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        StreamBuilder(
          stream: changeSwitch(),
          builder: (context, snapshot) {
            return Switch(
              value: snapshot.data ?? false,
              onChanged: (value) {
                _controller.add(value);
              },
              activeColor: const Color(0xFF32CA5B),
              thumbColor: const MaterialStatePropertyAll(Colors.white),
              inactiveTrackColor: Colors.black12,
              trackOutlineColor: const MaterialStatePropertyAll(Colors.black12),
            );
          },
        ),
      ],
    );
  }

  Widget saveCardButton(BuildContext context){
    return InkWell(
      onTap: (){
        // TODO: when click on it save card
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const OrderConfirmedPage(),));
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
          "checkout",
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

