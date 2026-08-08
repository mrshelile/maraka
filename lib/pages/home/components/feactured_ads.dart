import 'package:flutter/material.dart';
import 'package:maraka/logic/banner_logic.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../size_config.dart';
import 'section_title.dart';

// ignore: must_be_immutable
class FeacturedAds extends StatelessWidget {
  FeacturedAds({
    super.key,
  });
  List<dynamic> banners = [];

  Future<List<dynamic>> getFeatureAds() async {
    BannerLogic logic = BannerLogic();
    await logic.getBottomBanner();
    banners = List<dynamic>.from(logic.bannersBottom);
    return banners;
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
        FutureBuilder<List<dynamic>>(
          future: getFeatureAds(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting && banners.isEmpty) {
              return SizedBox(
                height: getProportionateScreenWidth(80, context),
                child: const Center(child: CircularProgressIndicator()),
              );
            }

            if (!snapshot.hasData || banners.isEmpty) {
              return const SizedBox.shrink();
            }

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (var item in banners)
                    SpecialOfferCard(
                      image: item.imgUrl,
                      name: item.owner,
                      press: () async {
                        final url = item.url?.toString() ?? '';
                        if (url.isNotEmpty) {
                          final parsedUrl = Uri.tryParse(url.startsWith('http') ? url : 'http://$url');
                          if (parsedUrl != null) {
                            await launchUrl(parsedUrl);
                          }
                        }
                      },
                    ),
                  SizedBox(width: getProportionateScreenWidth(20, context)),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    super.key,
    required this.name,
    required this.image,
    required this.press,
  });

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
            borderRadius: BorderRadius.circular(5),
            child: Stack(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).copyWith().size.width,
                  height: MediaQuery.of(context).copyWith().size.height,
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFF343434).withOpacity( 0.4),
                        const Color(0xFF343434).withOpacity( 0.15),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(15.0, context),
                      vertical: getProportionateScreenWidth(10, context),
                    ),
                    child: Center(
                      child: Text.rich(
                        TextSpan(
                          style: const TextStyle(color: Colors.white),
                          children: [
                            TextSpan(
                              text: "$name\n",
                              style: TextStyle(
                                fontSize:
                                    getProportionateScreenWidth(18, context),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // TextSpan(text: "$numOfBrands Brands")
                          ],
                        ),
                      ),
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
