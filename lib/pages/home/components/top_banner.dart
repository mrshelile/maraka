import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:maraka/models/banner.dart' as Banner1;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maraka/logic/banner_logic.dart';
import 'package:maraka/size_config.dart';

class DiscountBanner extends StatefulWidget {
  const DiscountBanner({
    Key? key,
  }) : super(key: key);

  @override
  State<DiscountBanner> createState() => _DiscountBannerState();
}

class _DiscountBannerState extends State<DiscountBanner> {
  late Future _bannerFuture;
  var logic = BannerLogic();
  @override
  void initState() {
    super.initState();

    _bannerFuture = logic.getHomeScreenTop();
  }

  Widget buuildBannerCarousel(List<Banner1.Banner> banners) {
    if (banners.isEmpty) {
      return const SizedBox();
    }

    return SizedBox(
      height: 150,
      child: ListView.builder(
        itemCount: banners.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var sizeConfig = SizeConfig();
          sizeConfig.init(context);
          var item = banners[index];
          return Container(
            width: sizeConfig.screenWidth*0.9,
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: const Color.fromARGB(159, 242, 243, 245),
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: CachedNetworkImageProvider(item.display),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _bannerFuture,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return buuildBannerCarousel(logic.bannersHomeScreen);
          } else {
            return CarouselSlider(
              items: [
                Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(159, 242, 243, 245),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: SvgPicture.asset('assets/connect.svg')),
              ],
              options: CarouselOptions(
                  height: 150,
                  aspectRatio: 15 / 9,
                  viewportFraction: 0.84,
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
        }));
  }
}
