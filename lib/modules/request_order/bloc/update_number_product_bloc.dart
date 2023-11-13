import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_food_store/modules/request_order/bloc/request_order_event.dart';
import 'package:selling_food_store/modules/request_order/bloc/request_order_state.dart';

class UpdateNumberProductBloc
    extends Bloc<RequestOrderEvent, RequestOrderState> {
  double totalPrice = 0;

  UpdateNumberProductBloc() : super(InitRequestOrderState()) {
    on<OnUpdateNumberProductEvent>(_onUpdateNumberProductEvent);
  }

  void _onUpdateNumberProductEvent(
      OnUpdateNumberProductEvent event, Emitter<RequestOrderState> emitter) {
    totalPrice = totalPrice + event.value;
    emitter(UpdateNumberProductState(event.value));
  }
}
