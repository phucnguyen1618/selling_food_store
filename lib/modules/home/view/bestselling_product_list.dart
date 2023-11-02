import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/utils/app_color.dart';
import '../../../shared/utils/strings.dart';
import '../../../shared/widgets/items/item_best_selling.dart';

class BestSellingProductList extends StatelessWidget {
  const BestSellingProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              Strings.bestSellingProduct,
              style: TextStyle(
                fontSize: 18.0,
                color: AppColor.sologanColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        // SingleChildScrollView(
        //   scrollDirection: Axis.horizontal,
        //   padding: const EdgeInsets.only(right: 12.0),
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: List.generate(
        //         10,
        //             (index) => ItemBestSelling(onClick: () {
        //           context.goNamed('productDetail');
        //         }, product: null,)),
        //   ),
        // ),
      ],
    );
  }
}
