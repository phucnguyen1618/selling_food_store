// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) => Cart(
      json['idCart'] as String,
      Product.fromJson(json['product'] as Map<String, dynamic>),
      json['orderQuantity'] as int,
      DateTime.parse(json['dateTimeOrder'] as String),
    );

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'idCart': instance.idCart,
      'product': instance.product.toJson(),
      'orderQuantity': instance.orderQuantity,
      'dateTimeOrder': instance.dateTimeOrder.toIso8601String(),
    };
