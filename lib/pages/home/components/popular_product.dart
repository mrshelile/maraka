import 'package:flutter/material.dart';
import 'package:maraka/logic/products_logic.dart';

import 'package:maraka/logic/store.dart';
import 'package:maraka/models/product.dart';
import 'package:maraka/pages/home/components/product_card.dart';

import 'package:get/get.dart';
import '../../../size_config.dart';
import 'section_title.dart';

class PopularProducts extends StatefulWidget {
  const PopularProducts({super.key});

  @override
  State<PopularProducts> createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  StoreController store = Get.find();

  Future<List<Product>> makeProductList() async {
    var logic = ProductLogic();

    List<Product> products =
        await logic.getProducts(store.selectedCategory.toLowerCase());
    store.setProducts(products);
    return products;
  }

  @override
  void initState() {
    // store.setProducts();
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
            child: FutureBuilder(
                future: makeProductList(),
                builder: ((context, snapshot) {
                  return GetBuilder(
                      init: store,
                      builder: (_) {
                        return Row(
                          children: [
                            ...List.generate(
                              store.productsFromdb.length,
                              (index) {
                                return store.search.isEmpty
                                    ? ProductCard(
                                        product: store.productsFromdb[index])
                                    : store.productsFromdb[index].title!
                                            .toLowerCase()
                                            .toString()
                                            .contains(store.search
                                                .toLowerCase()
                                                .toString())
                                        ? ProductCard(
                                            product:
                                                store.productsFromdb[index])
                                        : Container();
                                // return const SizedBox
                                //     .shrink(); // here by default width and height is 0
                              },
                            ),
                            SizedBox(
                                width:
                                    getProportionateScreenWidth(20, context)),
                          ],
                        );
                      });
                }))),
      ],
    );
  }
}
