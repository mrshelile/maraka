import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maraka/logic/constants.dart';
import 'package:maraka/logic/store.dart';
import 'package:maraka/themes/color.dart';

import '../../../size_config.dart';

class Categories extends StatelessWidget {
  final store = Get.put(StoreController());
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(getProportionateScreenWidth(20, context)),
        child: SizedBox(
          height: getProportionateScreenWidth(80, context),
          child: ListView.builder(
              physics: const ScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                      left: getProportionateScreenWidth(15, context)),
                  child: CategoryCard(
                    icon: categories[index]["icon"],
                    text: categories[index]["text"],
                    press: () {
                      store.selectCategory(categories[index]["text"]);
                      
                    },
                  ),
                );
              }),
        ));
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String? icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getProportionateScreenWidth(55, context),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10, context)),
              height: getProportionateScreenWidth(60, context),
              width: getProportionateScreenWidth(60, context),
              decoration: BoxDecoration(
                color: Color.fromARGB(209, 216, 224, 224).withOpacity(0.7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(icon!),
            ),
            const SizedBox(height: 5),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                // height: getProportionateScreenHeight(51, context),
                child: Text(
                  text!,
                  // maxLines: 3,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(10, context)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
