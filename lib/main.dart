import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_food_store/app_observer.dart';
import 'package:selling_food_store/dependency_injection.dart';

import 'app.dart';

Future<void> main() async {
  Bloc.observer = AppObserver();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  await DependencyInjection.setUp();
  runApp(const MyApp());
}
