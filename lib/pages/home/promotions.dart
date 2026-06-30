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
    required this.imageAsset,
    required this.flyerStyle,
    this.uploadedFlyerUrl,
    required this.samples,
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
  final String imageAsset;
  final PromotionFlyerStyle flyerStyle;
  final String? uploadedFlyerUrl;
  final List<PromotionSample> samples;
  final List<String> terms;
  final IconData icon;
  final Color backgroundColor;
  final Color accentColor;
}

class PromotionSample {
  const PromotionSample({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.location,
    required this.category,
    required this.owner,
    required this.condition,
    required this.contact,
    required this.actionLabel,
    required this.details,
  });

  final String title;
  final String subtitle;
  final String price;
  final String location;
  final String category;
  final String owner;
  final String condition;
  final String contact;
  final String actionLabel;
  final List<String> details;
}

enum PromotionFlyerStyle {
  image,
  cashCrusaders,
  game,
}

const List<Promotion> mockPromotions = [
  Promotion(
    title: 'Weekend Deals',
    description: 'Weekend discounts from Cash Crusaders.',
    badge: 'Hot offers',
    offer: 'Sample weekend deals from Cash Crusaders stores.',
    validUntil: '30 June 2026',
    imageAsset: 'assets/mock_flyers/weekend_deals.webp',
    flyerStyle: PromotionFlyerStyle.image,
    samples: [
      PromotionSample(
        title: 'Cash Crusaders - Samsung 43" Smart TV',
        subtitle: 'Pre-owned TV with remote and 7 day store warranty.',
        price: 'M2,899',
        location: 'Cash Crusaders Maseru Mall',
        category: 'Electronics',
        owner: 'Cash Crusaders',
        condition: 'Pre-owned',
        contact: '+266 5800 0101',
        actionLabel: 'Reserve at store',
        details: [
          '43 inch LED smart TV with HDMI and USB ports.',
          'Includes original remote and power cable.',
          'Store warranty is mocked as 7 days for backend testing.',
        ],
      ),
      PromotionSample(
        title: 'Cash Crusaders - HP EliteBook Laptop',
        subtitle: 'Core i5 laptop, 8GB RAM, ready for work or school.',
        price: 'M3,450',
        location: 'Cash Crusaders Pioneer Mall',
        category: 'Computers',
        owner: 'Cash Crusaders',
        condition: 'Pre-owned',
        contact: '+266 5800 0102',
        actionLabel: 'Ask about laptop',
        details: [
          'Intel Core i5 processor with 8GB RAM.',
          'Mock storage value: 256GB SSD.',
          'Suitable for office work, school projects, and browsing.',
        ],
      ),
      PromotionSample(
        title: 'Cash Crusaders - PlayStation 4 Bundle',
        subtitle: 'Console, controller, and two games included.',
        price: 'M4,200',
        location: 'Cash Crusaders City Centre',
        category: 'Gaming',
        owner: 'Cash Crusaders',
        condition: 'Pre-owned',
        contact: '+266 5800 0103',
        actionLabel: 'Check availability',
        details: [
          'PS4 console with one wireless controller.',
          'Includes two sample game titles for mock display.',
          'Backend can later attach images and stock count.',
        ],
      ),
    ],
    terms: [
      'Sample prices are placeholder data for frontend testing.',
      'Final stock and discounts will be confirmed by Cash Crusaders data.',
      'Backend promotion ID placeholder: promo_weekend_001.',
    ],
    icon: Icons.local_offer_outlined,
    backgroundColor: MyColors.mintcream,
    accentColor: MyColors.blue3,
  ),
  Promotion(
    title: 'Boost Your Ad',
    description: 'Featured placement for Sameer\'s Toyota Camry ad.',
    badge: 'Seller promo',
    offer: 'Sameer is boosting his Toyota Camry listing for more visibility.',
    validUntil: '15 July 2026',
    imageAsset: 'assets/car1.jpeg',
    flyerStyle: PromotionFlyerStyle.image,
    samples: [
      PromotionSample(
        title: 'Sameer - Toyota Camry 2012',
        subtitle: 'Automatic, petrol, neat interior, roadworthy paperwork.',
        price: 'M78,000',
        location: 'Maseru West',
        category: 'Cars',
        owner: 'Sameer',
        condition: 'Used',
        contact: '+266 5900 2200',
        actionLabel: 'Message Sameer',
        details: [
          'Toyota Camry 2012 automatic petrol model.',
          'Clean interior and daily runner condition.',
          'Roadworthy paperwork is listed as available in mock data.',
        ],
      ),
      PromotionSample(
        title: 'Seller contact preview',
        subtitle: 'Sameer wants serious buyers to call or message in-app.',
        price: 'Boosted ad',
        location: 'Featured for 24 hours',
        category: 'Promotion placement',
        owner: 'Sameer',
        condition: 'Active boost',
        contact: 'In-app message preview',
        actionLabel: 'Preview contact flow',
        details: [
          'Boosted listing appears higher in the mock promotions feed.',
          'Contact action will later route to chat or seller phone rules.',
          'This sample helps test seller promotion display states.',
        ],
      ),
    ],
    terms: [
      'This is dummy seller data while backend promotion records are prepared.',
      'The boosted placement will later be controlled by paid promotion rules.',
      'Backend promotion ID placeholder: promo_seller_002.',
    ],
    icon: Icons.campaign_outlined,
    backgroundColor: MyColors.mintcream,
    accentColor: MyColors.blue3,
  ),
  Promotion(
    title: 'Fresh Arrivals',
    description: 'New product examples from Game Stores.',
    badge: 'New today',
    offer: 'Fresh arrivals sample feed from Game Stores.',
    validUntil: 'Ongoing',
    imageAsset: 'assets/mock_flyers/fresh_arrivals.webp',
    flyerStyle: PromotionFlyerStyle.image,
    samples: [
      PromotionSample(
        title: 'Game Stores - Defy Microwave',
        subtitle: 'Compact microwave, ideal for student rooms and offices.',
        price: 'M1,099',
        location: 'Game Maseru',
        category: 'Appliances',
        owner: 'Game Stores',
        condition: 'New',
        contact: '+266 5800 0301',
        actionLabel: 'View store item',
        details: [
          'Compact Defy microwave sample listing.',
          'Ideal for offices, student rooms, or small kitchens.',
          'Backend can later provide stock level and SKU.',
        ],
      ),
      PromotionSample(
        title: 'Game Stores - Hisense Fridge',
        subtitle: 'Two-door fridge with freezer compartment.',
        price: 'M5,499',
        location: 'Game Maseru',
        category: 'Appliances',
        owner: 'Game Stores',
        condition: 'New',
        contact: '+266 5800 0302',
        actionLabel: 'Check store stock',
        details: [
          'Two-door Hisense fridge sample product.',
          'Includes freezer compartment and adjustable shelves.',
          'Mock data can map to inventory fields later.',
        ],
      ),
      PromotionSample(
        title: 'Game Stores - JBL Bluetooth Speaker',
        subtitle: 'Portable speaker with rechargeable battery.',
        price: 'M799',
        location: 'Game Maseru',
        category: 'Audio',
        owner: 'Game Stores',
        condition: 'New',
        contact: '+266 5800 0303',
        actionLabel: 'View speaker deal',
        details: [
          'Portable Bluetooth speaker with rechargeable battery.',
          'Mock feature: splash resistant casing.',
          'Useful for testing promoted accessory cards.',
        ],
      ),
    ],
    terms: [
      'Fresh arrivals are mock examples until store inventory is connected.',
      'Backend will later decide which store products are promoted.',
      'Backend promotion ID placeholder: promo_arrivals_003.',
    ],
    icon: Icons.auto_awesome_outlined,
    backgroundColor: MyColors.mintcream,
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
    showPromotionDetailsDialog(context, promotion);
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
          height: getProportionateScreenHeight(132, context),
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
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(14, context),
        vertical: getProportionateScreenHeight(12, context),
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
              right: onClose == null
                  ? 0
                  : getProportionateScreenWidth(28, context),
            ),
            child: Row(
              children: [
                _PromotionImageButton(
                  promotion: promotion,
                  onTap: onTap,
                ),
                SizedBox(width: getProportionateScreenWidth(13, context)),
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
                            fontSize: getProportionateScreenWidth(11, context),
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
    );
  }
}

