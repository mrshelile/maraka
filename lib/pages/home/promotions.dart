import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import 'promotions_real.dart';
import '../../size_config.dart';
import '../../themes/background.dart';
import '../../themes/color.dart';

class Promotion {
  const Promotion({
    required this.title,
    required this.description,
    required this.badge,
    required this.offer,
    required this.promoStartDate,
    required this.promoEndDate,
    required this.validUntil,
    required this.imageAsset,
    required this.flyerStyle,
    required this.section,
    this.uploadedFlyerUrl,
    required this.terms,
    required this.icon,
    required this.backgroundColor,
    required this.accentColor,
  });

  final String title;
  final String description;
  final String badge;
  final String offer;
  final String promoStartDate;
  final String promoEndDate;
  final String validUntil;
  final String imageAsset;
  final PromotionFlyerStyle flyerStyle;
  final PromotionSection section;
  final String? uploadedFlyerUrl;
  final List<String> terms;
  final IconData icon;
  final Color backgroundColor;
  final Color accentColor;

  String get promoDateRange => '$promoStartDate - $promoEndDate';
}

enum PromotionFlyerStyle {
  image,
  cashCrusaders,
  game,
}

enum PromotionSection {
  storeSpecials,
  holidays,
  blackFriday,
}

const List<Promotion> mockPromotions = [
  Promotion(
    title: 'Weekend Deals',
    description: 'Weekend discounts from Cash Crusaders.',
    badge: 'Hot offers',
    offer: 'Sample weekend deals from Cash Crusaders stores.',
    promoStartDate: '26 June 2026',
    promoEndDate: '30 June 2026',
    validUntil: '30 June 2026',
    imageAsset: 'assets/mock_flyers/weekend_deals.webp',
    flyerStyle: PromotionFlyerStyle.image,
    section: PromotionSection.storeSpecials,
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
    title: 'Mother\'s Day Specials',
    description: 'Holiday flyer preview for Mother\'s Day.',
    badge: 'Holiday',
    offer: 'Mother\'s Day promotion preview from the mock flyers folder.',
    promoStartDate: '5 May 2026',
    promoEndDate: '11 May 2026',
    validUntil: 'Mother\'s Day season',
    imageAsset: 'assets/mock_flyers/weekend_deals2.webp',
    flyerStyle: PromotionFlyerStyle.image,
    section: PromotionSection.holidays,
    terms: [
      'Holiday flyer asset from the mock flyers folder.',
    ],
    icon: Icons.local_offer_outlined,
    backgroundColor: MyColors.mintcream,
    accentColor: MyColors.blue3,
  ),
  Promotion(
    title: 'Black Friday Preview',
    description: 'Black Friday flyer preview.',
    badge: 'Black Friday',
    offer: 'Black Friday promotion preview from the mock flyers folder.',
    promoStartDate: '27 November 2026',
    promoEndDate: '30 November 2026',
    validUntil: 'Black Friday season',
    imageAsset: 'assets/mock_flyers/weekend_deals3.webp',
    flyerStyle: PromotionFlyerStyle.image,
    section: PromotionSection.blackFriday,
    terms: [
      'Black Friday flyer asset from the mock flyers folder.',
    ],
    icon: Icons.local_offer_outlined,
    backgroundColor: MyColors.mintcream,
    accentColor: MyColors.blue3,
  ),
  Promotion(
    title: 'Fresh Arrivals',
    description: 'New product examples from Game Stores.',
    badge: 'New today',
    offer: 'Fresh arrivals sample feed from Game Stores.',
    promoStartDate: '1 July 2026',
    promoEndDate: '31 July 2026',
    validUntil: 'Ongoing',
    imageAsset: 'assets/mock_flyers/fresh_arrivals.webp',
    flyerStyle: PromotionFlyerStyle.image,
    section: PromotionSection.storeSpecials,
    terms: [
      'Fresh arrivals are mock examples until store inventory is connected.',
      'Backend will later decide which store products are promoted.',
      'Backend promotion ID placeholder: promo_arrivals_003.',
    ],
    icon: Icons.auto_awesome_outlined,
    backgroundColor: MyColors.mintcream,
    accentColor: MyColors.blue3,
  ),
  Promotion(
    title: 'Fresh Arrivals 2',
    description: 'Additional fresh arrivals flyer preview.',
    badge: 'New today',
    offer:
        'Additional fresh arrivals flyer preview from the mock flyers folder.',
    promoStartDate: '12 July 2026',
    promoEndDate: '31 July 2026',
    validUntil: 'Ongoing',
    imageAsset: 'assets/mock_flyers/fresh_arrivals2.webp',
    flyerStyle: PromotionFlyerStyle.image,
    section: PromotionSection.storeSpecials,
    terms: [
      'Additional flyer asset from the mock flyers folder.',
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
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      onTap: onTap,
                      child: PromotionVisual(
                        promotion: promotion,
                        compact: false,
                      ),
                    ),
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
          SizedBox(height: getProportionateScreenHeight(8, context)),
          _PromotionDateBadge(promotion: promotion),
        ],
      ),
    );
  }
}

class _PromotionDateBadge extends StatelessWidget {
  const _PromotionDateBadge({
    required this.promotion,
  });

