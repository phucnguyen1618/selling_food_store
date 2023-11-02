import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_food_store/modules/order_list/bloc/order_list_state.dart';
import 'package:selling_food_store/shared/services/firebase_service.dart';

import '../../../models/request_order.dart';

class OrderListBloc extends BlocBase<OrderListState> {
  List<RequestOrder> orderList = [];

  OrderListBloc() : super(OrderListState([], null)) {
    fetchOrderList();
  }

  void fetchOrderList() {
    FirebaseService.getOrderList((dataList) {
      orderList = dataList;
      emit(state.copyWith(dataList, null));
    }, (error) {
      emit(state.copyWith([], error));
    });
  }

  void filterOrderListFromStatus(int value) {
    switch (value) {
      case 1:
        List<RequestOrder> dataList =
            orderList.where((element) => element.status == 0).toList();
        emit(state.copyWith(dataList, null));
        break;
      case 2:
        List<RequestOrder> dataList =
            orderList.where((element) => element.status == 1).toList();
        emit(state.copyWith(dataList, null));
        break;
      case 3:
        List<RequestOrder> dataList =
            orderList.where((element) => element.status == 2).toList();
        emit(state.copyWith(dataList, null));
        break;
      default:
        emit(state.copyWith(orderList, null));
        break;
    }
  }
}
