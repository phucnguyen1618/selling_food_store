import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_food_store/modules/order_list/bloc/order_list_event.dart';
import 'package:selling_food_store/modules/order_list/bloc/order_list_state.dart';
import 'package:selling_food_store/shared/services/firebase_service.dart';

import '../../../models/request_order.dart';

class OrderListBloc extends Bloc<OrderListEvent, OrderListState> {
  List<RequestOrder> orderList = [];

  OrderListBloc() : super(LoadingOrderListState()) {
    on<OnLoadingOrderListEvent>(_onLoadingOrderList);
    on<OnDisplayOrderListEvent>(_onDisplayOrderList);
    on<OnFilterOrderListEvent>(_onFilterOrderList);
    on<OnCancelOrderEvent>(_onCancelOrder);
  }

  void _onLoadingOrderList(
      OnLoadingOrderListEvent event, Emitter<OrderListState> emitter) {
    FirebaseService.getOrderList((dataList) {
      orderList = dataList;
      add(OnDisplayOrderListEvent(orderList));
    }, (error) {
      add(OnErrorEvent(error));
    });
  }

  void _onDisplayOrderList(
      OnDisplayOrderListEvent event, Emitter<OrderListState> emitter) {
    emitter(DisplayOrderListState(event.requestOrders));
  }

  void _onFilterOrderList(
      OnFilterOrderListEvent event, Emitter<OrderListState> emitter) {
    List<RequestOrder> requestOrders = filterOrderListFromStatus(event.value);
    emitter(DisplayOrderListState(requestOrders));
  }

  void _onCancelOrder(
      OnCancelOrderEvent event, Emitter<OrderListState> emitter) {
    emitter(CancelOrderState());
  }

  List<RequestOrder> filterOrderListFromStatus(int value) {
    switch (value) {
      case 1:
        List<RequestOrder> dataList =
            orderList.where((element) => element.status == 0).toList();
        return dataList;
      case 2:
        List<RequestOrder> dataList =
            orderList.where((element) => element.status == 1).toList();
        return dataList;
      case 3:
        List<RequestOrder> dataList =
            orderList.where((element) => element.status == 1).toList();
        return dataList;
      case 4:
        List<RequestOrder> dataList =
            orderList.where((element) => element.status == 2).toList();
        return dataList;
      default:
        return orderList;
    }
  }
}
