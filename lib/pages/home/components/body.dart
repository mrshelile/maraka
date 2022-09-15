import 'package:flutter/material.dart';

import '../../../size_config.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'popular_product.dart';
import 'special_offers.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20,context)),
             HomeHeader(),
            SizedBox(height: getProportionateScreenWidth(10,context)),
            DiscountBanner(),
            Categories(),
            SpecialOffers(),
            SizedBox(height: getProportionateScreenWidth(30,context)),
            PopularProducts(),
            SizedBox(height: getProportionateScreenWidth(30,context)),
          ],
        ),
      ),
    );
  }
}
