import 'package:shopping_ecommerce_app/payment/domain/entity/card_info.dart';

abstract class PaymentEvent{}

class AddPaymentInfoEvent extends PaymentEvent{
  CardInfo card;
  AddPaymentInfoEvent(this.card);
}

class GetAllCardsEvent extends PaymentEvent{}
