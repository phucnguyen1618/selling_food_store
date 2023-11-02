// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credential.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Credential _$CredentialFromJson(Map<String, dynamic> json) => Credential(
      idUser: json['idUser'] as String,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      role: json['role'] as int,
    );

Map<String, dynamic> _$CredentialToJson(Credential instance) =>
    <String, dynamic>{
      'idUser': instance.idUser,
      'phone': instance.phone,
      'email': instance.email,
      'password': instance.password,
      'role': instance.role,
    };
