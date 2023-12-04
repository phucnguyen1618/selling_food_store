import 'package:json_annotation/json_annotation.dart';

part 'user_info_order.g.dart';

@JsonSerializable()
class UserInfoOrder {
  String idUser;
  String name;
  String? phone;
  String? address;

  UserInfoOrder(this.idUser, this.name, this.phone, this.address);

  factory UserInfoOrder.fromJson(Map<String, dynamic> json) =>
      _$UserInfoOrderFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoOrderToJson(this);
}
