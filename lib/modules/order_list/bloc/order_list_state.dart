import 'package:equatable/equatable.dart';
import 'package:selling_food_store/models/request_order.dart';

abstract class OrderListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadingOrderListState extends OrderListState {}

class DisplayOrderListState extends OrderListState {
  final List<RequestOrder> orders;

  DisplayOrderListState(this.orders);

  @override
  List<Object?> get props => [orders];
}

class CancelOrderState extends OrderListState {}