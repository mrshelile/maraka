import 'dart:async';

import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:maraka/logic/user_logic.dart';
import 'package:maraka/service/promotion_flyer_service.dart';
import 'package:maraka/themes/background.dart';
import 'package:maraka/screens/home.dart';
import 'package:maraka/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../logic/store.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User user = User();
  final store = Get.find<StoreController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await store.loadProducts();

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Home(
          currentIndex: 0,
        ),
      ),
    );
  }

  Widget imageCarousel = AnotherCarousel(
    boxFit: BoxFit.fill,
    dotBgColor: Colors.transparent,
    dotSize: 0,
    images: [
      SvgPicture.asset("assets/undraw_empty_cart_co35.svg"),
    ],
    // options: CarouselOptions(),
  );

  bool isFinished = false;

  Future<String> makeBanners() async {
    try {
      final flyers = await PromotionFlyerService.fetchSplashScreenFlyers();

      if (flyers.isNotEmpty) {
        imageCarousel = AnotherCarousel(
          dotBgColor: Colors.transparent,
          dotSize: 0,
          images: flyers
              .map(
                (flyer) => GestureDetector(
                  onTap: () async {
                    final link = flyer.link.trim();
                    if (link.isNotEmpty) {
                      final uri = Uri.tryParse(link);
                      if (uri != null && await canLaunchUrl(uri)) {
                        await launchUrl(uri, mode: LaunchMode.externalApplication);
                      }
                    }
                  },
                  child: SizedBox(
                    height: MediaQuery.of(context).copyWith().size.height * 0.35,
                    child: CachedNetworkImage(
                      placeholder: (context, url) => const SpinKitThreeInOut(
                        color: Color.fromARGB(255, 12, 131, 125),
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                      imageUrl: flyer.imageUrl,
                    ),
                  ),
                ),
              )
              .toList(),
        );
      }

      return flyers.isNotEmpty ? 'loaded' : '';
    } catch (e) {
      debugPrint('Error loading splash promotions: $e');
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    // makeBanners();

    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          CustomPaint(
            painter: BackgroundDesign(),
            child: Container(),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).copyWith().size.height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).copyWith().size.width * 0.1,
                    ),
                    Row(
                      children: [
                        SizedBox(
                            height:
                                MediaQuery.of(context).copyWith().size.height *
                                    0.2,
                            width:
                                MediaQuery.of(context).copyWith().size.width *
                                    0.23,
                            child: Image.asset(
                              "assets/iconlogo.png",
                            )),
                        Container(
                          padding: EdgeInsets.only(
                            bottom:
                                MediaQuery.of(context).copyWith().size.height *
                                    0.06,
                            left: MediaQuery.of(context).copyWith().size.width *
                                0.15,
                          ),
                          width: MediaQuery.of(context).copyWith().size.width *
                              0.62,
                          child: const Text(
                            "Shopping made easy, buy and sell anything, anytime",
                            style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: Color.fromARGB(255, 243, 243, 243),
                                fontSize: 12),
                            maxLines: 3,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).copyWith().size.height * 0.07,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left:
                          MediaQuery.of(context).copyWith().size.width * 0.005,
                      bottom:
                          MediaQuery.of(context).copyWith().size.height * 0.03),
                  child: const Text(
                    "Buy and Sell for free",
                    style: TextStyle(color: MyColors.brown3, fontSize: 22),
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).copyWith().size.height * 0.03,
                    ),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(50)),
                    height: MediaQuery.of(context).copyWith().size.height * 0.5,
                    width: MediaQuery.of(context).copyWith().size.width * 0.85,
                    child: FutureBuilder<String>(
                      future: makeBanners(),
                      builder: (context, AsyncSnapshot<String> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SpinKitThreeInOut(
                            color: Color.fromARGB(255, 12, 131, 125),
                          );
                        } else if (snapshot.hasError) {
                          return const SizedBox();
                        } else {
                          return imageCarousel;
                        }
                      },
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
