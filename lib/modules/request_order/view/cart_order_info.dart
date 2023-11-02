import 'package:flutter/material.dart';
import 'package:selling_food_store/shared/widgets/items/item_product_order_info.dart';

import '../../../models/cart.dart';

class CartOrderInfo extends StatelessWidget {
  final List<Cart> carts;
  const CartOrderInfo({super.key, required this.carts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: carts.length,
        itemBuilder: ((context, index) =>
            ItemProductOrderInfo(cart: carts[index])));
  }
}