class _PromotionImageButton extends StatelessWidget {
  const _PromotionImageButton({
    required this.promotion,
    required this.onTap,
  });

  final Promotion promotion;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final size = getProportionateScreenWidth(92, context);

    return Semantics(
      button: true,
      label: promotion.title,
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            height: size,
            width: size,
            child: Stack(
              fit: StackFit.expand,
              children: [
                PromotionVisual(
                  promotion: promotion,
                  compact: true,
                ),
                Positioned(
                  right: getProportionateScreenWidth(6, context),
                  bottom: getProportionateScreenWidth(6, context),
                  child: Container(
                    height: getProportionateScreenWidth(24, context),
                    width: getProportionateScreenWidth(24, context),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.92),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.chevron_right,
                      color: promotion.accentColor,
                      size: getProportionateScreenWidth(18, context),
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

class PromotionsPage extends StatelessWidget {
  const PromotionsPage({
    super.key,
    this.promotions = mockPromotions,
  });

  final List<Promotion> promotions;

  void _openPromotion(BuildContext context, Promotion promotion) {
    showPromotionDetailsDialog(context, promotion);
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
                    height: getProportionateScreenHeight(132, context),
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

void showPromotionDetailsDialog(BuildContext context, Promotion promotion) {
  showDialog<void>(
    context: context,
    barrierColor: Colors.black.withOpacity(0.62),
    builder: (context) => PromotionDetailsDialog(promotion: promotion),
  );
}

class PromotionDetailsDialog extends StatelessWidget {
  const PromotionDetailsDialog({
    super.key,
    required this.promotion,
  });

  final Promotion promotion;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final dialogWidth = screenSize.width < 560
        ? screenSize.width - getProportionateScreenWidth(24, context)
        : 520.0;

    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(12, context),
        vertical: getProportionateScreenHeight(18, context),
      ),
      backgroundColor: Colors.transparent,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: screenSize.height * 0.88,
          maxWidth: dialogWidth,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Material(
            color: Colors.white,
            child: Stack(
              children: [
                ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children: [
                    _PromotionDialogImage(promotion: promotion),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        getProportionateScreenWidth(18, context),
                        getProportionateScreenHeight(16, context),
                        getProportionateScreenWidth(18, context),
                        getProportionateScreenHeight(18, context),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  getProportionateScreenWidth(10, context),
                              vertical:
                                  getProportionateScreenHeight(4, context),
                            ),
                            decoration: BoxDecoration(
                              color: promotion.accentColor.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              promotion.badge,
                              style: TextStyle(
                                color: promotion.accentColor,
                                fontSize:
                                    getProportionateScreenWidth(12, context),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                              height:
                                  getProportionateScreenHeight(10, context)),
                          Text(
                            promotion.title,
                            style: TextStyle(
                              color: MyColors.brown3,
                              fontSize:
                                  getProportionateScreenWidth(22, context),
                              fontWeight: FontWeight.bold,
                              height: 1.12,
                            ),
                          ),
                          SizedBox(
                              height: getProportionateScreenHeight(8, context)),
                          Text(
                            promotion.offer,
                            style: TextStyle(
                              color: MyColors.brown3.withOpacity(0.78),
                              fontSize:
                                  getProportionateScreenWidth(14, context),
                              height: 1.32,
                            ),
                          ),
                          SizedBox(
                              height:
                                  getProportionateScreenHeight(14, context)),
                          _PromotionInfoRow(
                            icon: Icons.event_available_outlined,
                            label: 'Valid until',
                            value: promotion.validUntil,
                            color: promotion.accentColor,
                          ),
                          SizedBox(
                              height:
                                  getProportionateScreenHeight(14, context)),
                          Text(
                            'Specials in this promotion',
                            style: TextStyle(
                              color: MyColors.brown3,
                              fontSize:
                                  getProportionateScreenWidth(17, context),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                              height: getProportionateScreenHeight(8, context)),
                          ...promotion.samples.map(
                            (sample) => _PromotionDialogDeal(
                              sample: sample,
                              color: promotion.accentColor,
                            ),
                          ),
                          SizedBox(
                              height:
                                  getProportionateScreenHeight(10, context)),
                          Text(
                            'Terms',
                            style: TextStyle(
                              color: MyColors.brown3,
                              fontSize:
                                  getProportionateScreenWidth(17, context),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                              height: getProportionateScreenHeight(8, context)),
                          ...promotion.terms.map(
                            (term) => Padding(
                              padding: EdgeInsets.only(
                                bottom:
                                    getProportionateScreenHeight(8, context),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.check_circle_outline,
                                    color: promotion.accentColor,
                                    size: getProportionateScreenWidth(
                                        18, context),
                                  ),
                                  SizedBox(
                                      width: getProportionateScreenWidth(
                                          8, context)),
                                  Expanded(
                                    child: Text(
                                      term,
                                      style: TextStyle(
                                        color:
                                            MyColors.brown3.withOpacity(0.78),
                                        fontSize: getProportionateScreenWidth(
                                            13, context),
                                        height: 1.32,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  right: getProportionateScreenWidth(8, context),
                  top: getProportionateScreenWidth(8, context),
                  child: Material(
                    color: Colors.white.withOpacity(0.94),
                    shape: const CircleBorder(),
                    child: IconButton(
                      constraints: BoxConstraints.tightFor(
                        height: getProportionateScreenWidth(38, context),
                        width: getProportionateScreenWidth(38, context),
                      ),
                      padding: EdgeInsets.zero,
                      tooltip: 'Close promotion',
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.close,
                        color: MyColors.brown3,
                        size: getProportionateScreenWidth(20, context),
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

class _PromotionDialogImage extends StatelessWidget {
  const _PromotionDialogImage({
    required this.promotion,
  });

  final Promotion promotion;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.28,
      child: PromotionVisual(promotion: promotion),
    );
  }
}

class PromotionVisual extends StatelessWidget {
  const PromotionVisual({
    super.key,
    required this.promotion,
    this.compact = false,
  });

  final Promotion promotion;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final uploadedFlyerUrl = promotion.uploadedFlyerUrl?.trim();
    if (uploadedFlyerUrl != null && uploadedFlyerUrl.isNotEmpty) {
      return _UploadedPromotionFlyer(
        promotion: promotion,
        imageUrl: uploadedFlyerUrl,
        compact: compact,
      );
    }

    switch (promotion.flyerStyle) {
      case PromotionFlyerStyle.cashCrusaders:
        return _StoreFlyer(
          promotion: promotion,
          compact: compact,
          storeName: 'CASH CRUSADERS',
          strapline: 'Pre-owned bargains',
          primaryColor: const Color(0xff006a4e),
          secondaryColor: const Color(0xfff4c430),
          surfaceColor: const Color(0xfff7fff8),
        );
      case PromotionFlyerStyle.game:
        return _StoreFlyer(
          promotion: promotion,
          compact: compact,
          storeName: 'GAME',
          strapline: 'Fresh arrivals',
          primaryColor: const Color(0xffd71920),
          secondaryColor: const Color(0xffffd400),
          surfaceColor: const Color(0xfffffbf0),
        );
      case PromotionFlyerStyle.image:
        return Image.asset(
          promotion.imageAsset,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _PromotionImageFallback(
            promotion: promotion,
            compact: compact,
          ),
        );
    }
  }
}

class _UploadedPromotionFlyer extends StatelessWidget {
  const _UploadedPromotionFlyer({
    required this.promotion,
    required this.imageUrl,
    required this.compact,
  });

  final Promotion promotion;
  final String imageUrl;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }

        return Container(
          color: promotion.accentColor.withOpacity(0.08),
          alignment: Alignment.center,
          child: SizedBox(
            height: getProportionateScreenWidth(compact ? 20 : 30, context),
            width: getProportionateScreenWidth(compact ? 20 : 30, context),
            child: CircularProgressIndicator(
              strokeWidth: compact ? 2 : 3,
              color: promotion.accentColor,
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) => _PromotionImageFallback(
        promotion: promotion,
        compact: compact,
      ),
    );
  }
}

class _PromotionImageFallback extends StatelessWidget {
  const _PromotionImageFallback({
    required this.promotion,
    required this.compact,
  });

  final Promotion promotion;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: promotion.accentColor.withOpacity(0.12),
      child: Icon(
        promotion.icon,
        color: promotion.accentColor,
        size: getProportionateScreenWidth(compact ? 30 : 48, context),
      ),
    );
  }
}

class _StoreFlyer extends StatelessWidget {
  const _StoreFlyer({
    required this.promotion,
    required this.compact,
    required this.storeName,
    required this.strapline,
    required this.primaryColor,
    required this.secondaryColor,
    required this.surfaceColor,
  });

  final Promotion promotion;
  final bool compact;
  final String storeName;
  final String strapline;
  final Color primaryColor;
  final Color secondaryColor;
  final Color surfaceColor;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        final scale = (width / 320).clamp(0.32, 1.45).toDouble();
        final deals = promotion.samples.take(compact ? 2 : 3).toList();

        return Container(
          color: surfaceColor,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                right: -width * 0.16,
                bottom: -height * 0.2,
                child: Container(
                  height: height * 0.52,
                  width: height * 0.52,
                  decoration: BoxDecoration(
                    color: secondaryColor.withOpacity(0.42),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    color: primaryColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: 14 * scale,
                      vertical: compact ? 7 * scale : 12 * scale,
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: compact ? 23 * scale : 36 * scale,
                          width: compact ? 23 * scale : 36 * scale,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(5 * scale),
                          ),
                          child: Text(
                            storeName.substring(0, 1),
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: compact ? 14 * scale : 22 * scale,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        SizedBox(width: 8 * scale),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                storeName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: compact ? 13 * scale : 22 * scale,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              if (!compact)
                                Text(
                                  strapline,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.86),
                                    fontSize: 11 * scale,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        10 * scale,
                        compact ? 6 * scale : 10 * scale,
                        10 * scale,
                        9 * scale,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  compact
                                      ? promotion.title.toUpperCase()
                                      : promotion.title,
                                  maxLines: compact ? 1 : 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: compact ? 10 * scale : 18 * scale,
                                    fontWeight: FontWeight.w900,
                                    height: 1.05,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6 * scale,
                                  vertical: 3 * scale,
                                ),
                                decoration: BoxDecoration(
                                  color: secondaryColor,
                                  borderRadius:
                                      BorderRadius.circular(4 * scale),
                                ),
                                child: Text(
                                  compact ? 'SAVE' : promotion.badge,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: compact ? 8 * scale : 10 * scale,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: compact ? 5 * scale : 10 * scale),
                          Expanded(
                            child: compact
                                ? Column(
                                    children: deals
                                        .map(
                                          (sample) => Expanded(
                                            child: _FlyerDealStrip(
                                              sample: sample,
                                              primaryColor: primaryColor,
                                              secondaryColor: secondaryColor,
                                              scale: scale,
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  )
                                : GridView.count(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 8 * scale,
                                    crossAxisSpacing: 8 * scale,
                                    childAspectRatio: 1.34,
                                    padding: EdgeInsets.zero,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    children: deals
                                        .map(
                                          (sample) => _FlyerDealTile(
                                            sample: sample,
                                            primaryColor: primaryColor,
                                            secondaryColor: secondaryColor,
                                            scale: scale,
                                          ),
                                        )
                                        .toList(),
                                  ),
                          ),
                          if (!compact)
                            Padding(
                              padding: EdgeInsets.only(top: 8 * scale),
                              child: Text(
                                'Valid until ${promotion.validUntil}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: MyColors.brown3.withOpacity(0.64),
                                  fontSize: 10 * scale,
                                  fontWeight: FontWeight.w700,
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
      },
    );
  }
}

class _FlyerDealStrip extends StatelessWidget {
  const _FlyerDealStrip({
    required this.sample,
    required this.primaryColor,
    required this.secondaryColor,
    required this.scale,
  });

  final PromotionSample sample;
  final Color primaryColor;
  final Color secondaryColor;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 4 * scale),
      padding: EdgeInsets.symmetric(horizontal: 6 * scale, vertical: 4 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5 * scale),
        border: Border.all(color: primaryColor.withOpacity(0.18)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.sell_outlined,
            color: primaryColor,
            size: 12 * scale,
          ),
          SizedBox(width: 5 * scale),
          Expanded(
            child: Text(
              _flyerProductName(sample),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: MyColors.brown3,
                fontSize: 7.5 * scale,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Text(
            sample.price,
            style: TextStyle(
              color: primaryColor,
              fontSize: 8.5 * scale,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class _FlyerDealTile extends StatelessWidget {
  const _FlyerDealTile({
    required this.sample,
    required this.primaryColor,
    required this.secondaryColor,
    required this.scale,
  });

  final PromotionSample sample;
  final Color primaryColor;
  final Color secondaryColor;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(9 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7 * scale),
        border: Border.all(color: primaryColor.withOpacity(0.18)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 8 * scale,
            offset: Offset(0, 3 * scale),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 28 * scale,
                width: 28 * scale,
                decoration: BoxDecoration(
                  color: secondaryColor.withOpacity(0.38),
                  borderRadius: BorderRadius.circular(6 * scale),
                ),
                child: Icon(
                  _flyerIcon(sample.category),
                  color: primaryColor,
                  size: 17 * scale,
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 6 * scale,
                  vertical: 3 * scale,
                ),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(4 * scale),
                ),
                child: Text(
                  sample.price,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13 * scale,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8 * scale),
          Text(
            _flyerProductName(sample),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: MyColors.brown3,
              fontSize: 12 * scale,
              fontWeight: FontWeight.w900,
              height: 1.08,
            ),
          ),
          SizedBox(height: 4 * scale),
          Text(
            sample.subtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: MyColors.brown3.withOpacity(0.62),
              fontSize: 9 * scale,
              height: 1.18,
            ),
          ),
        ],
      ),
    );
  }
}

String _flyerProductName(PromotionSample sample) {
  final separatorIndex = sample.title.indexOf(' - ');
  if (separatorIndex == -1) {
    return sample.title;
  }
  return sample.title.substring(separatorIndex + 3);
}

IconData _flyerIcon(String category) {
  switch (category) {
    case 'Electronics':
      return Icons.tv_outlined;
    case 'Computers':
      return Icons.laptop_mac_outlined;
    case 'Gaming':
      return Icons.sports_esports_outlined;
    case 'Appliances':
      return Icons.kitchen_outlined;
    case 'Audio':
      return Icons.speaker_outlined;
    default:
      return Icons.local_offer_outlined;
  }
}

class _PromotionDialogDeal extends StatelessWidget {
  const _PromotionDialogDeal({
    required this.sample,
    required this.color,
  });

  final PromotionSample sample;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: getProportionateScreenHeight(8, context)),
      padding: EdgeInsets.all(getProportionateScreenWidth(12, context)),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.14)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: getProportionateScreenWidth(40, context),
            width: getProportionateScreenWidth(40, context),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.local_offer_outlined,
              color: color,
              size: getProportionateScreenWidth(21, context),
            ),
          ),
          SizedBox(width: getProportionateScreenWidth(10, context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sample.title,
                  style: TextStyle(
                    color: MyColors.brown3,
                    fontSize: getProportionateScreenWidth(13.5, context),
                    fontWeight: FontWeight.bold,
                    height: 1.18,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(4, context)),
                Text(
                  sample.subtitle,
                  style: TextStyle(
                    color: MyColors.brown3.withOpacity(0.68),
                    fontSize: getProportionateScreenWidth(12.5, context),
                    height: 1.26,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(7, context)),
                Row(
                  children: [
                    Text(
                      sample.price,
                      style: TextStyle(
                        color: color,
                        fontSize: getProportionateScreenWidth(13.5, context),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: getProportionateScreenWidth(10, context)),
                    Expanded(
                      child: Text(
                        sample.location,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: MyColors.brown3.withOpacity(0.58),
                          fontSize: getProportionateScreenWidth(12, context),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PromotionDetailsPage extends StatelessWidget {
  const PromotionDetailsPage({
    super.key,
    required this.promotion,
  });

  final Promotion promotion;

  void _openSample(BuildContext context, PromotionSample sample) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PromotionSampleDetailsPage(
          promotion: promotion,
          sample: sample,
        ),
      ),
    );
  }

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
                'Promotion samples',
                style: TextStyle(
                  color: MyColors.brown3,
                  fontSize: getProportionateScreenWidth(18, context),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(10, context)),
              ...promotion.samples.map(
                (sample) => Padding(
                  padding: EdgeInsets.only(
                    bottom: getProportionateScreenHeight(10, context),
                  ),
                  child: _PromotionSampleCard(
                    sample: sample,
                    color: promotion.accentColor,
                    onTap: () => _openSample(context, sample),
                  ),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(8, context)),
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

class _PromotionSampleCard extends StatelessWidget {
  const _PromotionSampleCard({
    required this.sample,
    required this.color,
    required this.onTap,
  });

  final PromotionSample sample;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(getProportionateScreenWidth(14, context)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color.withOpacity(0.18)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.18),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: getProportionateScreenWidth(42, context),
              width: getProportionateScreenWidth(42, context),
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.shopping_bag_outlined,
                color: color,
                size: getProportionateScreenWidth(22, context),
              ),
            ),
            SizedBox(width: getProportionateScreenWidth(12, context)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sample.title,
                    style: TextStyle(
                      color: MyColors.brown3,
                      fontSize: getProportionateScreenWidth(14.5, context),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(4, context)),
                  Text(
                    sample.subtitle,
                    style: TextStyle(
                      color: MyColors.brown3.withOpacity(0.7),
                      fontSize: getProportionateScreenWidth(12.5, context),
                      height: 1.25,
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(8, context)),
                  Row(
                    children: [
                      Text(
                        sample.price,
                        style: TextStyle(
                          color: color,
                          fontSize: getProportionateScreenWidth(13.5, context),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: getProportionateScreenWidth(10, context)),
                      Expanded(
                        child: Text(
                          sample.location,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: MyColors.brown3.withOpacity(0.58),
                            fontSize: getProportionateScreenWidth(12, context),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: getProportionateScreenWidth(6, context)),
            Icon(
              Icons.chevron_right,
              color: color,
              size: getProportionateScreenWidth(22, context),
            ),
          ],
        ),
      ),
    );
  }
}

class PromotionSampleDetailsPage extends StatelessWidget {
  const PromotionSampleDetailsPage({
    super.key,
    required this.promotion,
    required this.sample,
  });

  final Promotion promotion;
  final PromotionSample sample;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: MyColors.blue3,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(sample.title),
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
                      sample.owner,
                      style: TextStyle(
                        color: promotion.accentColor,
                        fontSize: getProportionateScreenWidth(13, context),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(8, context)),
                    Text(
                      sample.title,
                      style: TextStyle(
                        color: MyColors.brown3,
                        fontSize: getProportionateScreenWidth(22, context),
                        fontWeight: FontWeight.bold,
                        height: 1.15,
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(10, context)),
                    Text(
                      sample.subtitle,
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
                icon: Icons.sell_outlined,
                label: 'Price',
                value: sample.price,
                color: promotion.accentColor,
              ),
              SizedBox(height: getProportionateScreenHeight(10, context)),
              _PromotionInfoRow(
                icon: Icons.category_outlined,
                label: 'Category',
                value: sample.category,
                color: promotion.accentColor,
              ),
              SizedBox(height: getProportionateScreenHeight(10, context)),
              _PromotionInfoRow(
                icon: Icons.verified_outlined,
                label: 'Condition',
                value: sample.condition,
                color: promotion.accentColor,
              ),
              SizedBox(height: getProportionateScreenHeight(10, context)),
              _PromotionInfoRow(
                icon: Icons.location_on_outlined,
                label: 'Location',
                value: sample.location,
                color: promotion.accentColor,
              ),
              SizedBox(height: getProportionateScreenHeight(10, context)),
              _PromotionInfoRow(
                icon: Icons.phone_outlined,
                label: 'Contact',
                value: sample.contact,
                color: promotion.accentColor,
              ),
              SizedBox(height: getProportionateScreenHeight(18, context)),
              Text(
                'Sample details',
                style: TextStyle(
                  color: MyColors.brown3,
                  fontSize: getProportionateScreenWidth(18, context),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(10, context)),
              ...sample.details.map(
                (detail) => Padding(
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
                          detail,
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
              SizedBox(height: getProportionateScreenHeight(10, context)),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: promotion.accentColor,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      vertical: getProportionateScreenHeight(13, context),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    sample.actionLabel,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(14, context),
                      fontWeight: FontWeight.bold,
                    ),
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
