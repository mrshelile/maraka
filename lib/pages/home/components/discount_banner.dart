import 'package:flutter/material.dart';
import 'package:maraka/themes/color.dart';

import '../../../size_config.dart';

class DiscountBanner extends StatelessWidget {
  const DiscountBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 90,
      width: double.infinity,
      margin: EdgeInsets.all(getProportionateScreenWidth(20,context)),
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20,context),
        vertical: getProportionateScreenWidth(15,context),
      ),
      decoration: BoxDecoration(
        color: MyColors.blue3,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text.rich(
        TextSpan(
          style: TextStyle(color: Colors.white),
          children: [
            TextSpan(text: "A Summer Surpise\n"),
            TextSpan(
              text: "Cashback 20%",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(24,context),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
