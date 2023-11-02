import 'package:json_annotation/json_annotation.dart';
import 'package:selling_food_store/models/brand.dart';
import 'package:selling_food_store/models/cart.dart';
import 'package:selling_food_store/shared/services/firebase_service.dart';
import 'package:uuid/uuid.dart';

import '../shared/services/hive_service.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  String idProduct;
  String name;
  String image;
  String description;
  double cost;
  double? discount;
  Brand brand;

  Product(
    this.idProduct,
    this.name,
    this.image,
    this.description,
    this.cost,
    this.discount,
    this.brand,
  );

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  double getPrice() {
    return discount != null && discount != 0.0
        ? cost - cost * (discount! / 100.0)
        : cost;
  }

  void addCart(
    int order,
    DateTime dateTime,
    Function() onComplete,
    Function(String) onError,
  ) {
    String idCart = const Uuid().v1();
    Cart cart = Cart(idCart, this, order, dateTime);
    FirebaseService.addProductToCart(cart, () {
      HiveService.addCart(cart);
      onComplete();
    }, (message) => onError(message));
  }
}
