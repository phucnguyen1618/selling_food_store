import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:selling_food_store/modules/home/bloc/home_bloc.dart';
import 'package:selling_food_store/modules/home/bloc/home_state.dart';

import '../../../models/product.dart';
import '../../../shared/widgets/items/item_recommend_product.dart';

class TypeProductList extends StatefulWidget {
  const TypeProductList({super.key});

  @override
  State<TypeProductList> createState() => _TypeProductListState();
}

class _TypeProductListState extends State<TypeProductList>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    // final dataList = BlocProvider.of<HomeBloc>(context).state.typeProductList;
    // if (dataList.isNotEmpty) {
    //   _tabController = TabController(length: dataList.length, vsync: this);
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column();
    // return BlocBuilder<HomeBloc, HomeState>(
    //     builder: (context, state) => state.typeProductList.isEmpty
    //         ? const Padding(
    //             padding: EdgeInsets.only(bottom: 16.0),
    //             child: Center(child: CircularProgressIndicator()),
    //           )
    //         : DefaultTabController(
    //             length: state.typeProductList.length,
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               mainAxisSize: MainAxisSize.min,
    //               children: [
    //                 SizedBox(
    //                   width: MediaQuery.of(context).size.width,
    //                   child: TabBar(
    //                     controller: _tabController,
    //                     isScrollable: true,
    //                     indicatorColor: Colors.teal,
    //                     indicatorSize: TabBarIndicatorSize.tab,
    //                     labelColor: Colors.teal,
    //                     unselectedLabelColor: Colors.black,
    //                     tabs: List.generate(
    //                         state.typeProductList.length,
    //                         (index) => Tab(
    //                             text: state.typeProductList[index].name
    //                                 .toUpperCase())),
    //                     onTap: (index) {},
    //                   ),
    //                 ),
    //                 const SizedBox(height: 8.0),
    //                 SingleChildScrollView(
    //                   padding: const EdgeInsets.symmetric(horizontal: 12.0),
    //                   scrollDirection: Axis.horizontal,
    //                   child: Row(
    //                     crossAxisAlignment: CrossAxisAlignment.center,
    //                     children: List.generate(
    //                         state.recommendProductList.length,
    //                         (index) => ItemRecommendProduct(
    //                               product: state.recommendProductList[index],
    //                               onBuy: () {},
    //                               onClick: () {
    //                                 context.goNamed('productDetail',
    //                                     extra:
    //                                         state.recommendProductList[index]);
    //                               },
    //                               onAddCart: (Product product) {
    //                                 BlocProvider.of<HomeBloc>(context)
    //                                     .onAddToCartButtonClick(
    //                                         context, product);
    //                               },
    //                             )),
    //                   ),
    //                 ),
    //               ],
    //             )));
  }
}
