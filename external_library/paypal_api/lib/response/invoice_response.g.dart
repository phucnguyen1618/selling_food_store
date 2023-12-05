// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceResponse _$InvoiceResponseFromJson(Map<String, dynamic> json) =>
    InvoiceResponse(
      json['id'] as String,
      json['status'] as String,
      json['detail'] == null
          ? null
          : Detail.fromJson(json['detail'] as Map<String, dynamic>),
      json['invoicer'] == null
          ? null
          : Invoicer.fromJson(json['invoicer'] as Map<String, dynamic>),
      (json['primary_recipients'] as List<dynamic>?)
          ?.map((e) => Recipient.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['items'] as List<dynamic>?)
          ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['amount'] == null
          ? null
          : Amount.fromJson(json['amount'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InvoiceResponseToJson(InvoiceResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'detail': instance.detail,
      'invoicer': instance.invoicer,
      'primary_recipients': instance.recipients,
      'items': instance.items,
      'amount': instance.amount,
    };
