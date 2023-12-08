import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_food_store/modules/tracking_order/bloc/tracking_order_bloc.dart';
import 'package:selling_food_store/modules/tracking_order/bloc/tracking_order_event.dart';
import 'package:selling_food_store/modules/tracking_order/view/tracking_order_view.dart';

class TrackingOrderPage extends StatelessWidget {
  final String id;

  const TrackingOrderPage({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TrackingOrderBloc()..add(OnInitTrackingOrderEvent(id)),
      child: const TrackingOrderView(),
    );
  }
}
