import 'package:bloc/bloc.dart';
import 'package:selling_food_store/modules/home/bloc/home_event.dart';
import 'package:selling_food_store/modules/home/bloc/home_state.dart';
import 'package:selling_food_store/shared/services/firebase_service.dart';
import 'package:uuid/uuid.dart';

import '../../../models/cart.dart';
import '../../../models/product.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(InitHomeState()) {
    on<OnLoadingProductList>(_onLoadingProductList);
    on<OnDisplayProductList>(_onDisplayProductList);
    on<OnBuyNowEvent>(_onBuyNowProduct);
    on<OnAddProductToCartEvent>(_onAddProductToCart);
    on<OnUpdateNumberCartEvent>(_onUpdateNumberCart);
    on<OnRequestSignInEvent>(_onRequestSignIn);
    on<OnBottomSheetCloseEvent>(_onBottomSheetClose);
    on<OnCloseDialogEvent>(_onDialogClose);
  }

  void _onLoadingProductList(
      OnLoadingProductList event, Emitter<HomeState> emitter) {
    List<Product> recommendProductList = [];
    List<Product> hotSellingProductList = [];
    FirebaseService.fetchDataRecommendProducts(onLoadComplete: (dataList) {
      recommendProductList = dataList;
      add(OnDisplayProductList(recommendProductList, hotSellingProductList));
    });
    FirebaseService.fetchDataHotSellingProducts(onLoadComplete: (dataList) {
      hotSellingProductList = dataList;
      add(OnDisplayProductList(recommendProductList, hotSellingProductList));
    });
  }

  void _onDisplayProductList(
      OnDisplayProductList event, Emitter<HomeState> emitter) {
    emitter(DisplayProductListState(
        event.recommendedProducts, event.hotSellingProducts));
  }

  // Future<void> loadTypeProducts() async {
  //   FirebaseService.fetchDataTypeProducts(onLoadComplete: (dataList) {
  //     emit(state.copyWith(typeProducts: dataList));
  //   });
  // }

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

  void _onUpdateNumberCart(
      OnUpdateNumberCartEvent event, Emitter<HomeState> emitter) {
    int numberItems = event.numberCart++;
    emitter(UpdateNumberCartState(numberItems));
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
}