import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_food_store/modules/tracking_order/bloc/tracking_order_bloc.dart';
import 'package:selling_food_store/modules/tracking_order/bloc/tracking_order_event.dart';
import 'package:selling_food_store/modules/tracking_order/bloc/tracking_order_state.dart';
import 'package:url_launcher/url_launcher.dart';

class TrackingOrderView extends StatefulWidget {
  const TrackingOrderView({super.key});

  @override
  State<TrackingOrderView> createState() => _TrackingOrderViewState();
}

class _TrackingOrderViewState extends State<TrackingOrderView> {
  String id = '';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TrackingOrderBloc, TrackingOrderState>(
        builder: (context, state) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Center(
              child: MaterialButton(
                onPressed: () {
                  context
                      .read<TrackingOrderBloc>()
                      .add(OnRequestPaymentEvent(id));
                },
                elevation: 0.0,
                color: Colors.blue,
                child: const Text(
                  'Payment',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }, listener: (context, state) async {
      if (state is GetIDInvoiceState) {
        id = state.id;
      }
      if (state is RequestPaymentState) {
        await launchUrl(Uri.parse(state.urlRequest));
        backToHome();
      }
    });
  }

  void backToHome() {
    Navigator.popUntil(context, ModalRoute.withName('home'));
  }
}
