import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:selling_food_store/modules/cart/bloc/cart_bloc.dart';
import 'package:selling_food_store/modules/cart/bloc/cart_event.dart';
import 'package:selling_food_store/modules/cart/bloc/cart_state.dart';
import 'package:selling_food_store/modules/cart/bloc/item_cart_bloc.dart';
import 'package:selling_food_store/shared/services/hive_service.dart';
import 'package:selling_food_store/shared/widgets/general/empty_data_widget.dart';
import 'package:selling_food_store/shared/widgets/general/loading_data_widget.dart';
import 'package:selling_food_store/shared/widgets/general/search_bar.dart';
import 'package:selling_food_store/shared/widgets/items/item_result_search.dart';

import '../../../models/cart.dart';
import '../../../shared/utils/app_color.dart';
import '../../../shared/utils/app_utils.dart';
import '../../../shared/utils/strings.dart';
import '../../../shared/widgets/items/item_cart.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  List<Cart> _cartItems = [];
  double _totalPrice = 0;
  bool isNotSignIn = false;
  bool isDeleteItem = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(builder: (context, state) {
      if (state is DisplayCartListState) {
        _cartItems = state.cartList;
        double totalPrice = AppUtils.calculateTotalPrice(_cartItems);
        context.read<ItemCartBloc>().add(OnDisplayTotalPriceEvent(totalPrice));
      }
      return Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: AppBar(
          backgroundColor: AppColor.whiteColor,
          elevation: 0.0,
          centerTitle: true,
          titleSpacing: 0.0,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: AppColor.blackColor,
              )),
          title: SearchBar(
            hintText: 'Tìm kiếm giỏ hàng...',
            backgroundColor: AppColor.shimer200Color,
            onSearch: () {
              showSearch(
                context: context,
                delegate: CartDelegate(),
              );
            },
          ),
          actions: [
            isDeleteItem
                ? const SizedBox()
                : IconButton(
                    onPressed: () {
                      setState(() {
                        isDeleteItem = !isDeleteItem;
                        context
                            .read<ItemCartBloc>()
                            .add(OnDeleteItemEvent(isDeleteItem, _cartItems));
                      });
                    },
                    splashColor: AppColor.transparentColor,
                    highlightColor: AppColor.transparentColor,
                    focusColor: AppColor.transparentColor,
                    hoverColor: AppColor.transparentColor,
                    icon: const Icon(Icons.delete),
                    color: AppColor.hintGreyColor,
                  ),
            const SizedBox(width: 8.0),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            state is LoadingCartListState
                ? const LoadingDataWidget(
                    loadingType: LoadingDataType.loadingCartList)
                : state is DisplayNotSignInState
                    ? EmptyDataWidget(
                        emptyType: EmptyType.profileEmpty,
                        onClick: () {
                          context.pushNamed('signIn');
                        })
                    : _cartItems.isNotEmpty
                        ? Expanded(
                            child: Column(
                              children: [
                                Container(
                                    height: 12.0, color: AppColor.dividerColor),
                                Expanded(
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    itemCount: _cartItems.length,
                                    itemBuilder: (context, index) =>
                                        ItemCart(cart: _cartItems[index]),
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            Container(
                                                height: 12.0,
                                                color: AppColor.dividerColor),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const EmptyDataWidget(emptyType: EmptyType.cartEmpty)
          ],
        ),
        persistentFooterButtons: _cartItems.isNotEmpty
            ? [isDeleteItem ? _buildBottomDelete() : _buildBottomPanel()]
            : null,
      );
    });
  }

  Widget _buildBottomPanel() {
    return BlocBuilder<ItemCartBloc, CartState>(builder: (context, state) {
      if (state is DisplayTotalPriceState) {
        _totalPrice = state.value;
      }
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    Strings.titleTotalPrice,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    '${AppUtils.formatPrice(_totalPrice)} ${Strings.unitPrice}',
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            MaterialButton(
              onPressed: () {
                context.goNamed('requestOrder', extra: _cartItems);
              },
              color: Colors.green,
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Text(
                Strings.payment,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  Widget _buildBottomDelete() {
    return Row(
      children: [
        Expanded(
          child: MaterialButton(
            onPressed: () {
              setState(() {
                isDeleteItem = false;
                context
                    .read<ItemCartBloc>()
                    .add(OnDeleteItemEvent(isDeleteItem, []));
              });
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0)),
            color: AppColor.shimer200Color,
            elevation: 0.0,
            child: const Text(
              'Huỷ bỏ',
              style: TextStyle(
                color: AppColor.blackColor,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: MaterialButton(
            onPressed: () {},
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0)),
            elevation: 0.0,
            color: Colors.redAccent,
            child: const Text(
              'Xác nhận',
              style: TextStyle(
                color: AppColor.whiteColor,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class CartDelegate extends SearchDelegate<Cart> {
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
        icon: const Icon(
          Icons.arrow_back,
          color: AppColor.blackColor,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    HiveService.addKeyword(query);
    List<Cart> resultList = HiveService.getCartList()
        .where((item) =>
            item.product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
        shrinkWrap: true,
        itemCount: resultList.length,
        itemBuilder: (context, index) =>
            ItemResultSearch(product: resultList[index].product));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> keywords = HiveService.getKeywords();
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: AppColor.whiteColor,
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: keywords.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'TÌM KIẾM GẦN ĐÂY',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Expanded(
                  child: Wrap(
                    children: List.generate(
                      keywords.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: ChoiceChip(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8.0),
                          disabledColor: AppColor.shimer200Color,
                          label: Text(
                            keywords[index],
                            style: const TextStyle(
                              fontSize: 12.0,
                              color: AppColor.blackColor,
                            ),
                          ),
                          selected: false,
                        ),
                      ),
                    ).toList(),
                  ),
                ),
              ],
            )
          : const SizedBox(),
    );
  }
}
