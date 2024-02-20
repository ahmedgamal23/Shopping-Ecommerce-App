import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_ecommerce_app/payment/domain/entity/card_info.dart';
import 'package:shopping_ecommerce_app/payment/domain/usecase/payment_usecase.dart';
import 'package:shopping_ecommerce_app/payment/presentation/controller/bloc_event.dart';
import 'package:shopping_ecommerce_app/payment/presentation/controller/bloc_state.dart';

class PaymentBloc extends Bloc<PaymentEvent,PaymentState>{
  BasePaymentUseCase basePaymentUseCase;
  PaymentBloc(this.basePaymentUseCase):super(PaymentInitialState()){
    on<PaymentEvent>((event, emit) async{
      if(event is AddPaymentInfoEvent){
        bool result = await basePaymentUseCase.executeSetPaymentInfo(event.card);
        if(result == true){
          emit(PaymentSuccessState());
        }else{
          emit(PaymentFailedState());
        }
      }else if(event is GetAllCardsEvent){
        List<CardInfo> list = await basePaymentUseCase.executeGetAllCards();
        if(list.isNotEmpty){
          emit(GetAllCardsState(list));
        }else{
          emit(PaymentFailedState());
        }
      }
    });
  }
}
