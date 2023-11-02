import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:selling_food_store/models/product.dart';
import 'package:selling_food_store/shared/utils/app_utils.dart';

import '../../utils/app_color.dart';
import '../../utils/strings.dart';

class ItemBestSelling extends StatelessWidget {
  final Product product;
  final Function(Product) onBuyNow;
  final Function() onClick;

  const ItemBestSelling({
    super.key,
    required this.onClick,
    required this.product,
    required this.onBuyNow,
  });

  @override
  Widget build(BuildContext context) {
    double baseWidth = MediaQuery.of(context).size.width * 0.45;
    return InkWell(
      onTap: () {
        onClick();
      },
      child: Container(
        width: baseWidth,
        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CachedNetworkImage(
              width: baseWidth,
              height: 220.0,
              imageUrl: product.image,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) =>
                  Icon(Icons.error, color: AppColor.hintGreyColor),
            ),
            const SizedBox(height: 8.0),
            Text(
              product.name,
              maxLines: 2,
              style: const TextStyle(
                color: AppColor.blackColor,
                overflow: TextOverflow.ellipsis,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5.0),
            Text(
              AppUtils.formatPrice(product.getPrice()),
              maxLines: 1,
              style: const TextStyle(
                color: AppColor.priceProductColor,
                overflow: TextOverflow.ellipsis,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5.0),
            MaterialButton(
              onPressed: () {
                onBuyNow(product);
              },
              elevation: 0.0,
              minWidth: baseWidth,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              color: AppColor.buttonBuyColor,
              child: const Text(
                Strings.textbuyNow,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ),
            RatingBar.builder(
                itemCount: 5,
                initialRating: 3,
                allowHalfRating: true,
                itemSize: 16.0,
                itemBuilder: ((context, index) => const Icon(
                      Icons.star,
                      color: AppColor.starColor,
                    )),
                onRatingUpdate: (value) {})
          ],
        ),
      ),
    );
  }
}
