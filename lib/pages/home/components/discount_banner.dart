import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maraka/themes/color.dart';

import '../../../size_config.dart';

class DiscountBanner extends StatefulWidget {
  DiscountBanner({
    Key? key,
  }) : super(key: key);

  @override
  State<DiscountBanner> createState() => _DiscountBannerState();
}

class _DiscountBannerState extends State<DiscountBanner> {
   Widget imageCarousel = CarouselSlider(
    items:  [
    Container(
      width: double.infinity,
      
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: Color.fromARGB(159, 242, 243, 245),
        borderRadius: BorderRadius.circular(20),
      ),
      child: SvgPicture.asset('assets/connect.svg')),
    ], 
    options: CarouselOptions(
      height: 150,
      aspectRatio: 16/9,
      viewportFraction: 0.8,
      initialPage: 0,
      enableInfiniteScroll: true,
      reverse: false,
      autoPlay: true,
      autoPlayInterval: const Duration(seconds: 3),
      autoPlayAnimationDuration: const Duration(microseconds: 200),
      autoPlayCurve: Curves.fastOutSlowIn,
      enlargeCenterPage: true,
      scrollDirection: Axis.horizontal
      ),
  );

  @override
  Widget build(BuildContext context) {
    return imageCarousel;
  }
}
