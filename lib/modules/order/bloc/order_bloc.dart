import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momo_vn/momo_vn.dart';
import 'package:selling_food_store/models/user_info_order.dart';
import 'package:selling_food_store/shared/services/firebase_service.dart';
import 'package:selling_food_store/shared/services/hive_service.dart';
import 'package:selling_food_store/shared/utils/app_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../../dependency_injection.dart';
import '../../../models/order.dart';
import '../../../shared/utils/strings.dart';
import 'order_event.dart';
import 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final prefs = getIt.get<SharedPreferences>();

  late MomoVn _momoPay;
  //late PaymentResponse _momoPaymentResult;
  bool _isBuyNow = false;

  OrderBloc() : super(InitRequestOrderState()) {
      on<OnLoadingUserInfoEvent>(_onLoadingUserInfo);
      on<OnDisplayUserInfoEvent>(_onDisplayUserInfo);
      on<OnLoadingRequestOrderEvent>(_onLoadingRequestOrder);
      on<OnDisplayRequestOrderEvent>(_onDisplayRequestOrder);
      on<OnChoosePaymentMethodEvent>(_onChoosePaymentMethod);
      on<OnRequestOrderProductEvent>(_onRequestOrderProduct);
      on<OnRequestOrderProductSuccessEvent>(_onRequestOrderSuccess);
      on<OnRequestOrderProductFailureEvent>(_onRequestOrderFailure);
      on<OnRequestPaymentEvent>(_onRequestPayment);
  }

  void _onLoadingUserInfo(
      OnLoadingUserInfoEvent event, Emitter<OrderState> emitter) {
    FirebaseService.getUserInfo((dataInfo) {
      if (dataInfo != null) {
        add(OnDisplayUserInfoEvent(dataInfo.fullName, dataInfo.address!));
      }
    }, (error) {});
  }

  void _onDisplayUserInfo(
      OnDisplayUserInfoEvent event, Emitter<OrderState> emitter) {
    emitter(DisplayUserInfoState(event.name, event.address));
  }

  void _onLoadingRequestOrder(
      OnLoadingRequestOrderEvent event, Emitter<OrderState> emitter) {
    _isBuyNow = event.isBuyNow;
    log('Buy now: $_isBuyNow');
    add(OnDisplayRequestOrderEvent(event.cartList));
  }

  void _onDisplayRequestOrder(
      OnDisplayRequestOrderEvent event, Emitter<OrderState> emitter) {
    double orderPrice = AppUtils.calculateTotalPrice(event.cartList);
    emitter(DisplayProductForRequestOrderState(
        event.cartList, orderPrice, orderPrice + 20000));
  }

  void _onChoosePaymentMethod(
      OnChoosePaymentMethodEvent event, Emitter<OrderState> emitter) {
    prefs.setInt(Strings.paymentMethod, event.value);
    emitter(ChoosePaymentMethodState(event.value));
  }

  void _onRequestOrderProduct(
      OnRequestOrderProductEvent event, Emitter<OrderState> emitter) {
    FirebaseService.getUserInfo((data) {
      if (data != null) {
        final orderUserInfo = UserInfoOrder(
            data.idAccount, data.fullName, '0392634700', data.address!);
        String idOrder = const Uuid().v1();
        double orderPrice = AppUtils.calculateTotalPrice(event.cartList);
        int paymentMethodValue = prefs.getInt(Strings.paymentMethod) ?? -1;
        final order = Order(
            idOrder,
            orderUserInfo,
            event.cartList,
            orderPrice,
            Strings.shippingFeeValue,
            DateTime.now(),
            0,
            event.note,
            paymentMethodValue,
            null);
        if (paymentMethodValue == 0) {
          FirebaseService.requestOrder(order, () {
            if (!_isBuyNow) {
              FirebaseService.removeCartList();
              HiveService.deleteAllItemCart();
            }
            add(OnRequestOrderProductSuccessEvent(
                orderUserInfo.name, orderUserInfo.address));
          }, (error) {
            log('Error: $error');
            add(OnRequestOrderProductFailureEvent(error));
          });
        } else if (paymentMethodValue == 1) {
          add(OnRequestPaymentEvent(order));
        } else if (paymentMethodValue == -1) {
          add(OnRequestOrderProductFailureEvent(
              'Vui lòng chọn phương thức thanh toán'));
        }
      }
    }, (error) {
      log('Error: $error');
      add(OnRequestOrderProductFailureEvent(error));
    });
  }

  void _onRequestOrderSuccess(OnRequestOrderProductSuccessEvent event,
      Emitter<OrderState> emitter) {
    emitter(RequestOrderProductSuccessState(event.name, event.address));
  }

  void _onRequestPayment(
      OnRequestPaymentEvent event, Emitter<OrderState> emitter) {
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

  // void _handlePaymentSuccess(PaymentResponse response) {
  //   _momoPaymentResult = response;
  // }

  // void _handlePaymentError(PaymentResponse response) {
  //   _momoPaymentResult = response;
  // }

  void _onRequestOrderFailure(OnRequestOrderProductFailureEvent event,
      Emitter<OrderState> emitter) {
    emitter(RequestOrderProductFailureState(event.error));
  }
}
