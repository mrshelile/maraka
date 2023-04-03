import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maraka/logic/constants.dart';
import 'package:maraka/logic/products_logic.dart';
import 'package:maraka/logic/store.dart';
import 'package:maraka/logic/user_logic.dart';
import 'package:maraka/models/product.dart';
import 'package:maraka/pages/home/components/List_product.dart';
import 'package:maraka/themes/color.dart';

import '../../../size_config.dart';
import 'categories.dart';
import 'top_banner.dart';
import 'home_header.dart';
import 'popular_product.dart';
import 'FeacturedAds.dart';

class Body extends StatefulWidget {
  User owner;
  Body({Key? key, required this.owner}) : super(key: key);
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final store = Get.find<StoreController>();

  @override
  Widget build(BuildContext context) {
    Future<List<Product>> makeProductList() async {
      var logic = ProductLogic();

      List<Product> products =
          await logic.getProducts(store.selectedCategory.toLowerCase());
      store.setProducts(products);

      // last = store.products.length % pageSize == 0
      //     ? store.products.length ~/ pageSize
      //     : store.products.length ~/ pageSize + 1;
      return products;
    }

    return SafeArea(
      child: Stack(
        children: [
          Wrap(
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            runSpacing: getProportionateScreenHeight(13, context),
            children: [
              SizedBox(
                height: getProportionateScreenHeight(10, context),
              ),
              HomeHeader(
                owner: widget.owner,
              ),
              SizedBox(height: getProportionateScreenWidth(10, context)),
              DiscountBanner(),
              SizedBox(height: getProportionateScreenWidth(10, context)),
              Categories(
                owner: widget.owner,
              ),
              SizedBox(
                height: getProportionateScreenHeight(10, context),
              ),
              // pages[current],
              FutureBuilder(
                future: makeProductList(),
                builder: (context, snapshot) {
                  return GetBuilder(
                    init: store,
                    builder: (_) {
                      return ProductList(
                        owner: widget.owner,
                        products: store.products,
                      );
                    },
                  );
                },
              )

              // SizedBox(height: getProportionateScreenWidth(10, context)),
            ],
          ),
          if (store.currentPageProduct > 0)
            Positioned(
              bottom: getProportionateScreenHeight(6, context),
              child: MaterialButton(
                color: MyColors.blue3,
                shape: const CircleBorder(),
                onPressed: () {
                  setState(() {
                    if (store.currentPageProduct > 0) {
                      --store.currentPageProduct;
                      store.update();
                    }
                  });
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
          if (store.currentPageProduct < store.lastProductPage)
            Positioned(
              right: getProportionateScreenWidth(13, context),
              bottom: getProportionateScreenHeight(6, context),
              child: MaterialButton(
                color: MyColors.blue3,
                shape: const CircleBorder(),
                onPressed: () {
                  setState(() {
                    if (store.currentPageProduct < store.lastProductPage - 1)
                      store.currentPageProduct = store.currentPageProduct + 1;
                  });
                },
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
