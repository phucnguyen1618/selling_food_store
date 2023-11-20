import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:selling_food_store/models/type_product.dart';
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

  void _onLoadingProductList(
      OnLoadingProductList event, Emitter<HomeState> emitter) {
    List<Product> recommendProductList = [];
    List<Product> hotSellingProductList = [];
    List<TypeProduct> typeProducts = [];

    FirebaseService.fetchDataRecommendProducts(onLoadComplete: (dataList) {
      recommendProductList = dataList;
      productList = dataList;
      add(OnDisplayProductList(
          recommendProductList, hotSellingProductList, typeProducts, []));
    });
    FirebaseService.fetchDataHotSellingProducts(onLoadComplete: (dataList) {
      hotSellingProductList = dataList;
      add(OnDisplayProductList(
          recommendProductList, hotSellingProductList, typeProducts, []));
    });
    FirebaseService.fetchDataTypeProducts(onLoadComplete: (dataList) {
      typeProducts = dataList;
      FirebaseService.fetchDataProductListWithType(
        typeProduct: Strings.typeProduct,
        onLoadComplete: (dataList) {
          add(OnDisplayProductList(recommendProductList, hotSellingProductList,
              typeProducts, dataList));
        },
      );
    });
  }

  void _onDisplayProductList(
      OnDisplayProductList event, Emitter<HomeState> emitter) {
    emitter(DisplayProductListState(event.recommendedProducts,
        event.hotSellingProducts, event.productList, event.typeProducts));
  }

  void _onBuyNowProduct(OnBuyNowEvent event, Emitter<HomeState> emitter) {
    if (FirebaseService.checkUserIsSignIn()) {
      List<Cart> cartList = [];
      String idCart = const Uuid().v1();
      Cart cart = Cart(idCart, event.product, 1, DateTime.now());
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
            element.typeProducts.where((e) => e.name == type).isNotEmpty)
        .toList();
  }
}
