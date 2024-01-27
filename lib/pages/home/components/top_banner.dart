import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maraka/logic/banner_logic.dart';

class DiscountBanner extends StatefulWidget {
  const DiscountBanner({
    Key? key,
  }) : super(key: key);

  @override
  State<DiscountBanner> createState() => _DiscountBannerState();
}

class _DiscountBannerState extends State<DiscountBanner> {
  late Future _bannerFuture;
  @override
  void initState() {
    super.initState();
    // _bannerFuture = makeBanner();
  }

  Widget imageCarousel = Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
    ),
    child: CarouselSlider(
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
          height: 200,
          aspectRatio: 15 / 9,
          viewportFraction: 1.0,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(microseconds: 200),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal),
    ),
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
          imageCarousel = Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                  20), // Adjust the radius as per your requirement
            ),
            width: double.infinity,
            child: CarouselSlider(
              items: imgs
                  .map((item) => Container(
                        width: double.infinity,
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(159, 242, 243, 245),
                          borderRadius: BorderRadius.circular(20.0),
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(item.display),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: item.display,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const SpinKitThreeInOut(
                            color: Color.fromARGB(255, 12, 131, 125),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ))
                  .toList(),
              options: CarouselOptions(
                  height: 200,
                  aspectRatio: 15 / 9,
                  viewportFraction: 1.0,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(microseconds: 200),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal),
            ),
          );
        }
      }
    }
    return logic.response;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: makeBanner(),
        builder: ((context, snapshot) {
          return GestureDetector(
              onTap: () async {
                setState(() {});
              },
              child: Container(
                  margin: EdgeInsets.all(5),
                  width: MediaQuery.of(context).copyWith().size.width * 1,
                  child: ClipRRect(borderRadius:BorderRadius.circular(30),child: imageCarousel)));
        }));
  }
}
