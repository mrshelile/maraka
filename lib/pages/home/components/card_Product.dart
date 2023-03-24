import 'dart:math';
import 'dart:ui';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:maraka/logic/store.dart';
import 'package:maraka/models/product.dart';
import 'package:maraka/pages/home/details/details_screen.dart';
import 'package:maraka/screens/componets/productPreview.dart';
import 'package:maraka/size_config.dart';
import 'package:maraka/themes/color.dart';

// import 'Product.dart';

class ListProductCard extends StatelessWidget {
  const ListProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    final store = Get.find<StoreController>();
    return LayoutBuilder(
      builder: (context, constraints) {
        var width = MediaQuery.of(context).copyWith().size.width;
        var height = MediaQuery.of(context).copyWith().size.height;
        debugPrint(constraints.toString());
        return GetBuilder(
            init: store,
            builder: (controller) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductPreview(
                                product: product,
                              )));
                },
                child: Padding(
                  padding: EdgeInsets.only(
                      left: width * 0.1,
                      right: width * 0.09,
                      top: height * 0.03),
                  child: AspectRatio(
                    aspectRatio: 1.93,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 226, 226, 226),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Stack(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AspectRatio(
                                aspectRatio: 6 / 1.5,
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          product.images![0].url,
                                        )),
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15)),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 1,
                              ),
                              AspectRatio(
                                aspectRatio: 13 / 3.3,
                                child: Container(
                                  // color: Colors.redAccent,
                                  padding: EdgeInsets.only(left: 5),
                                  child: Wrap(
                                    direction: Axis.vertical,
                                    alignment: WrapAlignment.start,
                                    spacing: 6.0,
                                    runAlignment: WrapAlignment.start,
                                    // runSpacing: 8.0,
                                    // crossAxisAlignment: WrapCrossAlignment.center,
                                    // textDirection: TextDirection.rtl,
                                    // verticalDirection: VerticalDirection.up,
                                    children: <Widget>[
                                      SizedBox(
                                        width: width * 0.6,
                                        child: Text(
                                          store.selectedCategory
                                                      .toLowerCase() ==
                                                  "cars"
                                              ? "${product.car['make']} ${product.car['model']} ${product.car['year']}"
                                              : "${product.title}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: width * 0.043,
                                              color: MyColors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.6,
                                        child: Text(
                                          overflow: TextOverflow.ellipsis,
                                          store.selectedCategory
                                                      .toLowerCase() ==
                                                  "cars"
                                              ? "${product.car['kilos']}Km  | ${product.car['transmission']}  | ${product.car['fuel']}"
                                              : "${product.description}",
                                          maxLines: 1,
                                          style:
                                              TextStyle(fontSize: width * 0.04),
                                        ),
                                      ),
                                      Text(
                                        "M${product.price.toString()}",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: MyColors.blue2,
                                            fontSize: width * 0.04),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                           badges.Badge(
                            badgeStyle: const badges.BadgeStyle(badgeColor: MyColors.blue3),
                            badgeContent: Text(product.views>=99? product.views.toString():"99+",style: TextStyle(fontSize: 12,color: Colors.white),),
                            child: const Icon(Icons.visibility_rounded,size: 35,color: Colors.black54,),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            });
      },
    );
  }
}
