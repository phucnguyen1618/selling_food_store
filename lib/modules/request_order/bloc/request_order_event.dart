import 'package:selling_food_store/models/cart.dart';
import 'package:selling_food_store/models/request_order.dart';

abstract class RequestOrderEvent {}

class OnLoadingRequestOrderEvent extends RequestOrderEvent {
  List<Cart> cartList;
  bool isBuyNow;

  OnLoadingRequestOrderEvent(this.cartList, this.isBuyNow);
}

class OnLoadingUserInfoEvent extends RequestOrderEvent {}

class OnDisplayUserInfoEvent extends RequestOrderEvent {
  String name;
  String address;

  OnDisplayUserInfoEvent(this.name, this.address);
}

class OnDisplayRequestOrderEvent extends RequestOrderEvent {
  List<Cart> cartList;

  OnDisplayRequestOrderEvent(this.cartList);
}

class OnRequestOrderProductEvent extends RequestOrderEvent {
  List<Cart> cartList;
  String? note;

  OnRequestOrderProductEvent(this.cartList, this.note);
}

class OnChoosePaymentMethodEvent extends RequestOrderEvent {
  int value;

  OnChoosePaymentMethodEvent(this.value);
}

class OnRequestOrderProductSuccessEvent extends RequestOrderEvent {
  String name;
  String address;

  OnRequestOrderProductSuccessEvent(this.name, this.address);
}

class OnRequestOrderProductFailureEvent extends RequestOrderEvent {
  String error;

  OnRequestOrderProductFailureEvent(this.error);
}

class OnRequestPaymentEvent extends RequestOrderEvent {
  RequestOrder order;

  OnRequestPaymentEvent(this.order);
}

class OnPaymentSuccessEvent extends RequestOrderEvent {}

class OnPaymentFailureEvent extends RequestOrderEvent {}

class OnUpdateNumberProductEvent extends RequestOrderEvent {
  double value;

  OnUpdateNumberProductEvent(this.value);
}
