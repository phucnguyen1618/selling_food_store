import 'package:equatable/equatable.dart';
import 'package:selling_food_store/models/product.dart';
import 'package:selling_food_store/models/type_product.dart';

import '../../../models/cart.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitHomeState extends HomeState {}

class RequestSignInState extends HomeState {}

class BottomSheetCloseState extends HomeState {}

class DialogCloseState extends HomeState {}

class DisplayProductListState extends HomeState {
  final List<Product> recommendProductList;
  final List<Product> hotSellingProductList;
  final List<Product> productList;
  final List<TypeProduct> typeProducts;

  DisplayProductListState(
    this.recommendProductList,
    this.hotSellingProductList,
    this.productList,
    this.typeProducts,
  );

  @override
  List<Object?> get props => [
        recommendProductList,
        hotSellingProductList,
        productList,
        typeProducts,
      ];
}

class ReloadProductListState extends HomeState {
  final List<Product> products;

  ReloadProductListState(this.products);

  @override
  List<Object?> get props => [products];
}

class BuyNowState extends HomeState {
  final List<Cart> cartList;

  BuyNowState(this.cartList);

  @override
  List<Object?> get props => [cartList];
}

class AddProductToCartState extends HomeState {
  final Product product;

  AddProductToCartState(this.product);

  @override
  List<Object?> get props => [product];
}

class UpdateNumberCartState extends HomeState {
  final int value;

  UpdateNumberCartState(this.value);

  @override
  List<Object?> get props => [value];
}
