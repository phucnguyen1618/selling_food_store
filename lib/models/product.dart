import 'package:json_annotation/json_annotation.dart';
import 'package:selling_food_store/models/brand.dart';
import 'package:selling_food_store/models/cart.dart';
import 'package:selling_food_store/models/category.dart';
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
  List<Category> categories;
  double? sold;

  Product(
    this.idProduct,
    this.name,
    this.image,
    this.description,
    this.cost,
    this.discount,
    this.brand,
    this.categories,
    this.sold,
  );

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  Map<String, dynamic> convertToJson() {
    return {
      "idProduct": idProduct,
      "name": name,
      "image": image,
      "description": description,
      "cost": cost,
      "discount": discount,
      "brand": brand.toJson(),
      "categories": categories.map((e) => e.toJson()).toList(),
      "sold": sold,
    };
  }

  double getPrice() {
    return discount != null && discount != 0.0
        ? cost - cost * (discount! / 100.0)
        : cost;
  }

  void addCart(
    int quantity,
    Function() onComplete,
    Function(String) onError,
  ) {
    String idCart = const Uuid().v4();
    Cart cart = Cart(idCart, idProduct, quantity);
    HiveService.addCart(cart);
  }
}
