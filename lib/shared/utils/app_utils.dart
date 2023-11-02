import 'package:intl/intl.dart';

import '../../models/cart.dart';

class AppUtils {
  static String formatPrice(double value) {
    var priceFormat = NumberFormat('#,###');
    return priceFormat.format(value);
  }

  static String formatDateTime(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  static double calculateTotalPrice(List<Cart> dataList) {
    double totalPrice = 0;
    for (Cart cart in dataList) {
      totalPrice = totalPrice + cart.orderQuantity * cart.product.getPrice();
    }
    return totalPrice;
  }

  static String formatOrderStatus(int status) {
    switch (status) {
      case 0:
        return 'Đang vận chuyển';
      case 1:
        return 'Đã hoàn thành';
      case 2:
        return 'Đã huỷ';
      default:
        return 'Đang vận chuyển';
    }
  }

  static String formatOrderTitleStatus(int status) {
    switch (status) {
      case 0:
        return 'Nhận hàng: Sau 2-3 ngày làm việc';
      case 1:
        return 'Đơn hàng đã hoàn thành';
      case 2:
        return 'Đơn hàng bị huỷ';
      default:
        return 'Đơn hàng đang vận chuyển';
    }
  }
}
