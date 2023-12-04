import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:selling_food_store/models/category.dart';
import 'package:selling_food_store/modules/home/bloc/home_event.dart';
import 'package:selling_food_store/modules/home/bloc/home_state.dart';
import 'package:selling_food_store/shared/services/firebase_service.dart';
import 'package:uuid/uuid.dart';

import '../../../models/cart.dart';
import '../../../models/product.dart';
import '../../../shared/utils/strings.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<Product> productList = [];

  HomeBloc() : super(InitHomeState()) {
    if (!isClosed) {
      on<OnLoadingProductList>(_onLoadingProductList);
      on<OnDisplayProductList>(_onDisplayProductList);
      on<OnBuyNowEvent>(_onBuyNowProduct);
      on<OnAddProductToCartEvent>(_onAddProductToCart);
      on<OnRequestSignInEvent>(_onRequestSignIn);
      on<OnBottomSheetCloseEvent>(_onBottomSheetClose);
      on<OnCloseDialogEvent>(_onDialogClose);
      on<OnTabItemClickedEvent>(_onTabItemClicked);
      on<OnReloadProductListEvent>(_onReloadProductListWithType);
    }
  }

  Future<void> _onLoadingProductList(
      OnLoadingProductList event, Emitter<HomeState> emitter) async {
    List<Product> recommendProductList = [];
    List<Product> hotSellingProductList = [];
    List<Product> productListWithCategory = [];
    List<Category> typeProducts = [];

    productList = await FirebaseService.fetchProducts();
    typeProducts = await FirebaseService.fetchDataCategories();
    if (productList.isNotEmpty && typeProducts.isNotEmpty) {
      recommendProductList =
          productList.where((e) => e.sold == null || e.sold == 0.0).toList();
      hotSellingProductList =
          productList.where((e) => e.sold != null && e.sold! > 500).toList();
      productListWithCategory = _filterProductListWithType(Strings.typeProduct);
      add(OnDisplayProductList(recommendProductList, hotSellingProductList,
          typeProducts, productListWithCategory));
    }
  }

  void _onDisplayProductList(
      OnDisplayProductList event, Emitter<HomeState> emitter) {
    emitter(DisplayProductListState(event.recommendedProducts,
        event.hotSellingProducts, event.productList, event.categories));
  }

  void _onBuyNowProduct(OnBuyNowEvent event, Emitter<HomeState> emitter) {
    if (FirebaseService.checkUserIsSignIn()) {
      List<Cart> cartList = [];
      String idCart = const Uuid().v1();
      Cart cart = Cart(idCart, event.product.idProduct, 1);
      cartList.add(cart);
      emitter(BuyNowState(cartList));
    } else {
      add(OnRequestSignInEvent());
    }
  }

  void _onAddProductToCart(
      OnAddProductToCartEvent event, Emitter<HomeState> emitter) {
    if (FirebaseService.checkUserIsSignIn()) {
      emitter(AddProductToCartState(event.product));
    } else {
      add(OnRequestSignInEvent());
    }
  }

  void _onRequestSignIn(
      OnRequestSignInEvent event, Emitter<HomeState> emitter) {
    emitter(RequestSignInState());
  }

  void _onBottomSheetClose(
      OnBottomSheetCloseEvent event, Emitter<HomeState> emitter) {
    emitter(BottomSheetCloseState());
  }

  void _onDialogClose(OnCloseDialogEvent event, Emitter<HomeState> emitter) {
    emitter(DialogCloseState());
  }

  void _onTabItemClicked(
      OnTabItemClickedEvent event, Emitter<HomeState> emitter) {
    log('Size product list: ${productList.length}');
    List<Product> products = _filterProductListWithType(event.content);
    add(OnReloadProductListEvent(products));
  }

  void _onReloadProductListWithType(
      OnReloadProductListEvent event, Emitter<HomeState> emitter) {
    emitter(ReloadProductListState(event.productList));
  }

  List<Product> _filterProductListWithType(String type) {
    return productList
        .where((element) =>
            element.categories.where((e) => e.name == type).isNotEmpty)
        .toList();
  }
}
