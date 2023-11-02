import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_food_store/models/product.dart';
import 'package:selling_food_store/modules/request_order/bloc/request_order_bloc.dart';
import 'package:selling_food_store/modules/request_order/bloc/request_order_event.dart';
import 'package:selling_food_store/modules/request_order/view/request_order_view.dart';

import '../../models/cart.dart';

class RequestOrderPage extends StatelessWidget {
  final List<Cart> carts;
  const RequestOrderPage({super.key, required this.carts});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RequestOrderBloc()
        ..add(OnLoadingRequestOrderEvent(carts))
        ..add(OnLoadingUserInfoEvent()),
      child: const RequestOrderView(),
    );
  }
}
