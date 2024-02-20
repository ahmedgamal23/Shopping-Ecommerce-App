import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_ecommerce_app/payment/presentation/controller/bloc.dart';
import 'package:shopping_ecommerce_app/payment/presentation/controller/bloc_event.dart';
import 'package:shopping_ecommerce_app/payment/presentation/controller/bloc_state.dart';
import 'package:shopping_ecommerce_app/payment/presentation/screen/payment_page.dart';
import '../../../core/constant_color.dart';
import 'package:shopping_ecommerce_app/payment/domain/entity/card_info.dart';

class AddNewCardPageBody extends StatelessWidget {
   AddNewCardPageBody({super.key});

  final List<TextEditingController> textEditingControllerList = List.generate(4, (index) => TextEditingController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        padding:const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // choose card type, add card data
            Column(
              children: [
                // choose card type
                cardType(context),
                const SizedBox(height: 20,),
                // add card data
                addCardInfo(context, textEditingControllerList),
              ],
            ),
            // button to save card
            saveCardButton(context),
          ],
        ),
      ),
    );
  }

  Widget cardType(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      alignment: Alignment.center,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            width: 100,
            height: 80,
            margin: const EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F6FA),
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(image: AssetImage("assets/images/master.png")),
            ),
          ),
          Container(
            width: 100,
            height: 80,
            margin: const EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F6FA),
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(image: AssetImage("assets/images/paypal.png"),),
            ),
          ),
          Container(
            width: 100,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F6FA),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(Icons.account_balance_outlined, size: 50),
          ),
        ],
      ),
    );
  }

  Widget addCardInfo(BuildContext context, List<TextEditingController> textEditingControllerList){
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Card Owner
          createTextFormField("Card Owner", textEditingControllerList[0], TextInputType.name),
          const SizedBox(height: 5,),
          // Phone Number
          createTextFormField("Card Number", textEditingControllerList[1], TextInputType.number),
          const SizedBox(height: 5,),
          // EXP and CVV
          Row(
            children: [
              Expanded(child: createTextFormField("EXP", textEditingControllerList[2], TextInputType.datetime)),
              const SizedBox(width: 20,),
              Expanded(child: createTextFormField("CVV", textEditingControllerList[3], TextInputType.number)),
            ],
          ),
        ],
      ),
    );
  }

  Widget createTextFormField(String labelName, TextEditingController textEditingController , TextInputType type){
     return TextFormField(
       controller: textEditingController,
       keyboardType: type,
       validator: (value) {
         if(value!.isEmpty){
           return "complete this field";
         }
       },
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

  Widget saveCardButton(BuildContext context) {
     return BlocListener<PaymentBloc, PaymentState>(
       listener: (context, state) {
         if (state is PaymentSuccessState) {
           Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const PaymentPage(price: 0),));
         }
       },
       child: InkWell(
         onTap: (){
           if(_formKey.currentState!.validate()){
             BlocProvider.of<PaymentBloc>(context).add(AddPaymentInfoEvent(CardInfo(
                 textEditingControllerList[0].text.trim(),
                 textEditingControllerList[1].text.trim(),
                 textEditingControllerList[2].text.trim(),
                 textEditingControllerList[3].text.trim()
             )));
           }
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
             "Add card",
             style: TextStyle(
               fontSize: 25,
               color: Colors.white,
               fontWeight: FontWeight.w500,
             ),
             textAlign: TextAlign.center,
           ),
         ),
       ),
     );
   }

}

