import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_food_store/models/cart.dart';
import 'package:selling_food_store/models/product.dart';
import 'package:selling_food_store/modules/cart/bloc/cart_event.dart';
import 'package:selling_food_store/modules/cart/bloc/cart_state.dart';
import 'package:selling_food_store/modules/cart/bloc/item_cart_bloc.dart';
import 'package:selling_food_store/shared/utils/app_utils.dart';

import '../../utils/app_color.dart';
import '../general/price_widget.dart';

class ItemCart extends StatefulWidget {
  final Cart cart;
  const ItemCart({
    super.key,
    required this.cart,
  });

  @override
  State<ItemCart> createState() => _ItemCartState();
}

class _ItemCartState extends State<ItemCart> {
  int quantity = 0;
  double? price;
  Product? product;
  bool isDeleteItem = false;

  @override
  void initState() {
    quantity = widget.cart.orderQuantity;
    product = widget.cart.product;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ItemCart oldWidget) {
    if (oldWidget.cart != widget.cart) {
      product = widget.cart.product;
      price = widget.cart.orderQuantity * product!.getPrice();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemCartBloc, CartState>(
      builder: (context, state) {
        if (state is OnDeleteItemCartState) {
          isDeleteItem = state.value;
        }
        return Card(
          color: AppColor.whiteColor,
          elevation: 0.0,
          margin: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  horizontalTitleGap: 0.0,
                  leading: CachedNetworkImage(
                    width: 30.0,
                    height: 30.0,
                    imageUrl: product!.brand.logoBrand,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.error, color: AppColor.hintGreyColor),
                  ),
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    product!.brand.name,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: AppColor.blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "${'textAddToCart'.tr()} ${AppUtils.formatDateTime(widget.cart.dateTimeOrder)}",
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 12.0,
                    ),
                  ),
                  trailing: isDeleteItem
                      ? Checkbox(
                          value: isDeleteItem,
                          onChanged: (value) {
                            setState(() {
                              isDeleteItem = !isDeleteItem;
                            });
                          },
                        )
                      : const SizedBox(),
                ),
                const SizedBox(height: 8.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CachedNetworkImage(
                      width: 80.0,
                      height: 80.0,
                      imageUrl: product!.image,
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
                            product!.name,
                            maxLines: 2,
                            style: const TextStyle(
                              color: AppColor.blackColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                AppUtils.formatPrice(
                                    price ?? product!.getPrice()),
                                style: const TextStyle(
                                  color: AppColor.primaryAppColor,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              PriceWidget(
                                value: product!.cost,
                                textSize: 14.0,
                                priceTextColor: AppColor.shimmerColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              quantity++;
                              widget.cart.updateQuantity(quantity);
                            });
                            context.read<ItemCartBloc>().add(
                                OnIncreaseQuantityEvent(product!.getPrice()));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: const Icon(Icons.add, size: 12.0),
                          ),
                        ),
                        const SizedBox(height: 2.0),
                        Text(
                          '$quantity',
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2.0),
                        InkWell(
                          onTap: () {
                            setState(() {
                              quantity--;
                              if (quantity <= 0) {
                                quantity = 1;
                              }
                              widget.cart.updateQuantity(quantity);
                            });
                            context.read<ItemCartBloc>().add(
                                OnDecreaseQuantityEvent(product!.getPrice()));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: const Icon(Icons.remove, size: 12.0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
