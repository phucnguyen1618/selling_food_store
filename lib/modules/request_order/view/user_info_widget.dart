import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_food_store/modules/request_order/bloc/request_order_bloc.dart';
import 'package:selling_food_store/modules/request_order/bloc/request_order_state.dart';

import '../../../shared/utils/app_color.dart';
import '../../../shared/utils/strings.dart';

class UserInfoWidget extends StatefulWidget {
  const UserInfoWidget({super.key});

  @override
  State<UserInfoWidget> createState() => _UserInfoWidgetState();
}

class _UserInfoWidgetState extends State<UserInfoWidget> {
  String name = '';
  String address = '';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestOrderBloc, RequestOrderState>(
        builder: (context, state) {
      if (state is DisplayUserInfoState) {
        name = state.name;
        address = state.address;
      }
      return ListTile(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        minLeadingWidth: 12.0,
        horizontalTitleGap: 12.0,
        leading: const Icon(Icons.location_on_outlined),
        title: Text(
          '$name - ${Strings.phone}',
          style: const TextStyle(
            fontSize: 16.0,
            color: AppColor.blackColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          address,
          style: const TextStyle(
            fontSize: 14.0,
            color: Color.fromARGB(255, 148, 144, 144),
          ),
        ),
        trailing: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_forward_ios,
              size: 16.0,
            )),
      );
    });
  }
}
