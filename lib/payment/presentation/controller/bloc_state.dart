import '../../domain/entity/card_info.dart';

abstract class PaymentState{}

class PaymentInitialState extends PaymentState{}

class PaymentSuccessState extends PaymentState{}

class PaymentFailedState extends PaymentState{}

class PaymentLoadingState extends PaymentState{}

class GetAllCardsState extends PaymentState{
  List<CardInfo> list;
  GetAllCardsState(this.list);
}
