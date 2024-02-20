import 'package:shopping_ecommerce_app/payment/data/datasource/payment_datasource.dart';
import 'package:shopping_ecommerce_app/payment/domain/entity/card_info.dart';
import 'package:shopping_ecommerce_app/payment/domain/repository/base_payment_repository.dart';

class PaymentRepository extends BasePaymentRepository{
  BasePaymentDatasource basePaymentDatasource;
  PaymentRepository(this.basePaymentDatasource);
  @override
  Future<bool> setPaymentInfo(CardInfo card) async {
    return await basePaymentDatasource.setPaymentInfo(card);
  }

  @override
  Future<List<CardInfo>> getAllCards() async {
    return await basePaymentDatasource.getAllCards();
  }
}

