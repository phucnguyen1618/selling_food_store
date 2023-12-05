import 'package:flutter/widgets.dart';
import 'package:selling_food_store/shared/widgets/items/item_suggestion_product.dart';

class SuggestionProductList extends StatelessWidget {
  const SuggestionProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column();
    // GridView.builder(
    //   itemCount: 20,
    //   gridDelegate:
    //       const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    //   itemBuilder: (context, index) => const ItemSuggestionProduct(),
    // );
  }
}
