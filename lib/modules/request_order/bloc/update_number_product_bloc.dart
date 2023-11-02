import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_food_store/modules/request_order/bloc/request_order_event.dart';
import 'package:selling_food_store/modules/request_order/bloc/request_order_state.dart';

class UpdateNumberProductBloc extends Bloc<RequestOrderEvent, RequestOrderState> {

  UpdateNumberProductBloc() : super(InitRequestOrderState()) {
    on<OnIncreaseNumberProductEvent>(_onIncreaseNumberProduct);
    on<OnDecreaseNumberProductEvent>(_onDecreaseNumberProduct);
  }

  void _onIncreaseNumberProduct(OnIncreaseNumberProductEvent event, Emitter<RequestOrderState> emitter) {
    
  }

  void _onDecreaseNumberProduct(OnDecreaseNumberProductEvent event, Emitter<RequestOrderState> emitter) {

  }

}