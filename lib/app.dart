import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:selling_food_store/app_route.dart';

import 'shared/utils/strings.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      title: Strings.appName,
      theme: ThemeData(primarySwatch: Colors.blue),
      builder: EasyLoading.init(),
    );
  }
}
