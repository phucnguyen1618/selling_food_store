import 'package:selling_food_store/models/cart.dart';
import 'package:selling_food_store/models/product.dart';
import 'package:selling_food_store/models/request_order.dart';

abstract class OrderListEvent {}

class OnLoadingOrderListEvent extends OrderListEvent {}

class OnDisplayOrderListEvent extends OrderListEvent {
  List<RequestOrder> requestOrders;

  OnDisplayOrderListEvent(this.requestOrders);
}

class OnFilterOrderListEvent extends OrderListEvent {
  int value;

  OnFilterOrderListEvent(this.value);
}

class OnCancelOrderEvent extends OrderListEvent {
  String idOrder;

  OnCancelOrderEvent(this.idOrder);
}

class OnConfirmCancelOrderEvent extends OrderListEvent {
  String idOrder;
  String reason;

  OnConfirmCancelOrderEvent(this.idOrder, this.reason);
}

class OnFeedbackProductEvent extends OrderListEvent {
  double? rating;
  String review;
  Product product;

  OnFeedbackProductEvent(
    this.rating,
    this.review,
    this.product,
  );
}

class OnCancelOrderSuccessEvent extends OrderListEvent {}

class OnCloseBottomSheetEvent extends OrderListEvent {}

class OnErrorEvent extends OrderListEvent {
  String error;

  OnErrorEvent(this.error);
}
