import 'package:equatable/equatable.dart';
import 'package:selling_food_store/models/order.dart';

abstract class OrderListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadingOrderListState extends OrderListState {}

class DisplayOrderListState extends OrderListState {
  final List<Order> orders;

  DisplayOrderListState(this.orders);

  @override
  List<Object?> get props => [orders];
}

class CancelOrderState extends OrderListState {
  final String id;

  CancelOrderState(this.id);

  @override
  List<Object?> get props => [id];
}

class ConfirmCancelOrderState extends OrderListState {}

class CloseBottomSheetState extends OrderListState {}

class FeedbackProductState extends OrderListState {}

class ErrorCancelOrderState extends OrderListState {
  final String error;

  ErrorCancelOrderState(this.error);

  @override
  List<Object?> get props => [error];
}
