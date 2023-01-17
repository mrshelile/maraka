import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maraka/logic/banner_logic.dart';
import 'package:maraka/logic/constants.dart';
import 'package:maraka/themes/color.dart';

import '../../../size_config.dart';

// class DiscountBanner extends StatefulWidget {
//   const DiscountBanner({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<DiscountBanner> createState() => _DiscountBannerState();
// }

class DiscountBanner extends StatelessWidget {
  DiscountBanner({
    Key? key,
  }) : super(key: key);
  Widget imageCarousel = CarouselSlider(
    items: [
      Container(
          width: double.infinity,
          // margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            color: const Color.fromARGB(159, 242, 243, 245),
            borderRadius: BorderRadius.circular(20),
          ),
          child: SvgPicture.asset('assets/connect.svg')),
    ],
    options: CarouselOptions(
        height: 150,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(microseconds: 200),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal),
  );
  Future makeBanner() async {
    var logic = BannerLogic();
    await logic.getHomeScreenTop();
    if (logic.response != null) {
      if (logic.response.statusCode == 200) {
        List<dynamic> imgs = [];
        if (logic.bannersHomeScreen.isNotEmpty) {
          for (var item in logic.bannersHomeScreen) {
            if (item.display != null) {
              imgs.add(item);
            }
          }
          imageCarousel = CarouselSlider(
            items: imgs
                .map((item) => Container(
                      width: double.infinity,
                      margin: const EdgeInsets.all(5),
                      
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(159, 242, 243, 245),
                          borderRadius: BorderRadius.circular(10.0),
                          image:
                              DecorationImage(image: NetworkImage(item.display), fit: BoxFit.cover)),
                    ))
                .toList(),
            options: CarouselOptions(
                height: 150,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(microseconds: 200),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal),
          );
        }
      }
    }
    return logic.response;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(38, context)),
      child: FutureBuilder(
          future: makeBanner(),
          builder: ((context, snapshot) {
            return imageCarousel;
          })),
    );
  }
}
