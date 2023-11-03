import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:selling_food_store/shared/utils/app_utils.dart';

import '../../utils/app_color.dart';
import '../../utils/strings.dart';

class FeedbackProductDialog extends StatefulWidget {
  const FeedbackProductDialog({super.key});

  @override
  State<FeedbackProductDialog> createState() => _FeedbackProductDialogState();
}

class _FeedbackProductDialogState extends State<FeedbackProductDialog> {
  double rating = 0;
  @override
  Widget build(BuildContext context) {
    double baseWidth = MediaQuery.of(context).size.width;
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      title: const Center(
        child: Text(
          Strings.titleFeedbackProduct,
          style: TextStyle(
            fontSize: 18.0,
            color: AppColor.blackColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: baseWidth - 16 * 2,
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12.0),
            RatingBar.builder(
              unratedColor: AppColor.shimmerColor,
              initialRating: rating,
              itemBuilder: (context, index) => const Icon(
                Icons.star,
                color: Colors.pinkAccent,
              ),
              onRatingUpdate: (value) {
                setState(() {
                  rating = value;
                });
              },
            ),
            const SizedBox(height: 12.0),
            rating != 0
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      AppUtils.formatFeedbackStatus(rating),
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.pinkAccent,
                      ),
                    ),
                  )
                : const SizedBox(),
            const TextField(
              maxLines: 5,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: Strings.inputFeedback,
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {},
            child: const Text(
              Strings.sendFeedback,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.blue,
              ),
            ))
      ],
    );
  }
}
