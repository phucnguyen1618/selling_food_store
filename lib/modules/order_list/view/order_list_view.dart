import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:selling_food_store/models/request_order.dart';
import 'package:selling_food_store/modules/order_list/bloc/order_list_bloc.dart';
import 'package:selling_food_store/modules/order_list/bloc/order_list_event.dart';
import 'package:selling_food_store/modules/order_list/bloc/order_list_state.dart';
import 'package:selling_food_store/shared/utils/bottomsheet_utils.dart';

import '../../../shared/utils/app_color.dart';
import '../../../shared/utils/strings.dart';
import '../../../shared/widgets/items/item_order.dart';

class OrderListView extends StatelessWidget {
  const OrderListView({super.key});

  @override
  Widget build(BuildContext context) {
    List<RequestOrder> orders = [];
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
              title: const Text(
                Strings.titleOrderList,
                style: TextStyle(
                  color: AppColor.blackColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              bottom: TabBar(
                tabs: const [
                  Tab(text: Strings.allTab),
                  Tab(text: Strings.confirmOrderTab),
                  Tab(text: Strings.shippingTab),
                  Tab(text: Strings.shippingSuccessTab),
                  Tab(text: Strings.cancelOrderTab),
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
            body: orders.isNotEmpty
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
                : const Center(child: CircularProgressIndicator()),
          ),
        );
      },
      listener: (context, state) {
        if (state is CancelOrderState) {
          BottomSheetUtils.showBottomSheetSelectReasonForCancelOrder(
            context: context,
            onSelect: () {},
          );
        } else if (state is DisplayOrderListState) {
          orders = state.orders;
        }
      },
    );
  }
}
