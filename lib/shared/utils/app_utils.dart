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
        return 'Đã đặt hàng';
      case 1:
        return 'Đang giao hàng';
      case 2:
        return 'Đã hoàn thành';
      case 3:
        return 'Đã huỷ';
      default:
        return 'Đang giao hàng';
    }
  }

  static String formatOrderTitleStatus(int status) {
    switch (status) {
      case 0:
        return 'Nhận hàng: Sau 2-3 ngày làm việc';
      case 1:
        return 'Đơn hàng đang được vận chuyển';
      case 2:
        return 'Đơn hàng đã hoàn thành';
      case 3:
        return 'Đơn hàng bị huỷ';
      default:
        return 'Đơn hàng đang vận chuyển';
    }
  }

  static String formatFeedbackStatus(double rating) {
    switch (rating.toInt()) {
      case 1:
        return 'Rất kém';
      case 2:
        return 'Kém';
      case 3:
        return 'Bình thường';
      case 4:
        return 'Tốt';
      case 5:
        return 'Rất tốt';
      default:
        return 'Bình thường';
    }
  }
}
