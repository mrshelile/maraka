import 'package:flutter/material.dart';

import '../../../size_config.dart';
import 'categories.dart';
import 'home_hero.dart';
import 'products_grid.dart';

class Body extends StatelessWidget {
  const Body({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Wrap(
        runSpacing: getProportionateScreenHeight(8, context),
        children: [
          // const HomeHeader(),
          const HomeHero(),
          SizedBox(height: getProportionateScreenHeight(40, context)),
          Categories(),
          const ProductList(),
        ],
      ),
    );
  }
}
