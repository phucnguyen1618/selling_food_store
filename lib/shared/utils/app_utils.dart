import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

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
        return 'ordered'.tr();
      case 1:
        return 'delivering'.tr();
      case 2:
        return 'accomplished'.tr();
      case 3:
        return 'canceled'.tr();
      default:
        return 'delivering'.tr();
    }
  }

  static String formatOrderTitleStatus(int status) {
    switch (status) {
      case 0:
        return 'text_ordered'.tr();
      case 1:
        return 'text_delivering'.tr();
      case 2:
        return 'text_order_success'.tr();
      case 3:
        return 'text_canceled'.tr();
      default:
        return 'text_delivering'.tr();
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

  static String generateAvatarText(String name) {
    var textStr = name.split(' ');
    String value1 = textStr[0];
    String value2 = textStr[1];
    return value1.characters.first.toUpperCase() +
        value2.characters.first.toUpperCase();
  }
}
