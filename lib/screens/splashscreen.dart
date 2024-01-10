import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:maraka/logic/banner_logic.dart';
import 'package:maraka/logic/user_logic.dart';
import 'package:maraka/size_config.dart';
import 'package:maraka/themes/background.dart';
import 'package:maraka/screens/home.dart';
import 'package:maraka/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swipebuttonflutter/swipebuttonflutter.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'dart:html' as html;
import 'package:cached_network_image/cached_network_image.dart';

class Splashcreen extends StatefulWidget {
  const Splashcreen({Key? key}) : super(key: key);

  @override
  _SplashcreenState createState() => _SplashcreenState();
}

class _SplashcreenState extends State<Splashcreen> {
  User user = User();

  Widget imageCarousel = Carousel(
    boxFit: BoxFit.fill,
    dotBgColor: Colors.transparent,
    dotSize: 0,
    images: [
      SvgPicture.asset("assets/undraw_empty_cart_co35.svg"),
    ],
    // options: CarouselOptions(),
  );

  Future<String> makeBanners() async {
    var logic = BannerLogic();

    var splashscreenFuture = logic.getSplashscreen();
    await splashscreenFuture;

    if (logic.response != null) {
      if (logic.response.statusCode == 200) {
        List imgs = [];
        // List banner = [];
        for (var item in logic.bannersSplashScreen) {
          // bool skip = false;
          if (item.display != null) {
            imgs.add(item);
          }
        }
        if (imgs.isNotEmpty) {
          imageCarousel = Carousel(
            dotBgColor: Colors.transparent,
            dotSize: 0,
            images: logic.bannersSplashScreen
                .map(
                  (i) => GestureDetector(
                    onTap: () async {
                      // print(i);
                      // ignore: deprecated_member_use

                      //  html.window.open("http://${i.url}", 'new_tab');
                      if (!await launchUrl(Uri.parse("http://${i.url}"))) {
                        print("failed launching");
                      } else {
                        print("should launch");
                      }
                    },
                    child: Column(
                      children: [
                        SizedBox(
                          height:
                              MediaQuery.of(context).copyWith().size.height *
                                  0.35,
                          child: CachedNetworkImage(
                            placeholder: (context, url) =>
                                const SpinKitThreeInOut(
                              color: Color.fromARGB(255, 12, 131, 125),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            // fit:BoxFit.scaleDown,
                            imageUrl: i.display,
                          ),
                        ),
                        SizedBox(
                            height:
                                MediaQuery.of(context).copyWith().size.height *
                                    0.05,
                            child: Text(
                              i.owner.toString(),
                              style: TextStyle(
                                  fontSize:
                                      getProportionateScreenWidth(17, context)),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ))
                      ],
                    ),
                  ),
                )
                .toList(),
          );
        }

        return logic.response.toString();
      } else {
        debugPrint("not ok status");
        return "";
      }
    } else {
      debugPrint("no Response");
      return "";
    }
    // return '';
  }

  @override
  Widget build(BuildContext context) {
    // makeBanners();

    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomPaint(
            painter: BackgroundDesign(),
            child: Container(),
          ),
          SingleChildScrollView(
            child: Column(
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
                          MediaQuery.of(context).copyWith().size.height * 0.05),
                  child: const Text(
                    "Buy and Sell for free",
                    style: TextStyle(color: MyColors.brown3, fontSize: 22),
                  ),
                ),
                Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(50)),
                    height: MediaQuery.of(context).copyWith().size.height * 0.4,
                    width: MediaQuery.of(context).copyWith().size.width * 0.6,
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
                SizedBox(
                  height: MediaQuery.of(context).copyWith().size.height * 0.05,
                ),
                SwipingButton(
                  height: MediaQuery.of(context).copyWith().size.width * 0.1,
                  text: "Swipe To Get Started",
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).copyWith().size.width * 0.14,
                      right:
                          MediaQuery.of(context).copyWith().size.width * 0.15),
                  swipeButtonColor: MyColors.blue2,
                  backgroundColor: MyColors.blue3,
                  swipePercentageNeeded: 0.3,
                  onSwipeCallback: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Home(
                                  currentIndex: 0,
                                  user: User(),
                                )));
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
