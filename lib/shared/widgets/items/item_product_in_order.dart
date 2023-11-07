import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:selling_food_store/models/cart.dart';
import 'package:selling_food_store/shared/utils/app_utils.dart';
import 'package:selling_food_store/shared/utils/show_dialog_utils.dart';

import '../../utils/app_color.dart';
import '../../utils/strings.dart';

class ItemProductInOrder extends StatelessWidget {
  final Cart cart;
  final int status;

  const ItemProductInOrder({
    super.key,
    required this.cart,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    double baseWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      child: Column(
        children: [
          ListTile(
            horizontalTitleGap: 0.0,
            leading: Container(
                width: 30.0,
                height: 30.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(cart.product.brand.logoBrand)),
                )),
            contentPadding: EdgeInsets.zero,
            title: Text(
              cart.product.brand.name,
              style: const TextStyle(
                fontSize: 16.0,
                color: AppColor.blackColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Text(
              AppUtils.formatOrderStatus(status),
              style: const TextStyle(
                color: AppColor.blackColor,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              CachedNetworkImage(
                width: 80.0,
                height: 80.0,
                imageUrl: cart.product.image,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) =>
                    Icon(Icons.error, color: AppColor.hintGreyColor),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      cart.product.name,
                      maxLines: 2,
                      style: const TextStyle(
                        color: AppColor.blackColor,
                        fontSize: 14.0,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          AppUtils.formatOrderTitleStatus(status),
                          style: const TextStyle(
                            color: AppColor.blackColor,
                            fontSize: 14.0,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppUtils.formatPrice(cart.product.getPrice()),
                              style: const TextStyle(
                                color: AppColor.blackColor,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'x${cart.orderQuantity}',
                              style: const TextStyle(
                                color: AppColor.blackColor,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          status == 2
              ? Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () {
                          context
                              .goNamed('requestOrderToBuyNow', extra: [cart]);
                        },
                        child: Container(
                          width: baseWidth / 3,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 6.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              border: Border.all(
                                  width: 1.0, color: Colors.black12)),
                          child: const Text(
                            Strings.repurchase,
                            style: TextStyle(
                              color: AppColor.blackColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      InkWell(
                        onTap: () {
                          ShowDialogUtils.showDialogFeedback(context);
                        },
                        child: Container(
                          width: baseWidth / 3,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 6.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              color: Colors.redAccent),
                          child: const Text(
                            Strings.feedback,
                            style: TextStyle(
                              color: AppColor.whiteColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : status == 3
                  ? InkWell(
                      onTap: () {
                        context.goNamed('requestOrderToBuyNow', extra: [cart]);
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: baseWidth / 3,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 6.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              border: Border.all(
                                  width: 1.0, color: Colors.black12)),
                          child: const Text(
                            Strings.buyNow,
                            style: TextStyle(
                              color: AppColor.blackColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
        ],
      ),
    );
  }
}
