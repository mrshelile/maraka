import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:maraka/logic/constants.dart';
import 'package:maraka/pages/home/components/List_productPage.dart';
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

  List<Product> products;
  ProductList(
      {Key? key,
      required this.owner,
      required this.products})
      : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final store = Get.find<StoreController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(382, context),
      child: ListView(
        children: [
          Padding(
            padding:
                EdgeInsets.only(left: getProportionateScreenWidth(38, context)),
            child: GetBuilder(
                init: store,
                builder: (_) {
                  return SectionTitle(
                      title: store.selectedCategory.toUpperCase());
                }),
          ),
          // SizedBox(height: getProportionateScreenWidth(20, context)),
          GetBuilder(
              init: store,
              builder: (_) {
                return Column(
                  children: [
                    ...List.generate(
                      pageSize <= widget.products.length
                          ? pageSize
                          : widget.products.length,
                      (index) {
                        return store.search.isEmpty
                            ? ListProductCard(product: widget.products[index])
                            : store.selectedCategory.toLowerCase() != "cars"
                                ? widget.products[index].title!
                                        .toLowerCase()
                                        .toString()
                                        .contains(store.search
                                            .toLowerCase()
                                            .toString())
                                    ? ListProductCard(
                                        product: widget.products[index])
                                    : Container()
                                : widget.products[index].car['model']
                                            .toString()
                                            .toLowerCase()
                                            .contains(
                                                store.search.toLowerCase()) ||
                                        widget.products[index].car['make']
                                            .toString()
                                            .toLowerCase()
                                            .contains(
                                                store.search.toLowerCase())
                                    ? ListProductCard(
                                        product: widget.products[index])
                                    : Container();
                      },
                    ),
                    // SizedBox(
                    //     width: getProportionateScreenWidth(20, context)),
                  ],
                );
              })
        ],
      ),
    );
  }
}
