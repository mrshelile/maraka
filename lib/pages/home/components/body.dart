import 'package:flutter/material.dart';
import 'package:maraka/logic/user_logic.dart';
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
  List<Widget> pages = [
    Text("page0"),
    Text("page1"),
    Text("page3"),
    Text("page4")
  ];
  int current = 0;
  int start = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
              pages[current],
              // ProductList(owner: widget.owner),
              SizedBox(height: getProportionateScreenWidth(10, context)),
            ],
          ),
          if (current > 0)
            Positioned(
              bottom: getProportionateScreenHeight(6, context),
              child: MaterialButton(
                color: MyColors.blue3,
                shape: CircleBorder(),
                onPressed: () {
                  setState(() {
                    if (current > 0) --current;
                  });
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
          if (current < pages.length - 1)
            Positioned(
              right: getProportionateScreenWidth(13, context),
              bottom: getProportionateScreenHeight(6, context),
              child: MaterialButton(
                color: MyColors.blue3,
                shape: CircleBorder(),
                onPressed: () {
                  setState(() {
                    if (current < pages.length - 1) current = current + 1;
                  });
                  print(current);
                },
                child: Icon(
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
