// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoOrder _$UserInfoOrderFromJson(Map<String, dynamic> json) =>
    UserInfoOrder(
      json['idUser'] as String,
      json['name'] as String,
      json['phone'] as String?,
      json['address'] as String?,
    );

Map<String, dynamic> _$UserInfoOrderToJson(UserInfoOrder instance) =>
    <String, dynamic>{
      'idUser': instance.idUser,
      'name': instance.name,
      'phone': instance.phone,
      'address': instance.address,
    };
