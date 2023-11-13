import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:selling_food_store/dependency_injection.dart';
import 'package:selling_food_store/modules/change_payment/bloc/change_payment_bloc.dart';
import 'package:selling_food_store/modules/change_payment/bloc/change_payment_event.dart';
import 'package:selling_food_store/modules/change_payment/bloc/change_payment_state.dart';
import 'package:selling_food_store/shared/utils/image_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../shared/utils/app_color.dart';
import '../../../shared/utils/strings.dart';

class ChangePaymentView extends StatelessWidget {
  const ChangePaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    final prefs = getIt.get<SharedPreferences>();
    return BlocBuilder<ChangePaymentBloc, ChangePaymentState>(
        builder: (context, state) {
      int payment = prefs.getInt(Strings.paymentMethod) ?? -1;
      if (state is ChoosePaymentMethodState) {
        payment = state.value;
      }
      return Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: AppBar(
          backgroundColor: AppColor.whiteColor,
          elevation: 0.0,
          leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: AppColor.blackColor,
              )),
          title: const Text(
            'Chọn phương thức thanh toán',
            style: TextStyle(
              fontSize: 16.0,
              color: AppColor.blackColor,
            ),
          ),
        ),
        body: Column(
          children: [
            RadioListTile(
              value: 0,
              groupValue: payment,
              title: Text('codPaymentMethod'.tr()),
              secondary: const Icon(Icons.local_atm_outlined),
              onChanged: (value) {
                context
                    .read<ChangePaymentBloc>()
                    .add(OnChoosePaymentMethodEvent(value ?? 0));
              },
            ),
            RadioListTile(
              value: 1,
              groupValue: payment,
              title: Text('momoPaymentMethod'.tr()),
              secondary: Image.asset(
                ImageConstants.iconMOMO,
                width: 24.0,
                height: 24.0,
              ),
              onChanged: (value) {
                context
                    .read<ChangePaymentBloc>()
                    .add(OnChoosePaymentMethodEvent(value ?? 1));
              },
            ),
          ],
        ),
      );
    });
  }
}
