import 'package:selling_food_store/models/request_order.dart';

class OrderListState {
  List<RequestOrder> orders;
  String? error;

  OrderListState(this.orders, this.error);

  OrderListState copyWith(List<RequestOrder>? dataList, String? error) {
    return OrderListState(dataList ?? orders, error);
  }
}
