import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_food_store/modules/home/bloc/home_bloc.dart';
import 'package:selling_food_store/modules/home/bloc/home_event.dart';
import 'package:selling_food_store/modules/home/view/home_view.dart';
import 'package:selling_food_store/shared/widgets/general/cart/cart_bloc.dart';

import '../cart/bloc/cart_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
          create: (context) => HomeBloc()..add(OnLoadingProductList())),
      BlocProvider(create: (context) => CartButtonBloc()),
      BlocProvider(create: (context) => CartBloc()),
    ], child: const HomeView());
  }
}
