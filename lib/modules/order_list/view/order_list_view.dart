import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:selling_food_store/models/request_order.dart';
import 'package:selling_food_store/modules/order_list/bloc/order_list_bloc.dart';
import 'package:selling_food_store/modules/order_list/bloc/order_list_event.dart';
import 'package:selling_food_store/modules/order_list/bloc/order_list_state.dart';
import 'package:selling_food_store/shared/utils/bottomsheet_utils.dart';
import 'package:selling_food_store/shared/widgets/general/empty_data_widget.dart';

import '../../../shared/utils/app_color.dart';
import '../../../shared/widgets/items/item_order.dart';

class OrderListView extends StatelessWidget {
  const OrderListView({super.key});

  @override
  Widget build(BuildContext context) {
    List<RequestOrder> orders = [];
    bool isLoading = true;
    return BlocConsumer<OrderListBloc, OrderListState>(
      builder: (context, state) {
        return DefaultTabController(
          length: 5,
          child: Scaffold(
            backgroundColor: AppColor.whiteColor,
            appBar: AppBar(
              backgroundColor: AppColor.whiteColor,
              elevation: 1.0,
              centerTitle: true,
              title: Text(
                'titleOrderList'.tr(),
                style: const TextStyle(
                  color: AppColor.blackColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              bottom: TabBar(
                tabs: [
                  Tab(text: 'allTab'.tr()),
                  Tab(text: 'confirmOrderTab'.tr()),
                  Tab(text: 'shippingTab'.tr()),
                  Tab(text: 'shippingSuccessTab'.tr()),
                  Tab(text: 'cancelOrderTab'.tr()),
                ],
                labelColor: Colors.blue,
                indicatorSize: TabBarIndicatorSize.tab,
                isScrollable: true,
                unselectedLabelColor: Colors.grey,
                onTap: (value) {
                  context
                      .read<OrderListBloc>()
                      .add(OnFilterOrderListEvent(value));
                },
              ),
              leading: IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: AppColor.blackColor,
                  )),
            ),
            body: isLoading
                ? const Center(child: CircularProgressIndicator())
                : orders.isNotEmpty
                    ? Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                              itemCount: orders.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) =>
                                  ItemOrder(requestOrder: orders[index]),
                              separatorBuilder: (context, index) => Container(
                                height: 10.0,
                                color: Colors.grey.shade100,
                              ),
                            ),
                          ),
                        ],
                      )
                    : const EmptyDataWidget(
                        emptyType: EmptyType.orderListEmpty),
          ),
        );
      },
      listener: (context, state) {
        if (state is CancelOrderState) {
          BottomSheetUtils.showBottomSheetSelectReasonForCancelOrder(
              context: context,
              onSelect: (String reason) {
                context
                    .read<OrderListBloc>()
                    .add(OnConfirmCancelOrderEvent(state.id, reason));
              },
              onClose: () {
                context.read<OrderListBloc>().add(OnCloseBottomSheetEvent());
              });
        } else if (state is DisplayOrderListState) {
          isLoading = false;
          orders = state.orders;
        } else if (state is CloseBottomSheetState) {
          log('bottom sheet is closed');
        } else if (state is ConfirmCancelOrderState) {
          EasyLoading.showSuccess('cancel_order_success'.tr());
        } else if (state is ErrorCancelOrderState) {
          EasyLoading.showError('unknown'.tr());
        } else if (state is FeedbackProductState) {
          EasyLoading.showToast('Cảm ơn bạn đã phản hồi');
        }
      },
    );
  }
}
