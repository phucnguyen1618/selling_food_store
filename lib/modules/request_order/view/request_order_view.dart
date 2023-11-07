import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:selling_food_store/models/cart.dart';
import 'package:selling_food_store/modules/request_order/bloc/request_order_bloc.dart';
import 'package:selling_food_store/modules/request_order/bloc/request_order_event.dart';
import 'package:selling_food_store/modules/request_order/bloc/request_order_state.dart';
import 'package:selling_food_store/modules/request_order/view/choose_payment_method.dart';

import '../../../shared/utils/app_color.dart';
import '../../../shared/utils/app_utils.dart';
import '../../../shared/utils/strings.dart';
import '../../../shared/widgets/general/general_button.dart';
import 'cart_order_info.dart';
import 'user_info_widget.dart';

class RequestOrderView extends StatefulWidget {
  const RequestOrderView({super.key});

  @override
  State<RequestOrderView> createState() => _RequestOrderViewState();
}

class _RequestOrderViewState extends State<RequestOrderView> {
  List<Cart> cartList = [];
  double orderPrice = 0;
  double totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RequestOrderBloc, RequestOrderState>(
      builder: ((context, state) {
        if (state is DisplayProductForRequestOrderState) {
          cartList = state.cartList;
          orderPrice = state.orderPrice;
          totalPrice = state.totalPrice;
        }
        return Scaffold(
          backgroundColor: AppColor.whiteColor,
          appBar: AppBar(
            backgroundColor: AppColor.whiteColor,
            elevation: 1.0,
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColor.blackColor,
                )),
            title: Text(
              'detailRequestOrder'.tr(),
              style: const TextStyle(
                color: AppColor.blackColor,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const UserInfoWidget(),
                Container(
                  color: AppColor.dividerColor,
                  height: 12.0,
                ),
                CartOrderInfo(carts: cartList),
                Container(
                  color: AppColor.dividerColor,
                  height: 12.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'requestOrder'.tr(),
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: AppColor.blackColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'totalProductPrice'.tr(),
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            '${AppUtils.formatPrice(orderPrice)}đ',
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: AppColor.blackColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'shippingFee'.tr(),
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            AppUtils.formatPrice(Strings.shippingFeeValue),
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: AppColor.blackColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'totalPrice'.tr(),
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: AppColor.blackColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${AppUtils.formatPrice(totalPrice)}đ',
                            style: const TextStyle(
                              fontSize: 18.0,
                              color: AppColor.blackColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  color: AppColor.dividerColor,
                  height: 12.0,
                ),
                const ChoosePaymentMethod(),
              ],
            ),
          ),
          persistentFooterButtons: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'totalPrice'.tr(),
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: AppColor.blackColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${AppUtils.formatPrice(totalPrice)}đ',
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: AppColor.blackColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  GeneralButton(
                    title: 'order'.tr(),
                    onClick: () {
                      context
                          .read<RequestOrderBloc>()
                          .add(OnRequestOrderProductEvent(cartList, null));
                    },
                  )
                ],
              ),
            )
          ],
        );
      }),
      listener: (context, state) {
        if (state is RequestOrderProductSuccessState) {
          context.goNamed('confirmOrder');
        } else if (state is IncreaseNumberProductState) {}
      },
    );
  }
}
