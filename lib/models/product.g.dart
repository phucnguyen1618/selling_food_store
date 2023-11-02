// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      json['idProduct'] as String,
      json['name'] as String,
      json['image'] as String,
      json['description'] as String,
      (json['cost'] as num).toDouble(),
      (json['discount'] as num?)?.toDouble(),
      Brand.fromJson(json['brand'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'idProduct': instance.idProduct,
      'name': instance.name,
      'image': instance.image,
      'description': instance.description,
      'cost': instance.cost,
      'discount': instance.discount,
      'brand': instance.brand.toJson(),
    };
