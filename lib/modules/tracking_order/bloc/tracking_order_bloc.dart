import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paypal_api/paypal_api.dart';
import 'package:selling_food_store/modules/tracking_order/bloc/tracking_order_event.dart';
import 'package:selling_food_store/modules/tracking_order/bloc/tracking_order_state.dart';

import '../../../dependency_injection.dart';

class TrackingOrderBloc extends Bloc<TrackingOrderEvent, TrackingOrderState> {
  final paypalRepository = getIt.get<PaypalRepository>();

  TrackingOrderBloc() : super(InitTrackingOrderState()) {
    on<OnInitTrackingOrderEvent>(_onInit);
    on<OnGetIDInvoiceEvent>(_onGetIDInvoice);
    on<OnRequestPaymentEvent>(_onRequestPayment);
  }

  Future<void> _onInit(OnInitTrackingOrderEvent event,
      Emitter<TrackingOrderState> emitter) async {
    add(OnGetIDInvoiceEvent(event.id));
  }

  void _onGetIDInvoice(
      OnGetIDInvoiceEvent event, Emitter<TrackingOrderState> emitter) {
    emitter(GetIDInvoiceState(event.idInvoice));
  }

  Future<void> _onRequestPayment(
      OnRequestPaymentEvent event, Emitter<TrackingOrderState> emitter) async {
    SendInvoiceRequest request =
        SendInvoiceRequest('Test Send Invoice', true, true);
    final result = await paypalRepository.sendInvoice(event.id, request);
    if (result.href.isNotEmpty) {
      String url = result.href;
      emitter(RequestPaymentState(url));
    }
  }
}
