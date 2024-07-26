import 'package:flutter/material.dart';

import '../../../size_config.dart';
import 'search_field.dart';

// ignore: must_be_immutable
class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: getProportionateScreenWidth(10, context)),
      // padding: EdgeInsets.symmetric(
      //     vertical: getProportionateScreenWidth(10, context),
      //     horizontal: getProportionateScreenWidth(40, context)),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SearchField(
              // owner: owner,
              ),
        ],
      ),
    );
  }
}
