import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppUtils {
  static String formatPrice(double value) {
    var priceFormat = NumberFormat('#,###');
    return priceFormat.format(value);
  }

  static String formatSold(double value) {
    var soldFormat = NumberFormat('#,###');
    return soldFormat.format(value);
  }

  static String formatDateTime(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  static double calculateTotalPrice(List<double> dataList) {
    double totalPrice = 0;
    for (double value in dataList) {
      totalPrice = totalPrice + value;
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

  static Color generateIconColor(int type) {
    switch (type) {
      case 0:
        return Colors.amberAccent;
      case 1:
        return Colors.teal;
      case 2:
        return Colors.red;
      case 3:
        return Colors.green;
      case 4:
        return Colors.blue.shade900;
      default:
        return Colors.black;
    }
  }

  static String generateNameAvatar(String fullName) {
    String nameAvatar = '';
    final splitted = fullName.split(' ');
    for (var str in splitted) {
      nameAvatar = nameAvatar + str.substring(0, 1);
    }
    return nameAvatar;
  }

  static String convertVNDToUSD(double value) {
    final result = value * 0.000041;
    return result.toString();
  }

  static String getInvoiceNumber(String value) {
    if (value.contains(':')) {
      final splitted = value.split(':');
      String dataStr = splitted[2];
      String data1 = dataStr.replaceAll('"', '').replaceAll('}', '');
      return data1.substring(1, data1.length - 1);
    }
    return value;
  }
}
