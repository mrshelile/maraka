import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maraka/logic/constants.dart';
import 'package:maraka/logic/store.dart';
import 'package:maraka/logic/user_logic.dart';
import 'package:maraka/themes/color.dart';

import '../../../size_config.dart';

class Categories extends StatelessWidget {
  final store = Get.put(StoreController());
  User owner;
  Categories({Key? key,required this.owner}) : super(key: key);
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
                      left: getProportionateScreenWidth(20, context)),
                  child: CategoryCard(
                    icon: categories[index]["icon"],
                    text: categories[index]["text"],
                    press: () {
                      store.selectCategory(categories[index]["text"],owner);
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
        width: MediaQuery.of(context).copyWith().size.width * 0.38,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(
                  MediaQuery.of(context).copyWith().size.width * 0.025),
              height: getProportionateScreenWidth(60, context),
              width: MediaQuery.of(context).copyWith().size.width,
              decoration: BoxDecoration(
                // boxShadow: const [
                //   BoxShadow(
                //       color: Color.fromARGB(209, 218, 213, 213),
                //       spreadRadius: 5,
                //       blurRadius: 6,
                //       offset: Offset(0, 3))
                // ],
                color: Color.fromARGB(255, 169, 208, 235).withOpacity(0.7),
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
                      fontSize:
                          MediaQuery.of(context).copyWith().size.width * 0.023,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
