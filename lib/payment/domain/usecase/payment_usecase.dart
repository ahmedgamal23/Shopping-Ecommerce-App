import 'package:shopping_ecommerce_app/payment/domain/entity/card_info.dart';
import 'package:shopping_ecommerce_app/payment/domain/repository/base_payment_repository.dart';

abstract class BasePaymentUseCase{
  Future<bool> executeSetPaymentInfo(CardInfo card);
  Future<List<CardInfo>> executeGetAllCards();
}

class PaymentUseCase extends BasePaymentUseCase {
  BasePaymentRepository basePaymentRepository;
  PaymentUseCase(this.basePaymentRepository);
  @override
  Future<bool> executeSetPaymentInfo(CardInfo card) async {
    return await basePaymentRepository.setPaymentInfo(card);
  }

  @override
  Future<List<CardInfo>> executeGetAllCards() async {
    return await basePaymentRepository.getAllCards();
  }
}
