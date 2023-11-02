import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:selling_food_store/modules/order_list/bloc/order_list_bloc.dart';
import 'package:selling_food_store/modules/order_list/bloc/order_list_state.dart';

import '../../../shared/utils/app_color.dart';
import '../../../shared/widgets/items/item_order.dart';

class OrderListView extends StatelessWidget {
  const OrderListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderListBloc, OrderListState>(
        builder: (context, state) => DefaultTabController(
              length: 4,
              child: Scaffold(
                backgroundColor: AppColor.whiteColor,
                appBar: AppBar(
                  backgroundColor: AppColor.whiteColor,
                  elevation: 1.0,
                  centerTitle: true,
                  title: const Text(
                    'Đơn hàng của bạn',
                    style: TextStyle(
                      color: AppColor.blackColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  bottom: TabBar(
                    tabs: const [
                      Tab(text: 'Tất cả'),
                      Tab(text: 'Đang vận chuyển'),
                      Tab(text: 'Đã hoàn thành'),
                      Tab(text: 'Đã huỷ'),
                    ],
                    labelColor: Colors.blue,
                    indicatorSize: TabBarIndicatorSize.tab,
                    isScrollable: true,
                    unselectedLabelColor: Colors.grey,
                    onTap: (value) {
                      context
                          .read<OrderListBloc>()
                          .filterOrderListFromStatus(value);
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
                body: state.orders.isNotEmpty
                    ? Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                              itemCount: state.orders.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) =>
                                  ItemOrder(requestOrder: state.orders[index]),
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
            ));
  }
}
