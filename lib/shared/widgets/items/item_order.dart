import 'package:flutter/material.dart';
import 'package:selling_food_store/shared/widgets/items/item_product_in_order.dart';

import '../../../models/request_order.dart';
import '../../utils/app_color.dart';

class ItemOrder extends StatelessWidget {
  final RequestOrder requestOrder;
  const ItemOrder({super.key, required this.requestOrder});

  @override
  Widget build(BuildContext context) {
    double baseWidth = MediaQuery.of(context).size.width;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListView.builder(
            shrinkWrap: true,
            itemCount: requestOrder.cartList.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => ItemProductInOrder(
                  cart: requestOrder.cartList[index],
                  status: requestOrder.status,
                )),
        requestOrder.status == 0
            ? Container(
                width: baseWidth - 2 * 12,
                margin: const EdgeInsets.only(
                    bottom: 12.0, left: 12.0, right: 12.0),
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(width: 1.0, color: Colors.black12)),
                child: const Text(
                  'Huỷ đơn hàng',
                  style: TextStyle(
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : const SizedBox()
      ],
    );
  }
}
