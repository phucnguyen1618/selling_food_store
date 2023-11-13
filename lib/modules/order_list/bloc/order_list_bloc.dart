import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_food_store/dependency_injection.dart';
import 'package:selling_food_store/models/review.dart';
import 'package:selling_food_store/modules/order_list/bloc/order_list_event.dart';
import 'package:selling_food_store/modules/order_list/bloc/order_list_state.dart';
import 'package:selling_food_store/shared/services/firebase_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../../models/request_order.dart';
import '../../../shared/utils/strings.dart';

class OrderListBloc extends Bloc<OrderListEvent, OrderListState> {
  List<RequestOrder> orderList = [];

  OrderListBloc() : super(LoadingOrderListState()) {
    on<OnLoadingOrderListEvent>(_onLoadingOrderList);
    on<OnDisplayOrderListEvent>(_onDisplayOrderList);
    on<OnFilterOrderListEvent>(_onFilterOrderList);
    on<OnCancelOrderEvent>(_onCancelOrder);
    on<OnCloseBottomSheetEvent>(_onCloseBottomSheet);
    on<OnConfirmCancelOrderEvent>(_onConfirmCancelOrder);
    on<OnErrorEvent>(_onErrorCancelOrder);
    on<OnCancelOrderSuccessEvent>(_onCancelOrderSuccess);
    on<OnFeedbackProductEvent>(_onFeedback);
  }

  void _onLoadingOrderList(
      OnLoadingOrderListEvent event, Emitter<OrderListState> emitter) {
    FirebaseService.getOrderList((dataList) {
      orderList = dataList;
      add(OnDisplayOrderListEvent(orderList));
    }, (error) {
      add(OnErrorEvent(error));
    });
  }

  void _onDisplayOrderList(
      OnDisplayOrderListEvent event, Emitter<OrderListState> emitter) {
    emitter(DisplayOrderListState(event.requestOrders));
  }

  void _onFilterOrderList(
      OnFilterOrderListEvent event, Emitter<OrderListState> emitter) {
    List<RequestOrder> requestOrders = filterOrderListFromStatus(event.value);
    emitter(DisplayOrderListState(requestOrders));
  }

  void _onCancelOrder(
      OnCancelOrderEvent event, Emitter<OrderListState> emitter) {
    emitter(CancelOrderState(event.idOrder));
  }

  void _onCloseBottomSheet(
      OnCloseBottomSheetEvent event, Emitter<OrderListState> emitter) {
    emitter(CloseBottomSheetState());
  }

  void _onConfirmCancelOrder(
      OnConfirmCancelOrderEvent event, Emitter<OrderListState> emitter) {
    FirebaseService.updateReasonForCancelOrder(event.idOrder, event.reason, () {
      add(OnCancelOrderSuccessEvent());
    }, (error) {
      add(OnErrorEvent(error));
    });
  }

  void _onFeedback(
      OnFeedbackProductEvent event, Emitter<OrderListState> emitter) {
    String idReview = const Uuid().v1();
    final prefs = getIt.get<SharedPreferences>();
    final idUser = prefs.getString(Strings.idUser);
    if (idUser != null) {
      final review = Review(
          idReview,
          idUser,
          event.review,
          Strings.titleNameUserFeedbackDemo,
          Strings.avatarDemo,
          event.rating ?? 0);
      FirebaseService.writeReviewForProduct(event.product.idProduct, review);
      emitter(FeedbackProductState());
    }
  }

  void _onCancelOrderSuccess(
      OnCancelOrderSuccessEvent event, Emitter<OrderListState> emitter) {
    emitter(ConfirmCancelOrderState());
  }

  void _onErrorCancelOrder(
      OnErrorEvent event, Emitter<OrderListState> emitter) {
    emitter(ErrorCancelOrderState(event.error));
  }

  List<RequestOrder> filterOrderListFromStatus(int value) {
    switch (value) {
      case 1:
        List<RequestOrder> dataList =
            orderList.where((element) => element.status == 0).toList();
        return dataList;
      case 2:
        List<RequestOrder> dataList =
            orderList.where((element) => element.status == 1).toList();
        return dataList;
      case 3:
        List<RequestOrder> dataList =
            orderList.where((element) => element.status == 2).toList();
        return dataList;
      case 4:
        List<RequestOrder> dataList =
            orderList.where((element) => element.status == 3).toList();
        return dataList;
      default:
        return orderList;
    }
  }
}
