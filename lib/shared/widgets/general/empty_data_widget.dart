import 'package:flutter/material.dart';
import '../../utils/app_color.dart';
import '../../utils/image_constants.dart';
import '../../utils/strings.dart';

class EmptyDataWidget extends StatelessWidget {
  final EmptyType emptyType;
  final Function()? onClick;

  const EmptyDataWidget({
    super.key,
    required this.emptyType,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    switch (emptyType) {
      case EmptyType.cartEmpty:
        return _buildCartsEmpty();
      case EmptyType.profileEmpty:
        return Center(child: _buildUserInfoEmpty(context));
      case EmptyType.productListEmpty:
        return _buildUIProductListEmpty(context);
      case EmptyType.userNotSigIn:
        return _buildUINotSignIn();
      case EmptyType.orderListEmpty:
        return _buildOrderListEmpty();
    }
  }

  Widget _buildCartsEmpty() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(
              Icons.shopping_bag_outlined,
              size: 56.0,
            ),
            SizedBox(height: 12.0),
            Text(
              Strings.emptyCartText,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoEmpty(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          ImageConstants.imageUnLogin,
          width: 200.0,
          height: 200.0,
        ),
        const SizedBox(height: 12.0),
        const Text(Strings.youNotLogin),
        const SizedBox(height: 12.0),
        MaterialButton(
          onPressed: () {
            if (onClick != null) {
              onClick!();
            }
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
            side: const BorderSide(color: AppColor.primaryAppColor),
          ),
          elevation: 0.0,
          color: AppColor.whiteColor,
          child: const Text(
            Strings.textSignIn,
            style: TextStyle(
              color: AppColor.primaryAppColor,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildUIProductListEmpty(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(
              Icons.error_outline,
              size: 56.0,
            ),
            SizedBox(height: 12.0),
            Text(
              Strings.productListEmpty,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUINotSignIn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [],
    );
  }

  Widget _buildOrderListEmpty() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text(
            Strings.titleOrderListEmpty,
            style: TextStyle(
              fontSize: 16.0,
              color: AppColor.blackColor,
            ),
          ),
        ],
      ),
    );
  }
}

enum EmptyType {
  cartEmpty,
  profileEmpty,
  productListEmpty,
  userNotSigIn,
  orderListEmpty
}
