import 'package:equatable/equatable.dart';

abstract class TrackingOrderState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitTrackingOrderState extends TrackingOrderState {}

class GetIDInvoiceState extends TrackingOrderState {
  final String id;

  GetIDInvoiceState(this.id);

  @override
  List<Object?> get props => [id];
}

class RequestPaymentState extends TrackingOrderState {
  final String urlRequest;

  RequestPaymentState(this.urlRequest);

  @override
  List<Object?> get props => [urlRequest];
}
