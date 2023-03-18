import 'package:flutter/material.dart';
import 'package:maraka/logic/user_logic.dart';
import 'package:maraka/pages/home/components/List_product.dart';

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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
          SizedBox(height: getProportionateScreenHeight(10, context),),
            HomeHeader(
              owner: widget.owner,
            ),
            SizedBox(height: getProportionateScreenWidth(10, context)),
            DiscountBanner(),
            SizedBox(height: getProportionateScreenWidth(10, context)),
            Categories(
              owner: widget.owner,
            ),
            SizedBox(height: getProportionateScreenHeight(10, context),),
            ProductList(owner: widget.owner),
            SizedBox(height: getProportionateScreenWidth(10, context)),
          ],
        ),
      ),
    );
  }
}
