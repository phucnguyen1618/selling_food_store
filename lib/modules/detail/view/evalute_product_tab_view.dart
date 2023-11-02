import 'package:flutter/material.dart';
import 'package:selling_food_store/shared/widgets/items/item_feedback.dart';

import '../../../shared/utils/app_color.dart';
import '../../../shared/utils/strings.dart';

class EvaluteProductTabView extends StatelessWidget {
  const EvaluteProductTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Expanded(
                child: Text(
                  Strings.customerReviews,
                  style: TextStyle(
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Text(
                Strings.viewMore,
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24.0),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(2, (index) => const ItemFeedback()),
          ),
        ],
      ),
    );
  }
}
