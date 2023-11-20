import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_food_store/shared/widgets/general/cart/cart_event.dart';

import '../../../services/hive_service.dart';
import 'cart_state.dart';

class CartButtonBloc extends Bloc<CartButtonEvent, CartButtonState> {
  CartButtonBloc()
      : super(InitCartButtonState(HiveService.getCartList().length)) {
    on<OnAddProductToCartEvent>(_onAddProductToCart);
    on<OnRemoveProductInCartEvent>(_onRemoveProductInCart);
  }

  void _onAddProductToCart(
      OnAddProductToCartEvent event, Emitter<CartButtonState> emitter) {
    int numberProductInCart = event.value++;
    emitter(UpdateNumberProductInCartWhenAddState(numberProductInCart));
  }

  void _onRemoveProductInCart(
      OnRemoveProductInCartEvent event, Emitter<CartButtonState> emitter) {
    int numberProductInCart = HiveService.getCartList().length;
    emitter(UpdateNumberProductInCartWhenRemoveState(numberProductInCart));
  }
}
