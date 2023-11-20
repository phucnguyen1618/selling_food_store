import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_food_store/modules/request_order/bloc/request_order_bloc.dart';
import 'package:selling_food_store/modules/request_order/bloc/request_order_event.dart';
import 'package:selling_food_store/modules/request_order/bloc/update_number_product_bloc.dart';
import 'package:selling_food_store/modules/request_order/view/request_order_view.dart';

import '../../models/cart.dart';

class RequestOrderPage extends StatelessWidget {
  final List<Cart> carts;
  final bool isBuyNow;

  const RequestOrderPage({
    super.key,
    required this.carts,
    required this.isBuyNow,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RequestOrderBloc()
            ..add(OnLoadingRequestOrderEvent(carts, isBuyNow))
            ..add(OnLoadingUserInfoEvent()),
        ),
        BlocProvider(create: (context) => UpdateNumberProductBloc()),
      ],
      child: const RequestOrderView(),
    );
  }
}
