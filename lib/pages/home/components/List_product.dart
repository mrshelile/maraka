import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:maraka/pages/home/components/card_Product.dart';
import 'package:maraka/pages/home/components/section_title.dart';

import '../../../logic/products_logic.dart';
import '../../../logic/store.dart';
import '../../../logic/user_logic.dart';
import '../../../models/product.dart';
import '../../../size_config.dart';
import '../../../themes/color.dart';

class ProductList extends StatefulWidget {
  User owner;
  ProductList({Key? key, required this.owner}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final store = Get.find<StoreController>();
  Future<List<Product>> makeProductList() async {
    var logic = ProductLogic();

    List<Product> products = await logic.getProducts(
        widget.owner, store.selectedCategory.toLowerCase());
    store.setProducts(products);
    return products;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20, context)),
          child: GetBuilder(
              init: store,
              builder: (_) {
                return SectionTitle(title: store.selectedCategory);
              }),
        ),
        SizedBox(height: getProportionateScreenWidth(20, context)),
        FutureBuilder(
            future: makeProductList(),
            builder: ((context, snapshot) {
              return GetBuilder(
                  init: store,
                  builder: (_) {
                    return Column(
                      children: [
                        ...List.generate(
                          store.products.length,
                          (index) {
                            return store.search.isEmpty
                                ? ListProductCard(
                                    product: store.products[index])
                                : store.products[index].title!
                                        .toLowerCase()
                                        .toString()
                                        .contains(store.search
                                            .toLowerCase()
                                            .toString())
                                    ? ListProductCard(
                                        product: store.products[index])
                                    : Container();
                            // return const SizedBox
                            //     .shrink(); // here by default width and height is 0
                          },
                        ),
                        SizedBox(
                            width: getProportionateScreenWidth(20, context)),
                      ],
                    );
                  });
            })),
      ],
    );
  }
}
