import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:paypal_api/paypal_api.dart';
import 'package:selling_food_store/models/user_info.dart';
import 'package:selling_food_store/shared/services/firebase_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../dependency_injection.dart';
import '../../../shared/utils/strings.dart';
import 'order_event.dart';
import 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final prefs = getIt.get<SharedPreferences>();
  final paypalRepository = getIt.get<PaypalRepository>();
  final List<Item> items = [];
  UserInfo? userInfo;
  bool _isBuyNow = false;

  OrderBloc() : super(InitRequestOrderState()) {
    on<OnLoadingUserInfoEvent>(_onLoadingUserInfo);
    on<OnDisplayUserInfoEvent>(_onDisplayUserInfo);
    on<OnLoadingRequestOrderEvent>(_onLoadingRequestOrder);
    on<OnDisplayRequestOrderEvent>(_onDisplayRequestOrder);
    on<OnChoosePaymentMethodEvent>(_onChoosePaymentMethod);
    on<OnRequestOrderProductEvent>(_onRequestOrderProduct);
    on<OnRequestOrderProductFailureEvent>(_onRequestOrderFailure);
    on<OnAddProductToOrderInfoEvent>(_onAddProduct);
    on<OnAddTrackingOrderEvent>(_onAddTrackingOrder);
  }

  Future<void> _onLoadingUserInfo(
      OnLoadingUserInfoEvent event, Emitter<OrderState> emitter) async {
    userInfo = await FirebaseService.getUserInfo((error) {});
    if (userInfo != null) {
      add(OnDisplayUserInfoEvent(userInfo!.fullName, userInfo!.address!));
    }
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
    emitter(DisplayProductForRequestOrderState(event.cartList));
  }

  void _onAddProduct(
      OnAddProductToOrderInfoEvent event, Emitter<OrderState> emitter) {
    items.add(event.item);
  }

  void _onChoosePaymentMethod(
      OnChoosePaymentMethodEvent event, Emitter<OrderState> emitter) {
    prefs.setInt(Strings.paymentMethod, event.value);
    emitter(ChoosePaymentMethodState(event.value));
  }

  Future<void> _onRequestOrderProduct(
      OnRequestOrderProductEvent event, Emitter<OrderState> emitter) async {
    if (userInfo != null) {
      int paymentMethodValue = prefs.getInt(Strings.paymentMethod) ?? -1;
      if (paymentMethodValue == 0) {
        try {
          EasyLoading.show();
          final result = await paypalRepository.createInvoiceNumber();
          if (result.invoiceNumber.isNotEmpty) {
            InvoiceRequest request = InvoiceRequest(
                detail: Detail('USD', result.invoiceNumber),
                invoicer: Invoicer(
                    Name('Jeremie Nguyen'),
                    Address('US', '1234 First Street', '98765'),
                    'sb-9sy6b28569522@business.example.com'),
                recipients: [
                  Recipient(
                      BillingInfo(
                          Name('John Doe'),
                          Address('US', '1234 First Street', '98765'),
                          'sb-di8k928585644@personal.example.com'),
                      null)
                ],
                items: items);
            final response = await paypalRepository.createInvoice(request);
            if (response.href.isNotEmpty) {
              EasyLoading.dismiss();
              String idInvoice = response.href.split('/').last;
              add(OnAddTrackingOrderEvent(idInvoice));
            }
          }
        } on DioException catch (error) {
          if (error.response != null) {
            log('Error: ${error.message.toString()}');
            add(OnRequestOrderProductFailureEvent(error.message.toString()));
          }
        }
      } else if (paymentMethodValue == 1) {
        // add(OnRequestPaymentEvent(order));
      } else if (paymentMethodValue == -1) {
        add(OnRequestOrderProductFailureEvent(
            'Vui lòng chọn phương thức thanh toán'));
      }
    }
  }

  void _onAddTrackingOrder(
      OnAddTrackingOrderEvent event, Emitter<OrderState> emitter) {
    emitter(AddTrackingOrderState(event.idInvoice));
  }

  void _onRequestOrderFailure(
      OnRequestOrderProductFailureEvent event, Emitter<OrderState> emitter) {
    emitter(RequestOrderProductFailureState(event.error));
  }
}
