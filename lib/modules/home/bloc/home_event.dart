import 'package:selling_food_store/models/product.dart';

abstract class HomeEvent {
  HomeEvent();
}

class OnLoadingProductList extends HomeEvent {}

class OnDisplayProductList extends HomeEvent {
  List<Product> recommendedProducts;
  List<Product> hotSellingProducts;

  OnDisplayProductList(this.recommendedProducts, this.hotSellingProducts);
}

class OnBuyNowEvent extends HomeEvent {
  Product product;

  OnBuyNowEvent(this.product);
}

class OnAddProductToCartEvent extends HomeEvent {
  Product product;

  OnAddProductToCartEvent(this.product);
}

class OnUpdateNumberCartEvent extends HomeEvent {
  int numberCart;

  OnUpdateNumberCartEvent(this.numberCart);
}

class OnRequestSignInEvent extends HomeEvent {}

class OnBottomSheetCloseEvent extends HomeEvent {}

class OnCloseDialogEvent extends HomeEvent {}
