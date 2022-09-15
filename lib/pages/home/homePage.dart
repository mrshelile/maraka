// ignore_for_file: non_constant_identifier_names

import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:maraka/logic/banner_logic.dart';
import 'package:maraka/logic/products_logic.dart';
import 'package:maraka/logic/user_logic.dart';
import 'package:maraka/models/product.dart';
import 'package:maraka/models/products.dart';
import 'package:maraka/pages/home/components/body.dart';
import 'package:maraka/themes/background.dart';
import 'package:maraka/logic/constants.dart';
import 'package:maraka/screens/componets/widget/products_item.dart';
import 'package:maraka/themes/color.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

const cellRed = Color(0xffc73232);
const cellMustard = Color(0xffd7aa22);
const cellGrey = Color(0xffcfd4e0);
const cellBlue = Color(0xff1553be);
const background = Color(0xff242830);

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  User owner;
  HomePage({Key? key, required this.owner}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> products = [];
  double value = 0;
  var selected_category = "All";
  final List<String> _pageCategories = [];
  List<dynamic> bottomImgs = [
    {"image": const AssetImage("assets/alldata.png"), "url": server},
    {"image": const AssetImage("assets/payment.png"), "url": server}
  ];
  // Widget imageCarousel = Carousel(
  //   boxFit: BoxFit.fill,

  //   images: [
  //     SvgPicture.asset(
  //       "assets/market.svg",
  //     ),
  //   ],
  // );
  Widget imageCarousel = CarouselSlider(
    items: [
      Container(
        margin: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            image: const DecorationImage(
                image: Svg('assets/connect.svg'), fit: BoxFit.cover)),
        // child: SvgPicture.asset(
        //   "assets/connect.svg",
        // ),
      ),
    ],
    options: CarouselOptions(
        height: 200,
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
  Future<dynamic> getAllData() async {
    var resp1 = await makeBanner();
    if (resp1 != null) {
      if (resp1.statusCode == 200) {
        var resp2 = await makeBottomBanner();
        if (resp2 != null) {
          if (resp2.statusCode == 200) {
            var resp = await makeProductList();
            products = resp;

            return resp;
          }
        }
      }
    }

    return Null;
  }

  Future<List<Product>> makeProductList() async {
    var logic = ProductLogic();
    List<Product> products =
        await logic.getProducts(widget.owner, selected_category.toLowerCase());

    return products;
  }

  Future makeBottomBanner() async {
    var logic = BannerLogic();
    await logic.getBottomBanner();
    if (logic.response != null) {
      bottomImgs = [];
      if (logic.response.statusCode == 200) {
        for (var item in logic.bannersBottom) {
          if (item.display != null) {
            if (item.display['data'] != null) {
              if (item.display['data']['attributes'] != null) {
                if (item.display['data']['attributes']['url'] != null) {
                  bottomImgs.add({
                    "image": NetworkImage(
                        server + item.display['data']['attributes']['url']),
                    "url": item.url
                  });
                }
              }
            }
          }
        }
      }
    }
    return logic.response;
  }

  Future makeBanner() async {
    var logic = BannerLogic();
    await logic.getHomeScreenTop();
    if (logic.response != null) {
      if (logic.response.statusCode == 200) {
        List<dynamic> imgs = [];
        if (logic.bannersHomeScreen.isNotEmpty) {
          for (var item in logic.bannersHomeScreen) {
            bool skip = false;
            if (item.display != null) {
              if (item.display['data'] != null) {
                if (item.display['data']['attributes'] != null) {
                  if (item.display['data']['attributes']['url'] != null) {
                    imgs.add(NetworkImage(
                        server + item.display['data']['attributes']['url']));
                    // imgs.add(NetworkImage(
                    //     "https://www.freepngimg.com/thumb/advertising/11-2-advertising-png-clipart-thumb.png"));
                  }
                }
              }
            }
          }
          // imageCarousel = Carousel(
          //   // dotHorizontalPadding: 10.0,
          //   dotBgColor: Colors.transparent,
          //   boxFit: BoxFit.fill,
          //   images: imgs,
          //   dotColor: MyColors.goldFusion,
          //   dotIncreasedColor: MyColors.blue2,
          // );
          imageCarousel = CarouselSlider(
            items: imgs
                .map((item) => Container(
                      margin: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          image:
                              DecorationImage(image: item, fit: BoxFit.cover)),
                    ))
                .toList(),
            options: CarouselOptions(
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                height: 180.0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(microseconds: 800),
                autoPlayCurve: Curves.slowMiddle,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal),
          );
        }
      }
    }
    return logic.response;
  }

  @override
  void initState() {
    categories.forEach((key, value) {
      _pageCategories.add(key);
    });
    setState(() {
      selected_category = "All".toLowerCase();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ProductLogic productLogic = ProductLogic();
    // productLogic.getProduct(1);
    var height = MediaQuery.of(context).copyWith().size.height;
    var width = MediaQuery.of(context).copyWith().size.width;
    return Stack(
      children: <Widget>[
        CustomPaint(
          painter: BackgroundDesign(),
          child: Container(),
          ),
        Body(),
      ],
    );
  }
}
