import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../shared/utils/app_color.dart';
import '../../shared/utils/strings.dart';

class ConfirmOrderPage extends StatelessWidget {
  const ConfirmOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            const Text(
              Strings.titleConfirmOrder,
              style: TextStyle(
                fontSize: 18.0,
                color: AppColor.blackColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              Strings.shippingInfoOrder,
              style: TextStyle(
                fontSize: 16.0,
                color: AppColor.blackColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                'Người nhận: Nguyễn Hoàng Phúc (+84392634700)\nĐịa chỉ: Cạnh số nhà 28, đường Ngô Đức Kế, Vinh Tân, Thành phố Vinh, tỉnh Nghệ An.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade400),
              ),
            ),
            const SizedBox(height: 24.0),
            InkWell(
              onTap: () {
                context.pop();
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
                child: const Text(
                  Strings.homeComeBack,
                  style: TextStyle(color: AppColor.primaryAppColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
