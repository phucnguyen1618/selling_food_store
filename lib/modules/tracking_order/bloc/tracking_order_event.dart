abstract class TrackingOrderEvent {}

class OnInitTrackingOrderEvent extends TrackingOrderEvent {
  final String id;

  OnInitTrackingOrderEvent(this.id);
}

class OnGetIDInvoiceEvent extends TrackingOrderEvent {
  final String idInvoice;

  OnGetIDInvoiceEvent(this.idInvoice);
}

class OnRequestPaymentEvent extends TrackingOrderEvent {
  final String id;
  OnRequestPaymentEvent(this.id);
}
