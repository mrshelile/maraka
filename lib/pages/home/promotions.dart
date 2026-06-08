import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../size_config.dart';
import '../../themes/background.dart';
import '../../themes/color.dart';

class Promotion {
  const Promotion({
    required this.title,
    required this.description,
    required this.badge,
    required this.offer,
    required this.validUntil,
    required this.terms,
    required this.icon,
    required this.backgroundColor,
    required this.accentColor,
  });

  final String title;
  final String description;
  final String badge;
  final String offer;
  final String validUntil;
  final List<String> terms;
  final IconData icon;
  final Color backgroundColor;
  final Color accentColor;
}

const List<Promotion> mockPromotions = [
  Promotion(
    title: 'Weekend Deals',
    description: 'Save on selected listings from local sellers.',
    badge: 'Hot offers',
    offer: 'Up to 30% off selected electronics, fashion, and home listings.',
    validUntil: '30 June 2026',
    terms: [
      'Available while promoted listings are active.',
      'Discounts are confirmed directly with the seller.',
      'Backend promotion ID placeholder: promo_weekend_001.',
    ],
    icon: Icons.local_offer_outlined,
    backgroundColor: MyColors.mintcream,
    accentColor: MyColors.blue2,
  ),
  Promotion(
    title: 'Boost Your Ad',
    description: 'Featured placement for new marketplace posts.',
    badge: 'Seller promo',
    offer: 'Get your first promoted ad placement free for 24 hours.',
    validUntil: '15 July 2026',
    terms: [
      'One promotion per seller account in the mock flow.',
      'Promotion applies to newly created listings only.',
      'Backend promotion ID placeholder: promo_seller_002.',
    ],
    icon: Icons.campaign_outlined,
    backgroundColor: MyColors.lightgoldenrodyellow,
    accentColor: MyColors.blue3,
  ),
  Promotion(
    title: 'Fresh Arrivals',
    description: 'Discover newly listed products near you.',
    badge: 'New today',
    offer: 'Browse fresh local listings added in the last 48 hours.',
    validUntil: 'Ongoing',
    terms: [
      'Shown products will come from backend promotion rules later.',
      'Mock data is currently used for frontend testing.',
      'Backend promotion ID placeholder: promo_arrivals_003.',
    ],
    icon: Icons.auto_awesome_outlined,
    backgroundColor: MyColors.honeydew,
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

  void _openPromotion(Promotion promotion) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PromotionDetailsPage(promotion: promotion),
      ),
    );
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
                onTap: () => _openPromotion(promotion),
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
    required this.onTap,
    this.onClose,
  });

  final Promotion promotion;
  final VoidCallback? onClose;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(18, context),
          vertical: getProportionateScreenHeight(14, context),
        ),
        decoration: BoxDecoration(
          color: promotion.backgroundColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: promotion.accentColor.withOpacity(0.28)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.18),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
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
                      borderRadius: BorderRadius.circular(10),
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
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            promotion.badge,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: promotion.accentColor,
                              fontSize:
                                  getProportionateScreenWidth(11, context),
                              fontWeight: FontWeight.bold,
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
                            fontWeight: FontWeight.bold,
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
                            fontSize:
                                getProportionateScreenWidth(12.5, context),
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (onClose != null)
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
      ),
    );
  }
}

class PromotionsPage extends StatelessWidget {
  const PromotionsPage({
    super.key,
    this.promotions = mockPromotions,
  });

  final List<Promotion> promotions;

