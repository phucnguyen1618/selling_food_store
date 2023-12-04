import 'package:json_annotation/json_annotation.dart';
import 'package:selling_food_store/models/cart.dart';
import 'package:selling_food_store/models/user_info_order.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  String idOrder;
  UserInfoOrder orderUserInfo;
  List<Cart> cartList;
  double orderPrice;
  double shippingFee;
  DateTime orderDateTime;
  //Trang thai don hang - 0: Đơn hàng xác nhận, 1: Đang giao hàng,  2: Giao hàng thành công, 3: Huỷ giao hàng
  int status;
  String? note;
  //Phuong thuc thanh toan - 0: COD, 1: MOMO
  int paymentMethod;
  String? reasonCancelOrder;

  Order(
    this.idOrder,
    this.orderUserInfo,
    this.cartList,
    this.orderPrice,
    this.shippingFee,
    this.orderDateTime,
    this.status,
    this.note,
    this.paymentMethod,
    this.reasonCancelOrder,
  );

  factory Order.fromJson(Map<String, dynamic> json) =>
      _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);

  Map<String, dynamic> convertToJson() {
    return {
      "idOrder": idOrder,
      "orderUserInfo": orderUserInfo.toJson(),
      "cartList": cartList.map((e) => e.toJson()).toList(),
      "orderPrice": orderPrice,
      "shippingFee": shippingFee,
      "orderDateTime": orderDateTime.toIso8601String(),
      "status": status,
      "note": note,
      "paymentMethod": paymentMethod,
      "reasonCancelOrder": reasonCancelOrder,
    };
  }

  double getTotalPrice() {
    return orderPrice + shippingFee;
  }

  void updateStatusRequestOrder(int value) {
    status = value;
  }
}
