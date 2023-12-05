import 'package:json_annotation/json_annotation.dart';
import 'package:paypal_api/models/amount.dart';
import 'package:paypal_api/models/detail.dart';
import 'package:paypal_api/models/invoicer.dart';
import 'package:paypal_api/models/item.dart';
import 'package:paypal_api/models/recipient.dart';

part 'invoice_response.g.dart';

@JsonSerializable()
class InvoiceResponse {
  String id;
  String status;
  Detail? detail;
  Invoicer? invoicer;
  @JsonKey(name: 'primary_recipients')
  List<Recipient>? recipients;
  List<Item>? items;
  Amount? amount;

  InvoiceResponse(
    this.id,
    this.status,
    this.detail,
    this.invoicer,
    this.recipients,
    this.items,
    this.amount,
  );

  factory InvoiceResponse.fromJson(Map<String, dynamic> json) =>
      _$InvoiceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceResponseToJson(this);
}
