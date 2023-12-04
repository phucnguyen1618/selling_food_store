import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selling_food_store/models/cart.dart';

import '../../utils/app_color.dart';
import '../../utils/app_utils.dart';

class ItemProductOrderInfo extends StatefulWidget {
  final Cart cart;
  final Function() onUpdate;

  const ItemProductOrderInfo({
    super.key,
    required this.cart,
    required this.onUpdate,
  });

  @override
  State<ItemProductOrderInfo> createState() => _ItemProductOrderInfoState();
}

class _ItemProductOrderInfoState extends State<ItemProductOrderInfo> {
  int quantity = 0;
  double price = 0;

  @override
  void initState() {
    quantity = widget.cart.quantity;
    //price = widget.cart.product.getPrice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime shippingDateTime = DateTime.now();
    //widget.cart.dateTimeOrder.add(const Duration(days: 2));
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // CachedNetworkImage(
              //   imageUrl: widget.cart.product.brand.logoBrand,
              //   width: 30.0,
              //   height: 30.0,
              //   fit: BoxFit.cover,
              //   imageBuilder: (context, provider) => Container(
              //     decoration: BoxDecoration(
              //       shape: BoxShape.circle,
              //       color: AppColor.primaryAppColor,
              //       image: DecorationImage(image: provider),
              //     ),
              //   ),
              //   progressIndicatorBuilder: (context, url, downloadProgress) =>
              //       CircularProgressIndicator(value: downloadProgress.progress),
              //   errorWidget: (context, url, error) =>
              //       Icon(Icons.error, color: AppColor.hintGreyColor),
              // ),
              const SizedBox(width: 12.0),
              Text(
                'widget.cart.product.brand.name',
                style: const TextStyle(
                  color: AppColor.blackColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Row(
            children: [
              // CachedNetworkImage(
              //   imageUrl: widget.cart.product.image,
              //   width: 100.0,
              //   height: 100.0,
              //   fit: BoxFit.cover,
              //   progressIndicatorBuilder: (context, url, downloadProgress) =>
              //       CircularProgressIndicator(value: downloadProgress.progress),
              //   errorWidget: (context, url, error) =>
              //       Icon(Icons.error, color: AppColor.hintGreyColor),
              // ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'widget.cart.product.name',
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 14.0,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    const Text(
                      'Strings.textDemo',
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 12.0,
                        overflow: TextOverflow.ellipsis,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      '${AppUtils.formatPrice(price)}đ',
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 16.0,
                        overflow: TextOverflow.ellipsis,
                        color: AppColor.blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "'{AppUtils.formatPrice(widget.cart.product.cost)}đ'",
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 14.0,
                            overflow: TextOverflow.ellipsis,
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                increaseNumberProduct();
                              },
                              child: const Icon(
                                Icons.add,
                                size: 16.0,
                                color: AppColor.primaryAppColor,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Text(
                                quantity.toString(),
                                maxLines: 1,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  color: AppColor.blackColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                decreaseNumberProduct();
                              },
                              child: const Icon(
                                Icons.remove,
                                size: 16.0,
                                color: AppColor.primaryAppColor,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 12.0),
          Text(
            '${'shippingOrderDate'.tr()} ${AppUtils.formatDateTime(shippingDateTime)}',
            maxLines: 1,
            style: const TextStyle(
              fontSize: 14.0,
              overflow: TextOverflow.ellipsis,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  void increaseNumberProduct() {
    setState(() {
      quantity++;
      widget.cart.updateQuantity(quantity);
      widget.onUpdate();
    });
  }

  void decreaseNumberProduct() {
    setState(() {
      quantity--;
      if (quantity <= 0) {
        quantity = 1;
      }
      widget.cart.updateQuantity(quantity);
      widget.onUpdate();
    });
  }
}
