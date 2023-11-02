import 'package:hive/hive.dart';

part 'cart_model.g.dart';

@HiveType(typeId: 2)
class CartModel extends HiveObject {
  @HiveField(0)
  String idCart;
  @HiveField(1)
  String product;
  @HiveField(2)
  int orderQuantity;
  @HiveField(3)
  DateTime dateTimeOrder;

  CartModel(
    this.idCart,
    this.product,
    this.dateTimeOrder,
    this.orderQuantity,
  );
}
