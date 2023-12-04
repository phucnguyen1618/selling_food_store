import 'package:equatable/equatable.dart';
import 'package:momo_vn/momo_vn.dart';
import 'package:selling_food_store/models/cart.dart';

abstract class OrderState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitRequestOrderState extends OrderState {}

class UpdateNumberProductState extends OrderState {
  final double price;

  UpdateNumberProductState(this.price);

  @override
  List<Object?> get props => [price];
}

class DisplayProductForRequestOrderState extends OrderState {
  final List<Cart> cartList;
  final double orderPrice;
  final double totalPrice;

  DisplayProductForRequestOrderState(
      this.cartList, this.orderPrice, this.totalPrice);

  @override
  List<Object?> get props => [cartList];
}

class DisplayUserInfoState extends OrderState {
  final String name;
  final String address;

  DisplayUserInfoState(this.name, this.address);

  @override
  List<Object?> get props => [name, address];
}

class RequestOrderProductSuccessState extends OrderState {
  final String name;
  final String address;

  RequestOrderProductSuccessState(this.name, this.address);

  @override
  List<Object?> get props => [name, address];
}

class RequestOrderProductFailureState extends OrderState {
  final String message;

  RequestOrderProductFailureState(this.message);
}

class ChoosePaymentMethodState extends OrderState {
  final int value;

  ChoosePaymentMethodState(this.value);

  @override
  List<Object?> get props => [value];
}

class PaymentSuccessState extends OrderState {
  final PaymentResponse response;

  PaymentSuccessState(this.response);

  @override
  List<Object?> get props => [response];
}
