import 'package:hive/hive.dart';

part 'brand_model.g.dart';

@HiveType(typeId: 0)
class BrandModel extends HiveObject {
  @HiveField(0)
  String idBrand;
  @HiveField(1)
  String name;
  @HiveField(2)
  String logoBrand;

  BrandModel(
    this.idBrand,
    this.name,
    this.logoBrand,
  );
}
