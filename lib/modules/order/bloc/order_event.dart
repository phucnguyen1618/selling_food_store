import 'package:selling_food_store/models/cart.dart';
import 'package:selling_food_store/models/order.dart';

abstract class OrderEvent {}

class OnLoadingRequestOrderEvent extends OrderEvent {
  List<Cart> cartList;
  bool isBuyNow;

  OnLoadingRequestOrderEvent(this.cartList, this.isBuyNow);
}

class OnLoadingUserInfoEvent extends OrderEvent {}

class OnDisplayUserInfoEvent extends OrderEvent {
  String name;
  String address;

  OnDisplayUserInfoEvent(this.name, this.address);
}

class OnDisplayRequestOrderEvent extends OrderEvent {
  List<Cart> cartList;

  OnDisplayRequestOrderEvent(this.cartList);
}

class OnRequestOrderProductEvent extends OrderEvent {
  List<Cart> cartList;
  String? note;

  OnRequestOrderProductEvent(this.cartList, this.note);
}

class OnChoosePaymentMethodEvent extends OrderEvent {
  int value;

  OnChoosePaymentMethodEvent(this.value);
}

class OnRequestOrderProductSuccessEvent extends OrderEvent {
  String name;
  String address;

  OnRequestOrderProductSuccessEvent(this.name, this.address);
}

class OnRequestOrderProductFailureEvent extends OrderEvent {
  String error;

  OnRequestOrderProductFailureEvent(this.error);
}

class OnRequestPaymentEvent extends OrderEvent {
  Order order;

  OnRequestPaymentEvent(this.order);
}

class OnPaymentSuccessEvent extends OrderEvent {}

class OnPaymentFailureEvent extends OrderEvent {}

class OnUpdateNumberProductEvent extends OrderEvent {
  double value;

  OnUpdateNumberProductEvent(this.value);
}
