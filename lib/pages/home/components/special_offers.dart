// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:maraka/logic/banner_logic.dart';
import 'package:maraka/logic/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class SpecialOffers extends StatelessWidget {
  SpecialOffers({
    Key? key,
  }) : super(key: key);
  List<dynamic> banners = [];
  Future getFeatureAds() async {
    BannerLogic logic = BannerLogic();
    var res = await logic.getBottomBanner();
    for (var element in logic.bannersBottom) {
      banners.add(element);
    }

    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20, context)),
          child: const SectionTitle(
            title: "Feature Ads",
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20, context)),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: FutureBuilder(
                future: getFeatureAds(),
                builder: ((context, snapshot) {
                  return Row(
                    children: [
                      for (var item in banners)
                        SpecialOfferCard(
                          image: server + item.imgUrl,
                          name: item.owner,
                          press: () async {
                            await launchUrl(
                              Uri.parse("http://" + item.url)
                            );
                          },
                        ),
                      SizedBox(width: getProportionateScreenWidth(20, context)),
                    ],
                  );
                }))),
      ],
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.name,
    required this.image,
    required this.press,
  }) : super(key: key);

  final String name, image;

  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20, context)),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: getProportionateScreenWidth(142, context),
          height: getProportionateScreenWidth(80, context),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Image.network(
                  image,
                  fit: BoxFit.fill,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF343434).withOpacity(0.4),
                        Color(0xFF343434).withOpacity(0.15),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(15.0, context),
                    vertical: getProportionateScreenWidth(10, context),
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: const TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: "$name\n",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(18, context),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // TextSpan(text: "$numOfBrands Brands")
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
