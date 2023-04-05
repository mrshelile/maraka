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
  Categories({Key? key, required this.owner}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).copyWith().size.width;
    var height = MediaQuery.of(context).copyWith().size.height;
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(38, context)),
      child: SizedBox(
        height: getProportionateScreenWidth(85, context),
        child: ListView.builder(
            physics: const ScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(right: width * 0.05),
                child: CategoryCard(
                  icon: categories[index]["icon"],
                  text: categories[index]["text"],
                  press: () async{
                   await store.selectCategory(categories[index]["text"], owner);
                  },
                ),
              );
            }),
      ),
    );
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
                color:
                    const Color.fromARGB(255, 169, 208, 235).withOpacity(0.7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(icon!),
            ),
            SizedBox(height: getProportionateScreenHeight(2, context)),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                child: Text(
                  text!,
                  
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(15.2, context),
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
