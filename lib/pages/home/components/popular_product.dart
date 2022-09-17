import 'package:flutter/material.dart';
import 'package:maraka/logic/products_logic.dart';

import 'package:maraka/logic/store.dart';
import 'package:maraka/pages/home/components/product_card.dart';

import 'Product.dart';
import 'package:get/get.dart';
import '../../../size_config.dart';
import 'section_title.dart';

class PopularProducts extends StatefulWidget {
  @override
  State<PopularProducts> createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  final store = Get.find<StoreController>();

  // Future<List<Product>> makeProductList() async {
  @override
  void initState() {
    store.setProducts();
    super.initState();
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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                store.products.length,
                (index) {
                  return ProductCard(product: store.products[index]);

                  // return const SizedBox
                  //     .shrink(); // here by default width and height is 0
                },
              ),
              SizedBox(width: getProportionateScreenWidth(20, context)),
            ],
          ),
        )
      ],
    );
  }
}
