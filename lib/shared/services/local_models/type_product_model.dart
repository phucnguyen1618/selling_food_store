import 'package:hive_flutter/hive_flutter.dart';

part 'type_product_model.g.dart';

@HiveType(typeId: 3)
class TypeProduct {
  @HiveField(0)
  String idType;
  @HiveField(1)
  String name;

  TypeProduct(this.idType, this.name);
}
