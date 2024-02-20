import '../entity/card_info.dart';

abstract class BasePaymentRepository{
  Future<bool> setPaymentInfo(CardInfo card);
  Future<List<CardInfo>> getAllCards();
}