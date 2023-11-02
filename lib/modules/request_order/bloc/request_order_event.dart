import 'package:selling_food_store/models/cart.dart';

abstract class RequestOrderEvent {}

class OnLoadingRequestOrderEvent extends RequestOrderEvent {
  List<Cart> cartList;

  OnLoadingRequestOrderEvent(this.cartList);
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

class OnRequestOrderProductSuccessEvent extends RequestOrderEvent {}

class OnRequestOrderProductFailureEvent extends RequestOrderEvent {
  String error;

  OnRequestOrderProductFailureEvent(this.error);
}

class OnRequestPaymentEvent extends RequestOrderEvent {}

class OnPaymentSuccessEvent extends RequestOrderEvent {}

class OnPaymentFailureEvent extends RequestOrderEvent {}

class OnIncreaseNumberProductEvent extends RequestOrderEvent {
  int value;

  OnIncreaseNumberProductEvent(this.value);
}

class OnDecreaseNumberProductEvent extends RequestOrderEvent {
  int value;

  OnDecreaseNumberProductEvent(this.value);
}
