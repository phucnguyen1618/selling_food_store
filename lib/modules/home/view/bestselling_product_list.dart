import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../shared/utils/app_color.dart';
import '../../../shared/utils/app_utils.dart';
import '../../../shared/utils/strings.dart';

class BestSellingProductList extends StatelessWidget {
  const BestSellingProductList({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = MediaQuery.of(context).size.width * 0.45;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'bestSellingProduct'.tr(),
              style: const TextStyle(
                fontSize: 18.0,
                color: AppColor.sologanColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(right: 12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(
              10,
              (index) => Container(
                width: baseWidth,
                padding: const EdgeInsets.only(left: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CachedNetworkImage(
                      width: baseWidth,
                      height: 220.0,
                      imageUrl: Strings.avatarDemo,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.error, color: AppColor.hintGreyColor),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      Strings.nameProduct,
                      maxLines: 2,
                      style: TextStyle(
                        color: AppColor.blackColor,
                        overflow: TextOverflow.ellipsis,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      AppUtils.formatPrice(Strings.costProduct),
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
                      onPressed: () {},
                      elevation: 0.0,
                      minWidth: baseWidth,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      color: AppColor.buttonBuyColor,
                      child: Text(
                        'textbuyNow'.tr(),
                        style: const TextStyle(
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
                        onRatingUpdate: (value) {}),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
