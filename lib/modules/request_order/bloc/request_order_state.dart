import 'package:equatable/equatable.dart';
import 'package:momo_vn/momo_vn.dart';
import 'package:selling_food_store/models/cart.dart';

abstract class RequestOrderState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitRequestOrderState extends RequestOrderState {}

class IncreaseNumberProductState extends RequestOrderState {}

class DecreaseNumberProductState extends RequestOrderState {}

class DisplayProductForRequestOrderState extends RequestOrderState {
  final List<Cart> cartList;
  final double orderPrice;
  final double totalPrice;

  DisplayProductForRequestOrderState(
      this.cartList, this.orderPrice, this.totalPrice);

  @override
  List<Object?> get props => [cartList];
}

class DisplayUserInfoState extends RequestOrderState {
  final String name;
  final String address;

  DisplayUserInfoState(this.name, this.address);

  @override
  List<Object?> get props => [name, address];
}

class RequestOrderProductSuccessState extends RequestOrderState {}

class RequestOrderProductFailureState extends RequestOrderState {
  final String message;

  RequestOrderProductFailureState(this.message);
}

class ChoosePaymentMethodState extends RequestOrderState {
  final int value;

  ChoosePaymentMethodState(this.value);

  @override
  List<Object?> get props => [value];
}

class PaymentSuccessState extends RequestOrderState {
  final PaymentResponse response;

  PaymentSuccessState(this.response);

  @override
  List<Object?> get props => [response];
}
