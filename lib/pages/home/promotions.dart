import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../size_config.dart';
import '../../themes/color.dart';

class Promotion {
  const Promotion({
    required this.title,
    required this.description,
    required this.badge,
    required this.icon,
    required this.backgroundColor,
    required this.accentColor,
  });

  final String title;
  final String description;
  final String badge;
  final IconData icon;
  final Color backgroundColor;
  final Color accentColor;
}

const List<Promotion> mockPromotions = [
  Promotion(
    title: 'Weekend Deals',
    description: 'Save on selected listings from local sellers.',
    badge: 'Hot offers',
    icon: Icons.local_offer_outlined,
    backgroundColor: Color(0xffe9f6f2),
    accentColor: MyColors.blue2,
  ),
  Promotion(
    title: 'Boost Your Ad',
    description: 'Featured placement for new marketplace posts.',
    badge: 'Seller promo',
    icon: Icons.campaign_outlined,
    backgroundColor: Color(0xfffff4df),
    accentColor: MyColors.orange1,
  ),
  Promotion(
    title: 'Fresh Arrivals',
    description: 'Discover newly listed products near you.',
    badge: 'New today',
    icon: Icons.auto_awesome_outlined,
    backgroundColor: Color(0xffeef2ff),
    accentColor: MyColors.blue3,
  ),
];

class PromotionsBanner extends StatefulWidget {
  const PromotionsBanner({
    super.key,
    this.promotions = mockPromotions,
  });

  final List<Promotion> promotions;

  @override
  State<PromotionsBanner> createState() => _PromotionsBannerState();
}

class _PromotionsBannerState extends State<PromotionsBanner> {
  bool _isClosed = false;

  void _closeBanner() {
    setState(() {
      _isClosed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isClosed || widget.promotions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: EdgeInsets.fromLTRB(
        getProportionateScreenWidth(14, context),
        getProportionateScreenHeight(8, context),
        getProportionateScreenWidth(14, context),
        0,
      ),
      child: CarouselSlider(
        items: widget.promotions
            .map(
              (promotion) => _PromotionCard(
                promotion: promotion,
                onClose: _closeBanner,
              ),
            )
            .toList(),
        options: CarouselOptions(
          height: getProportionateScreenHeight(118, context),
          viewportFraction: 1,
          enableInfiniteScroll: widget.promotions.length > 1,
          autoPlay: widget.promotions.length > 1,
          autoPlayInterval: const Duration(seconds: 4),
          autoPlayAnimationDuration: const Duration(milliseconds: 350),
          autoPlayCurve: Curves.easeOutCubic,
        ),
      ),
    );
  }
}

class _PromotionCard extends StatelessWidget {
  const _PromotionCard({
    required this.promotion,
    required this.onClose,
  });

  final Promotion promotion;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(18, context),
        vertical: getProportionateScreenHeight(14, context),
      ),
      decoration: BoxDecoration(
        color: promotion.backgroundColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: promotion.accentColor.withOpacity(0.24)),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
                right: getProportionateScreenWidth(28, context)),
            child: Row(
              children: [
                Container(
                  height: getProportionateScreenWidth(52, context),
                  width: getProportionateScreenWidth(52, context),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.78),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    promotion.icon,
                    color: promotion.accentColor,
                    size: getProportionateScreenWidth(28, context),
                  ),
                ),
                SizedBox(width: getProportionateScreenWidth(14, context)),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(9, context),
                          vertical: getProportionateScreenHeight(3, context),
                        ),
                        decoration: BoxDecoration(
                          color: promotion.accentColor.withOpacity(0.14),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          promotion.badge,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: promotion.accentColor,
                            fontSize: getProportionateScreenWidth(11, context),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(
                          height: getProportionateScreenHeight(7, context)),
                      Text(
                        promotion.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: MyColors.brown3,
                          fontSize: getProportionateScreenWidth(17, context),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(
                          height: getProportionateScreenHeight(3, context)),
                      Text(
                        promotion.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: MyColors.brown3.withOpacity(0.72),
                          fontSize: getProportionateScreenWidth(12.5, context),
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: IconButton(
              constraints: BoxConstraints.tightFor(
                height: getProportionateScreenWidth(32, context),
                width: getProportionateScreenWidth(32, context),
              ),
              padding: EdgeInsets.zero,
              tooltip: 'Close promotions',
              onPressed: onClose,
              icon: Icon(
                Icons.close,
                color: MyColors.brown3.withOpacity(0.72),
                size: getProportionateScreenWidth(18, context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
