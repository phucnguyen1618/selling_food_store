import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momo_vn/momo_vn.dart';
import 'package:selling_food_store/models/user_info_order.dart';
import 'package:selling_food_store/modules/request_order/bloc/request_order_event.dart';
import 'package:selling_food_store/modules/request_order/bloc/request_order_state.dart';
import 'package:selling_food_store/shared/services/firebase_service.dart';
import 'package:selling_food_store/shared/services/hive_service.dart';
import 'package:selling_food_store/shared/utils/app_utils.dart';
import 'package:uuid/uuid.dart';

import '../../../models/request_order.dart';
import '../../../shared/utils/strings.dart';

class RequestOrderBloc extends Bloc<RequestOrderEvent, RequestOrderState> {
  int paymentMethod = 1;
  late MomoVn _momoPay;
  late PaymentResponse _momoPaymentResult;

  RequestOrderBloc() : super(InitRequestOrderState()) {
    on<OnLoadingUserInfoEvent>(_onLoadingUserInfo);
    on<OnDisplayUserInfoEvent>(_onDisplayUserInfo);
    on<OnLoadingRequestOrderEvent>(_onLoadingRequestOrder);
    on<OnDisplayRequestOrderEvent>(_onDisplayRequestOrder);
    on<OnRequestOrderProductEvent>(_onRequestOrderProduct);
    on<OnChoosePaymentMethodEvent>(_onChoosePaymentMethod);
    on<OnRequestOrderProductSuccessEvent>(_onRequestOrderSuccess);
    on<OnRequestOrderProductFailureEvent>(_onRequestOrderFailure);
    on<OnRequestPaymentEvent>(_onRequestPayment);
  }

  void _onLoadingUserInfo(
      OnLoadingUserInfoEvent event, Emitter<RequestOrderState> emitter) {
    FirebaseService.getUserInfo((dataInfo) {
      if (dataInfo != null) {
        add(OnDisplayUserInfoEvent(dataInfo.fullName, dataInfo.address));
      }
    }, (error) {});
  }

  void _onDisplayUserInfo(
      OnDisplayUserInfoEvent event, Emitter<RequestOrderState> emitter) {
    emitter(DisplayUserInfoState(event.name, event.address));
  }

  void _onLoadingRequestOrder(
      OnLoadingRequestOrderEvent event, Emitter<RequestOrderState> emitter) {
    add(OnDisplayRequestOrderEvent(event.cartList));
  }

  void _onDisplayRequestOrder(
      OnDisplayRequestOrderEvent event, Emitter<RequestOrderState> emitter) {
    double orderPrice = AppUtils.calculateTotalPrice(event.cartList);
    emitter(DisplayProductForRequestOrderState(
        event.cartList, orderPrice, orderPrice + 20000));
  }

  void _onChoosePaymentMethod(
      OnChoosePaymentMethodEvent event, Emitter<RequestOrderState> emitter) {
    paymentMethod = event.value;
    emitter(ChoosePaymentMethodState(event.value));
  }

  void _onRequestOrderProduct(
      OnRequestOrderProductEvent event, Emitter<RequestOrderState> emitter) {
    FirebaseService.getUserInfo((data) {
      if (data != null) {
        final orderUserInfo = UserInfoOrder(
            data.idAccount, data.fullName, '0392634700', data.address);
        String idOrder = const Uuid().v1();
        double orderPrice = AppUtils.calculateTotalPrice(event.cartList);
        final requestOrder = RequestOrder(
            idOrder,
            orderUserInfo,
            event.cartList,
            orderPrice,
            Strings.shippingFeeValue,
            DateTime.now(),
            0,
            event.note,
            paymentMethod,
            '');
        FirebaseService.requestOrder(requestOrder, () {
          FirebaseService.removeCartList();
          HiveService.deleteAllItemCart();
          add(OnRequestOrderProductSuccessEvent());
        }, (error) {
          log('Error: $error');
          add(OnRequestOrderProductFailureEvent(error));
        });
      }
    }, (error) {
      log('Error: $error');
      add(OnRequestOrderProductFailureEvent(error));
    });
  }

  void _onRequestOrderSuccess(OnRequestOrderProductSuccessEvent event,
      Emitter<RequestOrderState> emitter) {
    //if (paymentMethod == 0) {
    emitter(RequestOrderProductSuccessState());
    //} else {
    //  add(OnRequestPaymentEvent());
    // }
  }

  void _onRequestPayment(
      OnRequestPaymentEvent event, Emitter<RequestOrderState> emitter) {
    _momoPay = MomoVn();
    _momoPay.on(MomoVn.EVENT_PAYMENT_SUCCESS, () {
      log('Request Order Success');
      add(OnPaymentSuccessEvent());
    });
    _momoPay.on(MomoVn.EVENT_PAYMENT_ERROR, () {
      log('Request Order Failure');
      add(OnPaymentFailureEvent());
    });
    try {
      MomoPaymentInfo options = MomoPaymentInfo(
          partnerCode: 'Mã đối tác',
          appScheme: "1221212",
          amount: 6000000000,
          orderId: '12321312',
          orderLabel: 'Label để hiển thị Mã giao dịch',
          fee: 0,
          description: 'Thanh toán đơn hàng đặt qua App',
          username: 'Định danh user (id/email/...)',
          partner: 'merchant',
          extra: "{\"key1\":\"value1\",\"key2\":\"value2\"}",
          isTestMode: true,
          merchantCode: '123456789999',
          merchantName: 'Nguyễn Hoàng Phúc',
          merchantNameLabel: 'Luxury Shop');
      _momoPay.open(options);
    } catch (e) {
      log(e.toString());
    }
  }

  void _handlePaymentSuccess(PaymentResponse response) {
    _momoPaymentResult = response;
  }

  void _handlePaymentError(PaymentResponse response) {
    _momoPaymentResult = response;
  }

  void _onRequestOrderFailure(OnRequestOrderProductFailureEvent event,
      Emitter<RequestOrderState> emitter) {
    emitter(RequestOrderProductFailureState(event.error));
  }
}
