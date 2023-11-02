import 'package:json_annotation/json_annotation.dart';
import 'package:selling_food_store/models/cart.dart';
import 'package:selling_food_store/models/user_info_order.dart';

part 'request_order.g.dart';

@JsonSerializable()
class RequestOrder {
  String idOrder;
  UserInfoOrder orderUserInfo;
  List<Cart> cartList;
  double orderPrice;
  double shippingFee;
  DateTime orderDateTime;
  //Trang thai don hang - 0: Đang vận chuyển, 1: Đã hoàn thành, 2: Đã huỷ
  int status;
  String? note;
  //Phuong thuc thanh toan - 0: COD, 1: MOMO
  int paymentMethod;

  RequestOrder(
    this.idOrder,
    this.orderUserInfo,
    this.cartList,
    this.orderPrice,
    this.shippingFee,
    this.orderDateTime,
    this.status,
    this.note,
    this.paymentMethod,
  );

  factory RequestOrder.fromJson(Map<String, dynamic> json) =>
      _$RequestOrderFromJson(json);

  Map<String, dynamic> toJson() => _$RequestOrderToJson(this);

  double getTotalPrice() {
    return orderPrice + shippingFee;
  }
}