  void _openPromotion(BuildContext context, Promotion promotion) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PromotionDetailsPage(promotion: promotion),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          painter: BackgroundDesign(),
          child: Container(),
        ),
        SafeArea(
          child: ListView(
            padding: EdgeInsets.fromLTRB(
              getProportionateScreenWidth(14, context),
              getProportionateScreenHeight(20, context),
              getProportionateScreenWidth(14, context),
              getProportionateScreenHeight(24, context),
            ),
            children: [
              Text(
                'Promotions',
                style: TextStyle(
                  color: MyColors.brown3,
                  fontSize: getProportionateScreenWidth(24, context),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(6, context)),
              Text(
                'Mock promotion data for the backend integration.',
                style: TextStyle(
                  color: MyColors.brown3.withOpacity(0.66),
                  fontSize: getProportionateScreenWidth(13.5, context),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(16, context)),
              ...promotions.map(
                (promotion) => Padding(
                  padding: EdgeInsets.only(
                    bottom: getProportionateScreenHeight(12, context),
                  ),
                  child: SizedBox(
                    height: getProportionateScreenHeight(118, context),
                    child: _PromotionCard(
                      promotion: promotion,
                      onTap: () => _openPromotion(context, promotion),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PromotionDetailsPage extends StatelessWidget {
  const PromotionDetailsPage({
    super.key,
    required this.promotion,
  });

  final Promotion promotion;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: MyColors.blue3,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(promotion.title),
      ),
      body: Stack(
        children: [
          CustomPaint(
            painter: BackgroundDesign(),
            child: Container(),
          ),
          ListView(
            padding: EdgeInsets.all(getProportionateScreenWidth(18, context)),
            children: [
              Container(
                padding:
                    EdgeInsets.all(getProportionateScreenWidth(18, context)),
                decoration: BoxDecoration(
                  color: promotion.backgroundColor,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      color: promotion.accentColor.withOpacity(0.28)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.18),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: getProportionateScreenWidth(58, context),
                      width: getProportionateScreenWidth(58, context),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.82),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        promotion.icon,
                        color: promotion.accentColor,
                        size: getProportionateScreenWidth(32, context),
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(16, context)),
                    Text(
                      promotion.badge,
                      style: TextStyle(
                        color: promotion.accentColor,
                        fontSize: getProportionateScreenWidth(13, context),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(8, context)),
                    Text(
                      promotion.offer,
                      style: TextStyle(
                        color: MyColors.brown3,
                        fontSize: getProportionateScreenWidth(22, context),
                        fontWeight: FontWeight.bold,
                        height: 1.15,
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(10, context)),
                    Text(
                      promotion.description,
                      style: TextStyle(
                        color: MyColors.brown3.withOpacity(0.72),
                        fontSize: getProportionateScreenWidth(14, context),
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(18, context)),
              _PromotionInfoRow(
                icon: Icons.event_available_outlined,
                label: 'Valid until',
                value: promotion.validUntil,
                color: promotion.accentColor,
              ),
              SizedBox(height: getProportionateScreenHeight(18, context)),
              Text(
                'Promotion terms',
                style: TextStyle(
                  color: MyColors.brown3,
                  fontSize: getProportionateScreenWidth(18, context),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(10, context)),
              ...promotion.terms.map(
                (term) => Padding(
                  padding: EdgeInsets.only(
                    bottom: getProportionateScreenHeight(9, context),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: promotion.accentColor,
                        size: getProportionateScreenWidth(18, context),
                      ),
                      SizedBox(width: getProportionateScreenWidth(9, context)),
                      Expanded(
                        child: Text(
                          term,
                          style: TextStyle(
                            color: MyColors.brown3.withOpacity(0.78),
                            fontSize:
                                getProportionateScreenWidth(13.5, context),
                            height: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PromotionInfoRow extends StatelessWidget {
  const _PromotionInfoRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(getProportionateScreenWidth(14, context)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.18),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: getProportionateScreenWidth(24, context),
          ),
          SizedBox(width: getProportionateScreenWidth(12, context)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: MyColors.brown3.withOpacity(0.58),
                  fontSize: getProportionateScreenWidth(12, context),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(2, context)),
              Text(
                value,
                style: TextStyle(
                  color: MyColors.brown3,
                  fontSize: getProportionateScreenWidth(15, context),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
