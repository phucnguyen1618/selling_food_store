abstract class CartButtonEvent {}

class OnAddProductToCartEvent extends CartButtonEvent {
  int value;

  OnAddProductToCartEvent(this.value);
}

class OnRemoveProductInCartEvent extends CartButtonEvent {}
