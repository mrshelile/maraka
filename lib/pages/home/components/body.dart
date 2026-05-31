import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maraka/logic/store.dart';

import '../../../size_config.dart';
import 'categories.dart';
import 'products_grid.dart';
import 'top_banner.dart';

// ignore: must_be_immutable
class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final StoreController store = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Wrap(
        runSpacing: getProportionateScreenHeight(8, context),
        children: [
          // const HomeHeader(),
          SizedBox(height: getProportionateScreenWidth(8, context)),
          const DiscountBanner(),
          SizedBox(height: getProportionateScreenWidth(8, context)),
          Categories(),
          const ProductList(),
        ],
      ),
    );
  }
}
    // return SafeArea(
    //   child: Wrap(
    //     alignment: WrapAlignment.start,
    //     runAlignment: WrapAlignment.start,
    //     crossAxisAlignment: WrapCrossAlignment.start,
    //     runSpacing: getProportionateScreenHeight(13, context),
    //     children: [
    //       const HomeHeader(
    //           // owner: widget.owner,
    //           ),
    //       SizedBox(height: getProportionateScreenWidth(10, context)),
    //       const DiscountBanner(),
    //       SizedBox(height: getProportionateScreenWidth(10, context)),
    //       GetBuilder(
    //         init: store,
    //         builder: (controller) {
    //           return Stack(
    //             children: [
    //               Column(
    //                 children: [
    //                   Categories(
    //                       // owner: widget.owner,
    //                       ),
    //                   SizedBox(
    //                     height: getProportionateScreenHeight(10, context),
    //                   ),
    //                   // pages[current],
    //                   const ProductList(
    //                       // owner: widget.owner,
    //                       ),
    //                 ],
    //               ),
    //               if (store.currentPageProduct > 1)
    //                 Positioned(
    //                   bottom: getProportionateScreenHeight(15, context),
    //                   child: MaterialButton(
    //                     color: MyColors.blue3,
    //                     shape: const CircleBorder(),
    //                     onPressed: () {
    //                       store.currentPageProduct--;
    //                       store.pageDown();
    //                       store.pageFilter();
    //                       store.update();
    //                     },
    //                     child: const Icon(
    //                       Icons.arrow_back,
    //                       color: Colors.white,
    //                     ),
    //                   ),
    //                 ),
    //               Positioned(
    //                 right: getProportionateScreenWidth(4, context),
    //                 bottom: getProportionateScreenHeight(15, context),
    //                 child: MaterialButton(
    //                   color: MyColors.blue3,
    //                   shape: const CircleBorder(),
    //                   onPressed: () {
    //                     ++store.currentPageProduct;
    //                     store.pageUp();
    //                     store.pageFilter();
    //                     store.update();
    //                   },
    //                   child: const Icon(
    //                     Icons.arrow_forward,
    //                     color: Colors.white,
    //                   ),
    //                 ),
    //               )
    //             ],
    //           );
    //         },
    //       )

    //       // SizedBox(height: getProportionateScreenWidth(20, context)),
    //     ],
    //   ),
    // );