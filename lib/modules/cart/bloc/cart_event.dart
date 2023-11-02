import 'package:selling_food_store/models/cart.dart';

abstract class CartEvent {}

class LoadingCartListEvent extends CartEvent {}

class OnDisplayNotSignInEvent extends CartEvent {}

class DisplayCartListEvent extends CartEvent {
  List<Cart> cartList;

  DisplayCartListEvent(this.cartList);
}

class OnDisplayTotalPriceEvent extends CartEvent {
  double price;

  OnDisplayTotalPriceEvent(this.price);
}

class OnIncreaseQuantityEvent extends CartEvent {
  double value;

  OnIncreaseQuantityEvent(this.value);
}

class OnDecreaseQuantityEvent extends CartEvent {
  double value;

  OnDecreaseQuantityEvent(this.value);
}

class OnDeleteItemEvent extends CartEvent {
  bool isDeleteItem;
  List<Cart> cartList;

  OnDeleteItemEvent(this.isDeleteItem, this.cartList);
}
