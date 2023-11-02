import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:selling_food_store/shared/services/local_models/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

final getIt = GetIt.instance;

class DependencyInjection {
  static Future<void> setUp() async {
    await Hive.initFlutter();
    Hive.registerAdapter(CartModelAdapter());
    await Hive.openBox<CartModel>('cartList');
    await Hive.openBox<String>('keywords');
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    final prefs = await SharedPreferences.getInstance();
    getIt.registerSingleton<SharedPreferences>(prefs);
  }
}
