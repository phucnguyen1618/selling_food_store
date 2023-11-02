part of 'product_detail_bloc.dart';

@immutable
abstract class ProductDetailState extends Equatable {
  const ProductDetailState();

  @override
  List<Object?> get props => [];
}

class LoadingProductDetailState extends ProductDetailState {}

@immutable
class DisplayProductDetailState extends ProductDetailState {
  final ProductDetail productDetail;

  const DisplayProductDetailState({required this.productDetail});

  @override
  List<Object?> get props => [productDetail];
}

class BuyNowSuccessState extends ProductDetailState {
  final List<Cart> cartList;

  const BuyNowSuccessState(this.cartList);

  @override
  List<Object?> get props => [cartList];
}

class BuyNowFailureState extends ProductDetailState {
  final String error;

  const BuyNowFailureState(this.error);

  @override
  List<Object?> get props => [error];
}

class AddProductToCartState extends ProductDetailState {
  final Product product;

  const AddProductToCartState(this.product);

  @override
  List<Object?> get props => [product];
}

class RequestSignInState extends ProductDetailState {}

class BottomSheetCloseState extends ProductDetailState {}

class DialogCloseState extends ProductDetailState {}
