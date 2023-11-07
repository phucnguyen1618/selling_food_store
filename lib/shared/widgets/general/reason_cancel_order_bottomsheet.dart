import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../utils/app_color.dart';

class ReasonCancelOrderBottomSheet extends StatefulWidget {
  const ReasonCancelOrderBottomSheet({super.key});

  @override
  State<ReasonCancelOrderBottomSheet> createState() =>
      _ReasonCancelOrderBottomSheetState();
}

class _ReasonCancelOrderBottomSheetState
    extends State<ReasonCancelOrderBottomSheet> {
  int isSelected = -1;
  List<String> reasons = [
    'Mặt hàng không đúng chất lượng như giới thiệu.',
    'Tôi muốn huỷ vì có sự nhầm lẫn trong quá trình đặt hàng.',
    'Vì có sự nhầm lần trong số lượng đặt sản phẩm.',
    'Vì có sự nhầm lẫn trong chọn phương thức thanh toán.',
    'Vì có sự nhầm lẫn trong chọn phương thức thanh toán.',
    'Vì muốn đặt sản phẩm khác có giá rẻ hơn.',
  ];
  @override
  Widget build(BuildContext context) {
    double baseWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 16.0),
        const Text(
          'Tại sao bạn lại huỷ đặt hàng ?',
          style: TextStyle(
            fontSize: 18.0,
            color: AppColor.blackColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16.0),
        ListView.builder(
          shrinkWrap: true,
          itemCount: reasons.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => RadioListTile(
              value: index,
              title: Text(
                reasons[index],
                style: const TextStyle(
                  fontSize: 14.0,
                  color: AppColor.blackColor,
                ),
              ),
              controlAffinity: ListTileControlAffinity.trailing,
              activeColor: Colors.pinkAccent,
              groupValue: isSelected,
              onChanged: (value) {
                setState(() {
                  isSelected = value ?? -1;
                });
              }),
        ),
        const SizedBox(height: 24.0),
        InkWell(
          onTap: () {
            context.pop(reasons[isSelected]);
          },
          child: Container(
            width: baseWidth - 16 * 2,
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              color: Colors.pinkAccent,
            ),
            child: const Text(
              'Xác nhận',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                color: AppColor.whiteColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
