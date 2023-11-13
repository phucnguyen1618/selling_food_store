import 'dart:convert';
import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:selling_food_store/models/cart.dart';
import 'package:selling_food_store/models/product.dart';
import 'package:selling_food_store/shared/services/local_models/cart_model.dart';

class HiveService {
  static void addCart(Cart cart) {
    Product product = cart.product;
    String productStr = jsonEncode(product.toJson());
    CartModel cartModel = CartModel(
        cart.idCart, productStr, cart.dateTimeOrder, cart.orderQuantity);
    var cartBox = Hive.box<CartModel>('cartList');
    cartBox
        .put(cartModel.idCart, cartModel)
        .then((value) => log('Add Cart Successfully'));
  }

  static List<Cart> getCartList() {
    var cartBox = Hive.box<CartModel>('cartList');
    List<CartModel> cartModelList = cartBox.values.toList();
    return cartModelList
        .map((e) => Cart(e.idCart, Product.fromJson(jsonDecode(e.product)),
            e.orderQuantity, e.dateTimeOrder))
        .toList();
  }

  static void updateQuantityForCart(String idCart, int quantity) {
    var cartBox = Hive.box<CartModel>('cartList');
    CartModel? cartModel = cartBox.get(idCart);
    if (cartModel != null) {
      cartModel.orderQuantity = quantity;
      cartModel.save();
    }
  }

  static void addAllCartList(List<Cart> dataList) {
    var cartBox = Hive.box<CartModel>('cartList');
    cartBox.addAll(dataList.map((e) {
      Product product = e.product;
      String productStr = jsonEncode(product.toJson());
      return CartModel(e.idCart, productStr, e.dateTimeOrder, e.orderQuantity);
    }).toList());
  }

  static void deleteItemCart(List<Cart> dataList) {
    var cartBox = Hive.box<CartModel>('cartList');
    for (Cart cart in dataList) {
      cartBox.delete(cart.idCart);
    }
  }

  static void deleteAllItemCart() {
    List<Cart> dataList = getCartList();
    if (dataList.isNotEmpty) {
      deleteItemCart(dataList);
    }
  }

  static void addKeyword(String input) {
    List<String> keyList = getKeywords();
    var keywordBox = Hive.box<String>('keywords');
    if (keyList.isEmpty) {
      keywordBox.add(input);
    } else {
      for (var key in keyList) {
        if (!key.contains(input)) {
          keywordBox.add(input);
        }
      }
    }
  }

  static List<String> getKeywords() {
    var keywordBox = Hive.box<String>('keywords');
    return keywordBox.values.map((e) => e.toString()).toList();
  }
}
