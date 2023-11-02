import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../utils/app_color.dart';
import '../../utils/strings.dart';

class ItemFeedback extends StatelessWidget {
  const ItemFeedback({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 30.0,
                height: 30.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 12.0),
              const Text(
                Strings.titleNameUserFeedbackDemo,
                style: TextStyle(
                  fontSize: 14.0,
                  color: AppColor.blackColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          RatingBar.builder(
              itemCount: 5,
              initialRating: 3,
              allowHalfRating: true,
              unratedColor: AppColor.shimmerColor,
              itemSize: 12.0,
              itemBuilder: (context, index) =>
                  const Icon(Icons.star, color: Colors.amber),
              onRatingUpdate: (newValue) {}),
          const SizedBox(height: 12.0),
          const Text(
            Strings.contentFeedbackDemo,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
