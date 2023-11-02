import 'package:json_annotation/json_annotation.dart';

part 'type_product.g.dart';

@JsonSerializable()
class TypeProduct {
  String idType;
  String name;

  TypeProduct(this.idType, this.name);

  factory TypeProduct.fromJson(Map<String, dynamic> json) =>
      _$TypeProductFromJson(json);

  Map<String, dynamic> toJson() => _$TypeProductToJson(this);
}
