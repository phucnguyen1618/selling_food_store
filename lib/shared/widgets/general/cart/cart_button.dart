import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:selling_food_store/shared/widgets/general/cart/cart_bloc.dart';
import 'package:selling_food_store/shared/widgets/general/cart/cart_state.dart';

import 'package:badges/badges.dart' as badges;

import '../../../utils/app_color.dart';
import '../../../utils/strings.dart';

class CartButton extends StatelessWidget {
  const CartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartButtonBloc, CartButtonState>(
        builder: (context, state) {
      int numberCart = 0;
      if (state is InitCartButtonState) {
        numberCart = state.value;
      } else if (state is UpdateNumberProductInCartWhenAddState) {
        numberCart = state.value;
      } else if (state is UpdateNumberProductInCartWhenRemoveState) {
        numberCart = state.value;
      }
      return Center(
        child: badges.Badge(
            position: badges.BadgePosition.topEnd(top: 4, end: 4),
            showBadge: numberCart != 0,
            badgeContent: Text(
              numberCart <= 10 ? numberCart.toString() : Strings.upTenCart,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 8.0,
              ),
            ),
            child: IconButton(
              onPressed: () {
                context.goNamed('cart');
              },
              splashColor: AppColor.transparentColor,
              highlightColor: AppColor.transparentColor,
              focusColor: AppColor.transparentColor,
              hoverColor: AppColor.transparentColor,
              padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.shopping_cart_outlined,
                color: AppColor.blackColor,
              ),
            )),
      );
    });
  }
}
