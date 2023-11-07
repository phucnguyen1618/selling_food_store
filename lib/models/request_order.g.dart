// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestOrder _$RequestOrderFromJson(Map<String, dynamic> json) => RequestOrder(
      json['idOrder'] as String,
      UserInfoOrder.fromJson(json['orderUserInfo'] as Map<String, dynamic>),
      (json['cartList'] as List<dynamic>)
          .map((e) => Cart.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['orderPrice'] as num).toDouble(),
      (json['shippingFee'] as num).toDouble(),
      DateTime.parse(json['orderDateTime'] as String),
      json['status'] as int,
      json['note'] as String?,
      json['paymentMethod'] as int,
      json['reasonCancelOrder'] as String?,
    );

Map<String, dynamic> _$RequestOrderToJson(RequestOrder instance) =>
    <String, dynamic>{
      'idOrder': instance.idOrder,
      'orderUserInfo': instance.orderUserInfo.toJson(),
      'cartList': instance.cartList.map((e) => e.toJson()).toList(),
      'orderPrice': instance.orderPrice,
      'shippingFee': instance.shippingFee,
      'orderDateTime': instance.orderDateTime.toIso8601String(),
      'status': instance.status,
      'note': instance.note,
      'paymentMethod': instance.paymentMethod,
      'reasonCancelOrder': instance.reasonCancelOrder,
    };