  final Promotion promotion;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(8, context),
        vertical: getProportionateScreenHeight(5, context),
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.94),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: promotion.accentColor.withOpacity(0.16)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.calendar_month_outlined,
            color: promotion.accentColor,
            size: getProportionateScreenWidth(14, context),
          ),
          SizedBox(width: getProportionateScreenWidth(5, context)),
          Expanded(
            child: Text(
              promotion.promoDateRange,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: MyColors.brown3,
                fontSize: getProportionateScreenWidth(10.5, context),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
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
    final groupedPromotions = <PromotionSection, List<Promotion>>{
      for (final section in PromotionSection.values)
        section: promotions
            .where((promotion) => promotion.section == section)
            .toList(),
    };
    final visibleSections = PromotionSection.values
        .where((section) => groupedPromotions[section]!.isNotEmpty)
        .toList();

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
              for (final section in visibleSections) ...[
                _PromotionSectionHeader(section: section),
                SizedBox(height: getProportionateScreenHeight(10, context)),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: getProportionateScreenWidth(10, context),
                  mainAxisSpacing: getProportionateScreenHeight(10, context),
                  childAspectRatio: 0.74,
                  children: groupedPromotions[section]!
                      .map(
                        (promotion) => _PromotionCard(
                          promotion: promotion,
                          onTap: () => _openPromotion(context, promotion),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(height: getProportionateScreenHeight(18, context)),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _PromotionSectionHeader extends StatelessWidget {
  const _PromotionSectionHeader({
    required this.section,
  });

  final PromotionSection section;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: getProportionateScreenWidth(34, context),
          width: getProportionateScreenWidth(34, context),
          decoration: BoxDecoration(
            color: MyColors.blue3.withOpacity(0.12),
            borderRadius: BorderRadius.circular(9),
          ),
          child: Icon(
            _promotionSectionIcon(section),
            color: MyColors.blue3,
            size: getProportionateScreenWidth(19, context),
          ),
        ),
        SizedBox(width: getProportionateScreenWidth(10, context)),
        Expanded(
          child: Text(
            _promotionSectionTitle(section),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: MyColors.brown3,
              fontSize: getProportionateScreenWidth(18, context),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

String _promotionSectionTitle(PromotionSection section) {
  switch (section) {
    case PromotionSection.storeSpecials:
      return 'Store Specials';
    case PromotionSection.holidays:
      return 'Holidays';
    case PromotionSection.blackFriday:
      return 'Black Friday';
  }
}

IconData _promotionSectionIcon(PromotionSection section) {
  switch (section) {
    case PromotionSection.storeSpecials:
      return Icons.storefront_outlined;
    case PromotionSection.holidays:
      return Icons.celebration_outlined;
    case PromotionSection.blackFriday:
      return Icons.discount_outlined;
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
            color: Colors.transparent,
            child: Stack(
              children: [
                ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children: [
                    _PromotionDialogImage(promotion: promotion),
                  ],
                ),
                Positioned(
                  left: getProportionateScreenWidth(12, context),
                  right: getProportionateScreenWidth(12, context),
                  bottom: getProportionateScreenHeight(12, context),
                  child: _PromotionDatePanel(promotion: promotion),
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

class _PromotionDatePanel extends StatelessWidget {
  const _PromotionDatePanel({
    required this.promotion,
  });

  final Promotion promotion;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(getProportionateScreenWidth(12, context)),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.16),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          _PromotionDateItem(
            label: 'Starts',
            value: promotion.promoStartDate,
            color: promotion.accentColor,
          ),
          Container(
            height: getProportionateScreenHeight(34, context),
            width: 1,
            margin: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(12, context),
            ),
            color: MyColors.brown3.withOpacity(0.14),
          ),
          _PromotionDateItem(
            label: 'Ends',
            value: promotion.promoEndDate,
            color: promotion.accentColor,
          ),
        ],
      ),
    );
  }
}

class _PromotionDateItem extends StatelessWidget {
  const _PromotionDateItem({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: getProportionateScreenWidth(11, context),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(3, context)),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: MyColors.brown3,
              fontSize: getProportionateScreenWidth(13, context),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
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
    final uploadedFlyerUrl = promotion.uploadedFlyerUrl?.trim();
    final flyerChild = uploadedFlyerUrl != null && uploadedFlyerUrl.isNotEmpty
        ? Image.network(
            uploadedFlyerUrl,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) =>
                _PromotionImageFallback(
              promotion: promotion,
              compact: false,
            ),
          )
        : Image.asset(
            promotion.imageAsset,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) =>
                _PromotionImageFallback(
              promotion: promotion,
              compact: false,
            ),
          );

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: PhotoView.customChild(
        backgroundDecoration: const BoxDecoration(color: Colors.white),
        minScale: 1.0,
        maxScale: 3.0,
        child: SizedBox.expand(
          child: Center(child: flyerChild),
        ),
      ),
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
        return PromotionAssetImage(
          assetPath: promotion.imageAsset,
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
                          const Spacer(),
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
                label: 'Promotion dates',
                value: promotion.promoDateRange,
                color: promotion.accentColor,
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
