import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_food_store/models/product_detail.dart';
import 'package:selling_food_store/modules/detail/bloc/product_detail_bloc.dart';
import 'package:selling_food_store/modules/detail/view/introduct_text_view.dart';
import 'package:selling_food_store/shared/widgets/items/item_use.dart';

import '../../../shared/utils/app_color.dart';
import '../../../shared/utils/strings.dart';

class ProductDetailTabView extends StatelessWidget {
  final ProductDetail detail;

  const ProductDetailTabView({
    super.key,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
        buildWhen: (previous, current) =>
            previous.runtimeType != current.runtimeType,
        builder: (context, state) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Text(
                    Strings.introduce,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: AppColor.blackColor,
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                IntroduceTextView(content: detail.introduce ?? ''),
                const SizedBox(height: 12.0),
                detail.ingredients != null
                    ? Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              Strings.ingredient,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: AppColor.blackColor,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: detail.ingredients!
                                  .map(
                                    (e) => Text(
                                      e,
                                      maxLines: 3,
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
                const SizedBox(height: 12.0),
                const Padding(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Text(
                    Strings.uses,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: AppColor.blackColor,
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                ListView.builder(
                    itemCount: detail.uses.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) =>
                        ItemUse(use: detail.uses[index])),
                const SizedBox(height: 12.0),
                const Padding(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Text(
                    Strings.howToUse,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: AppColor.blackColor,
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: detail.howToUse
                          .map(
                            (e) => Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, right: 12.0),
                              child: Text(
                                e,
                                maxLines: 20,
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    )),
                const SizedBox(height: 24.0),
              ],
            ));
  }
}
