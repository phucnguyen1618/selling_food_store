import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:selling_food_store/models/cart.dart';
import 'package:selling_food_store/modules/order/bloc/order_bloc.dart';
import 'package:selling_food_store/modules/order/bloc/order_event.dart';
import 'package:selling_food_store/modules/order/bloc/order_state.dart';
import 'package:selling_food_store/modules/order/bloc/update_number_product_bloc.dart';
import 'package:selling_food_store/modules/order/view/choose_payment_method.dart';
import 'package:selling_food_store/modules/order/view/display_price.dart';

import '../../../shared/utils/app_color.dart';
import '../../../shared/utils/app_utils.dart';
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
    return BlocConsumer<OrderBloc, OrderState>(
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
                DisplayPrice(order: orderPrice, total: totalPrice),
                Container(
                  color: AppColor.dividerColor,
                  height: 12.0,
                ),
                const ChoosePaymentMethod(),
              ],
            ),
          ),
          persistentFooterButtons: [
            BlocBuilder<UpdateNumberProductBloc, OrderState>(
                builder: ((context, state) {
              if (state is UpdateNumberProductState) {
                totalPrice = state.price + 20000;
              }
              return Padding(
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
                            .read<OrderBloc>()
                            .add(OnRequestOrderProductEvent(cartList, null));
                      },
                    )
                  ],
                ),
              );
            }))
          ],
        );
      }),
      listener: (context, state) {
        if (state is RequestOrderProductSuccessState) {
          context.goNamed('confirmOrder', extra: {
            "name": state.name,
            "address": state.address,
          });
        } else if (state is RequestOrderProductFailureState) {
          EasyLoading.showError(state.message);
        } else if (state is ChoosePaymentMethodState) {
          log('Payment method is ${state.value}');
        }
      },
    );
  }
}
