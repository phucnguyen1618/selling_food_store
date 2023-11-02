import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:selling_food_store/models/product.dart';
import 'package:selling_food_store/shared/utils/app_color.dart';

import '../../utils/strings.dart';
import 'price_widget.dart';

class AddToCartBottomSheet extends StatefulWidget {
  final Product product;
  const AddToCartBottomSheet({
    super.key,
    required this.product,
  });

  @override
  State<AddToCartBottomSheet> createState() => _AddToCartBottomSheetState();
}

class _AddToCartBottomSheetState extends State<AddToCartBottomSheet> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CachedNetworkImage(
                    width: 120.0,
                    height: 120.0,
                    imageUrl: widget.product.image,
                    fit: BoxFit.cover,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.error, color: AppColor.hintGreyColor),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.product.name,
                          maxLines: 2,
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: AppColor.blackColor,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            PriceWidget(
                              value: widget.product.getPrice() * quantity,
                              isPrice: true,
                              textSize: 18.0,
                              priceTextColor: AppColor.priceProductColor,
                            ),
                            const SizedBox(width: 8.0),
                            PriceWidget(
                              value: widget.product.cost,
                              textSize: 14.0,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  quantity++;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade50,
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: const Icon(Icons.add, size: 16.0),
                              ),
                            ),
                            const SizedBox(width: 12.0),
                            Text(
                              '$quantity',
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 12.0),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  quantity--;
                                  if (quantity <= 0) {
                                    quantity = 1;
                                  }
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade50,
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: const Icon(Icons.remove, size: 16.0),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12.0),
              Text(widget.product.description),
              const SizedBox(height: 12.0),
            ],
          ),
          MaterialButton(
            onPressed: () {
              context.pop({
                'quantity': quantity,
                'product': widget.product.toJson(),
              });
            },
            color: AppColor.primaryAppColor,
            minWidth: double.infinity,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: const Text(
              Strings.titleAddCartButton,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
