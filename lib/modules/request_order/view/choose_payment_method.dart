import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../shared/utils/app_color.dart';

class ChoosePaymentMethod extends StatefulWidget {
  const ChoosePaymentMethod({super.key});

  @override
  State<ChoosePaymentMethod> createState() => _ChoosePaymentMethodState();
}

class _ChoosePaymentMethodState extends State<ChoosePaymentMethod> {
  bool? selectedPaymentMethod = true;
  int paymentMethodValue = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'paymentMethod'.tr(),
            style: const TextStyle(
              fontSize: 16.0,
              color: AppColor.blackColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12.0),
          RadioListTile(
            value: true,
            groupValue: selectedPaymentMethod,
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.trailing,
            title: Text(
              'codPaymentMethod'.tr(),
              style: const TextStyle(
                fontSize: 14.0,
                color: AppColor.blackColor,
              ),
            ),
            onChanged: (value) {
              setState(() {
                selectedPaymentMethod = value;
                paymentMethodValue = 0;
              });
            },
          ),
          RadioListTile(
            value: false,
            groupValue: selectedPaymentMethod,
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.trailing,
            title: Text(
              'momoPaymentMethod'.tr(),
              style: const TextStyle(
                fontSize: 14.0,
                color: AppColor.blackColor,
              ),
            ),
            onChanged: (value) {
              setState(() {
                selectedPaymentMethod = value;
                paymentMethodValue = 1;
              });
            },
          ),
        ],
      ),
    );
  }
}
