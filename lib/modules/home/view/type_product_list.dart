import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:selling_food_store/models/type_product.dart';
import 'package:selling_food_store/modules/home/bloc/home_bloc.dart';
import 'package:selling_food_store/modules/home/bloc/home_event.dart';
import 'package:selling_food_store/modules/home/bloc/home_state.dart';
import 'package:selling_food_store/shared/widgets/general/empty_data_widget.dart';
import 'package:selling_food_store/shared/widgets/general/loading_data_widget.dart';

import '../../../models/product.dart';
import '../../../shared/widgets/items/item_recommend_product.dart';

class TypeProductList extends StatefulWidget {
  const TypeProductList({super.key});

  @override
  State<TypeProductList> createState() => _TypeProductListState();
}

class _TypeProductListState extends State<TypeProductList>
    with TickerProviderStateMixin {
  TabController? _tabController;
  List<TypeProduct> typeProductList = [];
  List<Product> productListWithType = [];
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is DisplayProductListState) {
          isLoading = false;
          typeProductList = state.typeProducts;
          productListWithType = state.productList;
          _tabController =
              TabController(length: state.typeProducts.length, vsync: this);
        } else if (state is ReloadProductListState) {
          productListWithType = state.products;
        }
        return isLoading
            ? const LoadingDataWidget(
                loadingType: LoadingDataType.loadingRecommendProductList)
            : typeProductList.isEmpty
                ? const SizedBox()
                : DefaultTabController(
                    length: typeProductList.length,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: TabBar(
                            controller: _tabController,
                            isScrollable: true,
                            indicatorColor: Colors.teal,
                            indicatorSize: TabBarIndicatorSize.tab,
                            labelColor: Colors.teal,
                            unselectedLabelColor: Colors.black,
                            tabs: List.generate(
                                typeProductList.length,
                                (index) => Tab(
                                    text: typeProductList[index]
                                        .name
                                        .toUpperCase())),
                            onTap: (index) {
                              context.read<HomeBloc>().add(
                                  OnTabItemClickedEvent(
                                      typeProductList[index].name));
                            },
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        productListWithType.isNotEmpty
                            ? SingleChildScrollView(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: List.generate(
                                      productListWithType.length,
                                      (index) => ItemRecommendProduct(
                                            product: productListWithType[index],
                                            onBuy: () {
                                              context.read<HomeBloc>().add(
                                                  OnBuyNowEvent(
                                                      productListWithType[
                                                          index]));
                                            },
                                            onClick: () {
                                              context.goNamed('productDetail',
                                                  extra: productListWithType[
                                                      index]);
                                            },
                                            onAddCart: (Product product) {
                                              context.read<HomeBloc>().add(
                                                  OnAddProductToCartEvent(
                                                      product));
                                            },
                                          )),
                                ))
                            : const EmptyDataWidget(
                                emptyType: EmptyType.productListEmpty),
                      ],
                    ));
      },
    );
  }
}
