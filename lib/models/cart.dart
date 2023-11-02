import 'package:json_annotation/json_annotation.dart';
import 'package:selling_food_store/shared/services/firebase_service.dart';
import 'package:selling_food_store/shared/services/hive_service.dart';

import 'product.dart';

part 'cart.g.dart';

@JsonSerializable()
class Cart {
  String idCart;
  Product product;
  int orderQuantity;
  DateTime dateTimeOrder;

  Cart(this.idCart, this.product, this.orderQuantity, this.dateTimeOrder);

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  Map<String, dynamic> toJson() => _$CartToJson(this);

  void updateQuantity(int value) {
    orderQuantity = value;
    FirebaseService.updateQuantityForCart(idCart, value);
    HiveService.updateQuantityForCart(idCart, value);
  }
}
