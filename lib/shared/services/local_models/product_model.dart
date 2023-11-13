import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 1)
class ProductModel extends HiveObject {
  @HiveField(0)
  String idProduct;
  @HiveField(1)
  String name;
  @HiveField(2)
  String image;
  @HiveField(3)
  String description;
  @HiveField(4)
  double cost;
  @HiveField(5)
  double? discount;
  @HiveField(6)
  String brand;
  @HiveField(7)
  List<String> typeProducts;

  ProductModel(
    this.idProduct,
    this.name,
    this.image,
    this.description,
    this.cost,
    this.discount,
    this.brand,
    this.typeProducts,
  );
}
