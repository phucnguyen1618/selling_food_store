import 'package:flutter/material.dart';
import 'package:selling_food_store/models/product.dart';
import 'package:selling_food_store/shared/utils/app_color.dart';
import 'package:selling_food_store/shared/utils/app_utils.dart';

import '../../utils/strings.dart';
import '../general/price_widget.dart';

import 'package:cached_network_image/cached_network_image.dart';

class ItemRecommendProduct extends StatelessWidget {
  final Product product;
  final Function() onClick;
  final Function() onBuy;
  final Function(Product product) onAddCart;

  const ItemRecommendProduct({
    super.key,
    required this.product,
    required this.onClick,
    required this.onBuy,
    required this.onAddCart,
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
        padding: const EdgeInsets.only(right: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CachedNetworkImage(
              width: double.infinity,
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
                color: Colors.black,
                overflow: TextOverflow.ellipsis,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
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
            PriceWidget(value: product.cost, isPrice: false),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                MaterialButton(
                  onPressed: () {
                    onBuy();
                  },
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  color: AppColor.buttonBuyColor,
                  child: const Text(
                    Strings.textbuyNow,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: AppColor.whiteColor,
                    ),
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: IconButton(
                      onPressed: () {
                        onAddCart(product);
                      },
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      icon: const Icon(
                        Icons.add_shopping_cart,
                        color: Colors.black,
                      )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
