import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_item.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class CartItem extends HiveObject {
  @HiveField(0)
  @JsonKey(name: 'item_id')
  String itemID;
  @HiveField(1)
  @JsonKey(name: 'product_id')
  String productID;
  @HiveField(2)
  @JsonKey(name: 'quantity')
  int quantity;

  CartItem(this.itemID, this.productID, this.quantity);

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}
