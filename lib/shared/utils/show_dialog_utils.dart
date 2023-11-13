import 'package:flutter/material.dart';
import 'package:selling_food_store/models/review.dart';
import 'package:selling_food_store/shared/widgets/dialog/feedback_product_dialog.dart';
import 'package:selling_food_store/shared/widgets/dialog/notify_dialog.dart';
import 'package:selling_food_store/shared/widgets/dialog/request_signIn_dialog.dart';

import '../../models/cart.dart';

class ShowDialogUtils {
  static void showDialogRequestSignIn(
      BuildContext context, Function() onClose) {
    showDialog(
      context: context,
      builder: (context) => const RequestSignInDialog(),
    ).then((value) {
      onClose();
    });
  }

  static void showDialogNotify({
    required BuildContext context,
    String? message,
    required NotifyTypeDialog typeDialog,
    Function()? onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (context) => NotifyDialog(
        message: message,
        notifyType: typeDialog,
      ),
    ).then((value) {
      if (value != null) {
        if (onConfirm != null) {
          onConfirm();
        }
      }
    });
  }

  static void showDialogFeedback(
    BuildContext context,
    Cart cart,
    Function(double, String) onFeedback,
  ) {
    showDialog(
      context: context,
      builder: (context) => const FeedbackProductDialog(),
    ).then((value) {
      if (value != null) {
        double data1 = value['rating'] as double;
        String data2 = value['review'] as String;
        onFeedback(data1, data2);
      }
    });
  }
}
