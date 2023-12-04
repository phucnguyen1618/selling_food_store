import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_food_store/modules/order/bloc/order_event.dart';
import 'package:selling_food_store/modules/order/bloc/order_state.dart';

class UpdateNumberProductBloc
    extends Bloc<OrderEvent, OrderState> {
  double totalPrice = 0;

  UpdateNumberProductBloc() : super(InitRequestOrderState()) {
    on<OnUpdateNumberProductEvent>(_onUpdateNumberProductEvent);
  }

  void _onUpdateNumberProductEvent(
      OnUpdateNumberProductEvent event, Emitter<OrderState> emitter) {
    totalPrice = totalPrice + event.value;
    emitter(UpdateNumberProductState(event.value));
  }
}
