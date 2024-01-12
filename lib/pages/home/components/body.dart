import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
    return SafeArea(
      child: Wrap(
        alignment: WrapAlignment.start,
        runAlignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.start,
        runSpacing: getProportionateScreenHeight(16, context),
        children: [
          // HomeHeader(
          //   owner: widget.owner,
          // ),
          Container(
            height: getProportionateScreenHeight(0, context),
          ),
          const DiscountBanner(),
          SizedBox(height: getProportionateScreenWidth(10, context)),
          GetBuilder(
            init: store,
            builder: (controller) {
              return Stack(
                children: [
                  Wrap(
                    children: [
                      Categories(
                        owner: widget.owner,
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(10, context),
                      ),
                      // pages[current],
                      ProductList(
                        owner: widget.owner,
                      ),
                    ],
                  ),
                  if (store.currentPageProduct > 1)
                    Positioned(
                      bottom: getProportionateScreenHeight(6, context),
                      child: MaterialButton(
                        color: MyColors.blue3,
                        shape: const CircleBorder(),
                        onPressed: () {
                          store.currentPageProduct--;
                          store.pageDown();
                          store.pageFilter();
                          store.update();
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  Positioned(
                    right: getProportionateScreenWidth(13, context),
                    bottom: getProportionateScreenHeight(6, context),
                    child: MaterialButton(
                      color: MyColors.blue3,
                      shape: const CircleBorder(),
                      onPressed: () {
                        ++store.currentPageProduct;
                        store.pageUp();
                        store.pageFilter();
                        store.update();
                      },
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              );
            },
          )

          // SizedBox(height: getProportionateScreenWidth(20, context)),
        ],
      ),
    );
  }
}
