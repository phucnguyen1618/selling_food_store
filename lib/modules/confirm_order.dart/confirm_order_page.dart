import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:selling_food_store/modules/confirm_order.dart/suggestion_product_list.dart';

import '../../shared/utils/app_color.dart';

class ConfirmOrderPage extends StatelessWidget {
  final String name;
  final String address;

  const ConfirmOrderPage({
    super.key,
    required this.name,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: AppColor.blackColor,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 32.0),
            const Icon(
              Icons.check_circle,
              color: AppColor.primaryAppColor,
              size: 56.0,
            ),
            const SizedBox(height: 12.0),
            Text(
              'titleConfirmOrder'.tr(),
              style: const TextStyle(
                fontSize: 18.0,
                color: AppColor.blackColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'shippingInfoOrder'.tr(),
              style: const TextStyle(
                fontSize: 16.0,
                color: AppColor.blackColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                'Người nhận: $name (+84392634700)\nĐịa chỉ: $address',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade400),
              ),
            ),
            const SizedBox(height: 24.0),
            InkWell(
              onTap: () {
                context.pushReplacementNamed('home');
              },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 12.0),
                decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  border:
                      Border.all(width: 1.0, color: AppColor.primaryAppColor),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  'homeComeBack'.tr(),
                  style: const TextStyle(color: AppColor.primaryAppColor),
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            const SuggestionProductList(),
          ],
        ),
      ),
    );
  }
}
