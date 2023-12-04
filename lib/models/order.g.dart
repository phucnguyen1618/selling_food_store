// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
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

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'idOrder': instance.idOrder,
      'orderUserInfo': instance.orderUserInfo,
      'cartList': instance.cartList,
      'orderPrice': instance.orderPrice,
      'shippingFee': instance.shippingFee,
      'orderDateTime': instance.orderDateTime.toIso8601String(),
      'status': instance.status,
      'note': instance.note,
      'paymentMethod': instance.paymentMethod,
      'reasonCancelOrder': instance.reasonCancelOrder,
    };
