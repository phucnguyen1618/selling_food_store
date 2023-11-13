import 'dart:core';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:selling_food_store/modules/home/bloc/home_bloc.dart';
import 'package:selling_food_store/modules/home/bloc/home_event.dart';
import 'package:selling_food_store/modules/home/bloc/home_state.dart';
import 'package:selling_food_store/modules/home/view/bestselling_product_list.dart';
import 'package:selling_food_store/modules/home/view/hotselling_product_list.dart';
import 'package:selling_food_store/modules/home/view/recommend_product_list.dart';
import 'package:selling_food_store/modules/home/view/type_product_list.dart';
import 'package:selling_food_store/shared/services/hive_service.dart';
import 'package:selling_food_store/shared/utils/image_constants.dart';
import 'package:selling_food_store/shared/utils/show_dialog_utils.dart';
import 'package:selling_food_store/shared/widgets/banner/slide_banner.dart';
import 'package:selling_food_store/shared/widgets/general/avatar_profile.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shared/utils/app_color.dart';
import '../../../shared/utils/strings.dart';
import '../../../shared/widgets/banner/banner_ads.dart';
import '../../../shared/widgets/general/search_bar.dart';

import 'package:badges/badges.dart' as badges;

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(builder: (context, state) {
      int numberCart = HiveService.getCartList().length;
      return Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: AppBar(
          backgroundColor: AppColor.whiteColor,
          title: SearchBar(
            onSearch: () {
              showSearch(
                context: context,
                delegate: ProductSearchDelegate(),
              );
            },
          ),
          titleSpacing: 0.0,
          automaticallyImplyLeading: false,
          leading: InkWell(
            onTap: () {
              context.goNamed('profile');
            },
            child: Container(
              margin: const EdgeInsets.all(6.0),
              child: const AvatarProfile(
                avatar: Strings.avatarDemo,
                isEdit: false,
              ),
            ),
          ),
          elevation: 0.0,
          actions: [
            Center(
              child:
                  BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                numberCart = HiveService.getCartList().length;
                return badges.Badge(
                    position: badges.BadgePosition.topEnd(top: 4, end: 4),
                    showBadge: numberCart != 0,
                    badgeContent: Text(
                      numberCart <= 10
                          ? numberCart.toString()
                          : Strings.upTenCart,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 8.0,
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {
                        context.goNamed('cart');
                      },
                      splashColor: AppColor.transparentColor,
                      highlightColor: AppColor.transparentColor,
                      focusColor: AppColor.transparentColor,
                      hoverColor: AppColor.transparentColor,
                      padding: EdgeInsets.zero,
                      icon: const Icon(
                        Icons.shopping_cart_outlined,
                        color: AppColor.blackColor,
                      ),
                    ));
              }),
            ),
            Center(
              child: IconButton(
                onPressed: () {},
                splashColor: AppColor.transparentColor,
                highlightColor: AppColor.transparentColor,
                focusColor: AppColor.transparentColor,
                hoverColor: AppColor.transparentColor,
                icon: const Icon(
                  Icons.notifications_none_outlined,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              SlideBanner(),
              SizedBox(height: 16.0),
              RecommendProductList(),
              SizedBox(height: 24.0),
              TypeProductList(),
              SizedBox(height: 24.0),
              HotSellingProductList(),
              SizedBox(height: 12.0),
              BannerAds(image: ImageConstants.bannerOne),
              SizedBox(height: 12.0),
              BestSellingProductList(),
              SizedBox(height: 12.0),
              BannerAds(image: ImageConstants.bannerTwo),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _openChatBot();
          },
          backgroundColor: AppColor.transparentColor,
          child: Image.asset(ImageConstants.iconChatBot),
        ),
      );
    }, listener: (context, state) {
      if (state is RequestSignInState) {
        ShowDialogUtils.showDialogRequestSignIn(context, () {
          context.read<HomeBloc>().add(OnCloseDialogEvent());
        });
      } else if (state is DialogCloseState) {
        log('Dialog is closed');
      }
    });
  }

  Future<void> _openChatBot() async {
    String uri = '';
    if (Platform.isAndroid) {
      uri = 'fb-messenger://user/${Strings.facebookId}';
    } else if (Platform.isIOS) {
      uri = 'https://m.me/${Strings.facebookId}';
    }
    final Uri url = Uri.parse(uri);
    if (!await launchUrl(url)) {
      EasyLoading.showError('Could not launch $url');
    }
  }
}

class ProductSearchDelegate extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        elevation: 0.0,
        backgroundColor: AppColor.whiteColor,
        iconTheme: IconThemeData(color: AppColor.blackColor),
        actionsIconTheme: IconThemeData(color: AppColor.blackColor),
      ),
      inputDecorationTheme:
          const InputDecorationTheme(border: InputBorder.none),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query.isEmpty) {
              query = '';
            } else {
              context.pop();
            }
          },
          icon: const Icon(Icons.clear)),
      const SizedBox(width: 12.0),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.pop();
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Column(
      children: [],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column(
      children: [],
    );
  }
}
