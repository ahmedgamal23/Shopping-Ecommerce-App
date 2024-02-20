import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:shopping_ecommerce_app/payment/domain/entity/card_info.dart';
import 'package:shopping_ecommerce_app/payment/presentation/controller/bloc.dart';
import 'package:shopping_ecommerce_app/payment/presentation/controller/bloc_state.dart';

class CardsPageBody extends StatelessWidget {
  const CardsPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: BlocBuilder<PaymentBloc, PaymentState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            List<CardInfo> cardList = state is GetAllCardsState? state.list:[];
            return cardList.isEmpty?const Center(child: CircularProgressIndicator(),):ListView.builder(
              itemCount: cardList.length,
              itemBuilder: (context, index) {
                return CreditCardWidget(
                  cardNumber: cardList[index].cardNumber,
                  expiryDate: cardList[index].exp,
                  cardHolderName: cardList[index].cardOwner,
                  cvvCode: cardList[index].cvv,
                  showBackView: true,
                  labelCardHolder: 'CARD HOLDER',
                  cardType: CardType.visa,
                  bankName: "AlAhly",
                  isHolderNameVisible: true,
                  height: 190,
                  width: MediaQuery.of(context).size.width,
                  frontCardBorder: Border.all(color: Colors.grey),
                  backCardBorder: Border.all(color: Colors.grey),
                  chipColor: Colors.white70,
                  onCreditCardWidgetChange: (p0) {

                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
