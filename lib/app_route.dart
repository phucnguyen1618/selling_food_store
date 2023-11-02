import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:selling_food_store/models/cart.dart';
import 'package:selling_food_store/models/user_info.dart';
import 'package:selling_food_store/modules/cart/cart_page.dart';
import 'package:selling_food_store/modules/confirm_order.dart/confirm_order_page.dart';
import 'package:selling_food_store/modules/detail/product_detail_page.dart';
import 'package:selling_food_store/modules/edit_profile/edit_profile_page.dart';
import 'package:selling_food_store/modules/forgotPassword/forgot_password_page.dart';
import 'package:selling_food_store/modules/home/home_page.dart';
import 'package:selling_food_store/modules/order_list/order_list_page.dart';
import 'package:selling_food_store/modules/profile/profile_page.dart';
import 'package:selling_food_store/modules/request_order/request_order_page.dart';
import 'package:selling_food_store/modules/signIn/sign_in_page.dart';
import 'package:selling_food_store/modules/splash/splash_page.dart';
import 'package:selling_food_store/modules/signUp/signUp_page.dart';

import 'models/product.dart';

final GoRouter appRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashPage();
      },
      routes: <RouteBase>[
        GoRoute(
            path: 'home',
            builder: (BuildContext context, GoRouterState state) {
              return const HomePage();
            },
            routes: [
              GoRoute(
                path: 'home/productDetail',
                name: 'productDetail',
                builder: (BuildContext context, GoRouterState state) {
                  final dataValue = state.extra as Product;
                  return ProductDetailPage(product: dataValue);
                },
              ),
              GoRoute(
                  path: 'home/signIn',
                  name: 'signIn',
                  builder: (BuildContext context, GoRouterState state) {
                    return const SignInPage();
                  },
                  routes: [
                    GoRoute(
                      path: 'signIn/signUp',
                      name: 'signUp',
                      builder: (BuildContext context, GoRouterState state) {
                        return const SignUpPage();
                      },
                    ),
                    GoRoute(
                      path: 'signIn/forgotPassword',
                      name: 'forgotPassword',
                      builder: (BuildContext context, GoRouterState state) {
                        return const ForgotPasswordPage();
                      },
                    ),
                  ]),
              GoRoute(
                path: 'home/cart',
                name: 'cart',
                builder: (BuildContext context, GoRouterState state) {
                  return const CartPage();
                },
              ),
              GoRoute(
                  path: 'home/profile',
                  name: 'profile',
                  builder: (BuildContext context, GoRouterState state) {
                    return const ProfilePage();
                  },
                  routes: [
                    GoRoute(
                      path: 'cart',
                      name: 'yourCart',
                      builder: (BuildContext context, GoRouterState state) {
                        return const CartPage();
                      },
                    ),
                    GoRoute(
                      path: 'profle/editProfile',
                      name: 'editProfile',
                      builder: (BuildContext context, GoRouterState state) {
                        final dataValue = state.extra as UserInfo;
                        return EditProfilePage(userInfo: dataValue);
                      },
                    ),
                    GoRoute(
                      path: 'profle/orderList',
                      name: 'orderList',
                      builder: (BuildContext context, GoRouterState state) {
                        return const OrderListPage();
                      },
                    ),
                  ]),
              GoRoute(
                  path: 'home/requestOrder',
                  name: 'requestOrder',
                  builder: (BuildContext context, GoRouterState state) {
                    final dataValue = state.extra as List<Cart>;
                    return RequestOrderPage(carts: dataValue);
                  }),
              GoRoute(
                  path: 'home/confirmOrder',
                  name: 'confirmOrder',
                  builder: (BuildContext context, GoRouterState state) {
                    return const ConfirmOrderPage();
                  }),
            ]),
      ],
    ),
  ],
);
