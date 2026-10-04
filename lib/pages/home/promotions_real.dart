import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:maraka/models/promotion_flyer.dart';
import 'package:maraka/service/promotion_flyer_service.dart';
import 'package:maraka/widgets/promotion_image_carousel.dart';
import '../../size_config.dart';
import '../../themes/background.dart';
import '../../themes/color.dart';

class PromotionAssetImage extends StatelessWidget {
  const PromotionAssetImage({super.key, required this.assetPath});

  final String assetPath;

  @override
  Widget build(BuildContext context) {
    if (assetPath.toLowerCase().endsWith('.svg')) {
      return SvgPicture.asset(
        assetPath,
        fit: BoxFit.cover,
      );
    }

    return Image.asset(
      assetPath,
      fit: BoxFit.cover,
    );
  }
}

/// Real-time promotion flyers fetched from Django backend API
/// Shows actual promotions managed by admins instead of mock data

class RealPromotionsBanner extends StatefulWidget {
  const RealPromotionsBanner({super.key});

  @override
  State<RealPromotionsBanner> createState() => _RealPromotionsBannerState();
}

class _RealPromotionsBannerState extends State<RealPromotionsBanner>
    with WidgetsBindingObserver {
  bool _isClosed = false;
  late Future<List<PromotionFlyer>> _flyersFuture;
  StreamSubscription<void>? _promotionSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _flyersFuture = PromotionFlyerService.fetchHomePageFlyers();
    _promotionSubscription =
        PromotionFlyerService.promotionUpdates.listen((_) => _refreshFlyers());
  }

  @override
  void dispose() {
    _promotionSubscription?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _refreshFlyers();
    }
  }

  void _refreshFlyers() {
    setState(() {
      _flyersFuture =
          PromotionFlyerService.fetchHomePageFlyers(forceRefresh: true);
    });
  }

  void _closeBanner() {
    setState(() {
      _isClosed = true;
    });
  }

  void _openPromotion(PromotionFlyer flyer) {
    showPromotionDetailsDialog(context, flyer);
  }

  Widget _buildFallbackBanner(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(
        getProportionateScreenWidth(14, context),
        getProportionateScreenHeight(8, context),
        getProportionateScreenWidth(14, context),
        0,
      ),
      height: getProportionateScreenHeight(132, context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [MyColors.blue3.withOpacity(0.9), MyColors.mintcream],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
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
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: const PromotionAssetImage(assetPath: 'assets/sale.svg'),
            ),
          ),
          Positioned(
            left: getProportionateScreenWidth(16, context),
            bottom: getProportionateScreenHeight(16, context),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(10, context),
                vertical: getProportionateScreenHeight(6, context),
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Explore fresh deals',
                style: TextStyle(
                  color: MyColors.brown3,
                  fontWeight: FontWeight.bold,
                  fontSize: getProportionateScreenWidth(12, context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isClosed) {
      return const SizedBox.shrink();
    }

    return FutureBuilder<List<PromotionFlyer>>(
      future: _flyersFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            margin: EdgeInsets.fromLTRB(
              getProportionateScreenWidth(14, context),
              getProportionateScreenHeight(8, context),
              getProportionateScreenWidth(14, context),
              0,
            ),
            height: getProportionateScreenHeight(132, context),
            decoration: BoxDecoration(
              color: MyColors.mintcream,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Center(
              child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  color: MyColors.blue3,
                  strokeWidth: 2,
                ),
              ),
            ),
          );
        }

        if (snapshot.hasError) {
          debugPrint('Error loading promotions: ${snapshot.error}');
          return _buildFallbackBanner(context);
        }

        final flyers = snapshot.data ?? [];
        if (flyers.isEmpty) {
          return _buildFallbackBanner(context);
        }

        return Container(
          margin: EdgeInsets.fromLTRB(
            getProportionateScreenWidth(14, context),
            getProportionateScreenHeight(8, context),
            getProportionateScreenWidth(14, context),
            0,
          ),
          child: _PromotionCarousel(
            flyers: flyers,
            onClose: _closeBanner,
            onTap: _openPromotion,
          ),
        );
      },
    );
  }
}

class _PromotionCarousel extends StatefulWidget {
  const _PromotionCarousel({
    required this.flyers,
    required this.onClose,
    required this.onTap,
  });

  final List<PromotionFlyer> flyers;
  final VoidCallback onClose;
  final Function(PromotionFlyer) onTap;

  @override
  State<_PromotionCarousel> createState() => _PromotionCarouselState();
}

class _PromotionCarouselState extends State<_PromotionCarousel> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: getProportionateScreenHeight(132, context),
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            children: widget.flyers
                .map(
                  (flyer) => _RealPromotionCard(
                    flyer: flyer,
                    onClose: widget.onClose,
                    onTap: () => widget.onTap(flyer),
                  ),
                )
                .toList(),
          ),
        ),
        if (widget.flyers.length > 1)
          _PromotionPageControls(
            currentPage: _currentPage,
            pageCount: widget.flyers.length,
            controller: _pageController,
          ),
      ],
    );
  }
}

class _PromotionPageControls extends StatelessWidget {
  const _PromotionPageControls({
    required this.currentPage,
    required this.pageCount,
    required this.controller,
  });

  final int currentPage;
  final int pageCount;
  final PageController controller;

  void _goToPage(int page) {
    if (page < 0 || page >= pageCount) return;
    controller.animateToPage(
      page,
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: getProportionateScreenHeight(8, context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _PromotionNavButton(
            icon: Icons.chevron_left_rounded,
            enabled: currentPage > 0,
            onPressed: () => _goToPage(currentPage - 1),
          ),
          SizedBox(width: getProportionateScreenWidth(8, context)),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20, context),
              vertical: getProportionateScreenHeight(9, context),
            ),
            decoration: BoxDecoration(
              border: Border.all(color: MyColors.brown3.withOpacity(0.22)),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Page ${currentPage + 1}',
                  style: TextStyle(
                    color: MyColors.brown3,
                    fontSize: getProportionateScreenWidth(13, context),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: getProportionateScreenWidth(12, context)),
                Icon(Icons.keyboard_arrow_down_rounded,
                    color: MyColors.brown3, size: 20),
              ],
            ),
          ),
          SizedBox(width: getProportionateScreenWidth(8, context)),
          _PromotionNavButton(
            icon: Icons.chevron_right_rounded,
            enabled: currentPage < pageCount - 1,
            onPressed: () => _goToPage(currentPage + 1),
          ),
        ],
      ),
    );
  }
}

class _PromotionNavButton extends StatelessWidget {
  const _PromotionNavButton({
    required this.icon,
    required this.enabled,
    required this.onPressed,
  });

  final IconData icon;
  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: enabled ? 'Change promotion page' : 'No more promotion pages',
      onPressed: enabled ? onPressed : null,
      icon: Icon(icon, size: 28),
      color: MyColors.brown3,
      disabledColor: MyColors.brown3.withOpacity(0.25),
      style: IconButton.styleFrom(
        side: BorderSide(color: MyColors.brown3.withOpacity(0.18)),
        shape: const CircleBorder(),
      ),
    );
  }
}

class HomePromotionCard extends StatelessWidget {
  const HomePromotionCard({
    super.key,
    required this.flyer,
    required this.onClose,
    required this.onTap,
  });

  final PromotionFlyer flyer;
  final VoidCallback onClose;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final title = flyer.owner.isNotEmpty ? flyer.owner : flyer.title;
    final subtitle = flyer.title.isNotEmpty && flyer.title != title
        ? flyer.title
        : 'Special offer from Maraka';
    final expiryLabel = flyer.daysUntilExpiry > 0
        ? '${flyer.daysUntilExpiry} days left'
        : 'Expires soon';

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(2, context),
      ),
      child: Card(
        elevation: 7,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: PromotionImageCarousel(
                        imageUrls: flyer.imageUrls,
                        fit: BoxFit.cover,
                        indicatorColor: Colors.white,
                      ),
                    ),
                    Positioned(
                      left: getProportionateScreenWidth(10, context),
                      top: getProportionateScreenWidth(10, context),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(8, context),
                          vertical: getProportionateScreenHeight(4, context),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          'Live offer',
                          style: TextStyle(
                            color: MyColors.brown3,
                            fontSize: getProportionateScreenWidth(10, context),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: getProportionateScreenWidth(8, context),
                      top: getProportionateScreenWidth(8, context),
                      child: IconButton(
                        constraints: BoxConstraints.tightFor(
                          height: getProportionateScreenWidth(34, context),
                          width: getProportionateScreenWidth(34, context),
                        ),
                        padding: EdgeInsets.zero,
                        tooltip: 'Close promotions',
                        onPressed: onClose,
                        icon: Icon(
                          Icons.close_rounded,
                          color: Colors.white.withOpacity(0.92),
                          size: getProportionateScreenWidth(18, context),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: EdgeInsets.all(
                            getProportionateScreenWidth(12, context)),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.75),
                            ],
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    getProportionateScreenWidth(13, context),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                                height:
                                    getProportionateScreenHeight(4, context)),
                            Text(
                              subtitle,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize:
                                    getProportionateScreenWidth(11, context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  getProportionateScreenWidth(12, context),
                  getProportionateScreenHeight(10, context),
                  getProportionateScreenWidth(12, context),
                  getProportionateScreenHeight(12, context),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_month_outlined,
                      color: MyColors.blue3,
                      size: getProportionateScreenWidth(15, context),
                    ),
                    SizedBox(width: getProportionateScreenWidth(6, context)),
                    Expanded(
                      child: Text(
                        expiryLabel,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: MyColors.brown3,
                          fontSize: getProportionateScreenWidth(11, context),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: getProportionateScreenWidth(8, context)),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(10, context),
                        vertical: getProportionateScreenHeight(5, context),
                      ),
                      decoration: BoxDecoration(
                        color: MyColors.blue3.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Open',
                            style: TextStyle(
                              color: MyColors.blue3,
                              fontSize:
                                  getProportionateScreenWidth(11, context),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                              width: getProportionateScreenWidth(4, context)),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: getProportionateScreenWidth(11, context),
                            color: MyColors.blue3,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RealPromotionCard extends StatelessWidget {
  const _RealPromotionCard({
    required this.flyer,
    required this.onClose,
    required this.onTap,
  });

  final PromotionFlyer flyer;
  final VoidCallback onClose;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return HomePromotionCard(
      flyer: flyer,
      onClose: onClose,
      onTap: onTap,
    );
  }
}

class RealPromotionsPage extends StatefulWidget {
  const RealPromotionsPage({super.key});

  @override
  State<RealPromotionsPage> createState() => _RealPromotionsPageState();
}

class _RealPromotionsPageState extends State<RealPromotionsPage>
    with WidgetsBindingObserver {
  late Future<List<PromotionFlyer>> _flyersFuture;
  bool _isGridView = false;
  StreamSubscription<void>? _promotionSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadFlyers();
    _promotionSubscription =
        PromotionFlyerService.promotionUpdates.listen((_) => _loadFlyers());
  }

  @override
  void dispose() {
    _promotionSubscription?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _loadFlyers();
    }
  }

  void _loadFlyers() {
    _flyersFuture =
        PromotionFlyerService.fetchPromotionFlyers(forceRefresh: true);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(painter: BackgroundDesign(), child: Container()),
        SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              PromotionFlyerService.clearCache();
              _loadFlyers();
            },
            child: FutureBuilder<List<PromotionFlyer>>(
              future: _flyersFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: MyColors.blue3),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(
                        getProportionateScreenWidth(24, context),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 48,
                            color: Colors.red.withOpacity(0.6),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(16, context),
                          ),
                          Text(
                            'Error Loading Promotions',
                            style: TextStyle(
                              color: MyColors.brown3,
                              fontSize: getProportionateScreenWidth(
                                18,
                                context,
                              ),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(12, context),
                          ),
                          Text(
                            snapshot.error.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: MyColors.brown3.withOpacity(0.7),
                              fontSize: getProportionateScreenWidth(
                                14,
                                context,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(20, context),
                          ),
                          ElevatedButton.icon(
                            onPressed: _loadFlyers,
                            icon: const Icon(Icons.refresh),
                            label: const Text('Retry'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyColors.blue3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final flyers = snapshot.data ?? [];
                if (flyers.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.local_offer_outlined,
                          size: 48,
                          color: MyColors.blue3.withOpacity(0.6),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(16, context),
                        ),
                        Text(
                          'No Active Promotions',
                          style: TextStyle(
                            color: MyColors.brown3,
                            fontSize: getProportionateScreenWidth(18, context),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(12, context),
                        ),
                        Text(
                          'Check back soon for new offers!',
                          style: TextStyle(
                            color: MyColors.brown3.withOpacity(0.7),
                            fontSize: getProportionateScreenWidth(14, context),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                final groupedFlyers = <String, List<PromotionFlyer>>{
                  'Weekend Deals': <PromotionFlyer>[],
                  'Hot Offers': <PromotionFlyer>[],
                  'Black Friday Specials': <PromotionFlyer>[],
                  'Mother\'s Day Season': <PromotionFlyer>[],
                  'Fresh Arrivals': <PromotionFlyer>[],
                };

                for (final flyer in flyers) {
                  final normalizedTitle = flyer.title.toLowerCase();
                  final normalizedOwner = flyer.owner.toLowerCase();
                  final haystack = '$normalizedTitle $normalizedOwner';

                  if (haystack.contains('weekend') ||
                      haystack.contains('deal')) {
                    groupedFlyers['Weekend Deals']!.add(flyer);
                  } else if (haystack.contains('black friday') ||
                      haystack.contains('blackfriday')) {
                    groupedFlyers['Black Friday Specials']!.add(flyer);
                  } else if (haystack.contains('mother') ||
                      haystack.contains('mothers') ||
                      haystack.contains('holiday')) {
                    groupedFlyers['Mother\'s Day Season']!.add(flyer);
                  } else if (haystack.contains('fresh') ||
                      haystack.contains('arrival') ||
                      haystack.contains('new')) {
                    groupedFlyers['Fresh Arrivals']!.add(flyer);
                  } else {
                    groupedFlyers['Hot Offers']!.add(flyer);
                  }
                }

                final sections = groupedFlyers.entries
                    .where((entry) => entry.value.isNotEmpty)
                    .toList();

                return ListView(
                  padding: EdgeInsets.fromLTRB(
                    getProportionateScreenWidth(14, context),
                    getProportionateScreenHeight(16, context),
                    getProportionateScreenWidth(14, context),
                    getProportionateScreenHeight(24, context),
                  ),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'View',
                          style: TextStyle(
                            color: MyColors.brown3.withOpacity(0.8),
                            fontSize: getProportionateScreenWidth(12, context),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                            width: getProportionateScreenWidth(6, context)),
                        IconButton(
                          tooltip: 'Grid view',
                          onPressed: () => setState(() => _isGridView = true),
                          icon: Icon(
                            Icons.grid_view_rounded,
                            color: _isGridView
                                ? MyColors.blue3
                                : MyColors.brown3.withOpacity(0.5),
                          ),
                        ),
                        IconButton(
                          tooltip: 'List view',
                          onPressed: () => setState(() => _isGridView = false),
                          icon: Icon(
                            Icons.view_list_rounded,
                            color: _isGridView
                                ? MyColors.brown3.withOpacity(0.5)
                                : MyColors.blue3,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: getProportionateScreenHeight(6, context)),
                    for (final entry in sections) ...[
                      _PromotionSectionHeader(title: entry.key),
                      SizedBox(
                          height: getProportionateScreenHeight(10, context)),
                      if (_isGridView)
                        GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing:
                              getProportionateScreenWidth(10, context),
                          mainAxisSpacing:
                              getProportionateScreenHeight(10, context),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          childAspectRatio: 0.62,
                          children: [
                            for (final flyer in entry.value)
                              _PromotionGridTile(
                                flyer: flyer,
                                onTap: () =>
                                    showPromotionDetailsDialog(context, flyer),
                              ),
                          ],
                        )
                      else
                        Column(
                          children: [
                            for (final flyer in entry.value)
                              _PromotionListTile(
                                flyer: flyer,
                                onTap: () =>
                                    showPromotionDetailsDialog(context, flyer),
                              ),
                          ],
                        ),
                      SizedBox(
                          height: getProportionateScreenHeight(16, context)),
                    ],
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _PromotionSectionHeader extends StatelessWidget {
  const _PromotionSectionHeader({required this.title});

  final String title;

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
            _sectionIcon(title),
            color: MyColors.blue3,
            size: getProportionateScreenWidth(19, context),
          ),
        ),
        SizedBox(width: getProportionateScreenWidth(10, context)),
        Expanded(
          child: Text(
            title,
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

IconData _sectionIcon(String title) {
  switch (title) {
    case 'Weekend Deals':
    case 'Hot Offers':
      return Icons.local_offer_outlined;
    case 'Black Friday Specials':
      return Icons.discount_outlined;
    case 'Mother\'s Day Season':
      return Icons.celebration_outlined;
    case 'Fresh Arrivals':
      return Icons.auto_awesome_outlined;
    default:
      return Icons.storefront_outlined;
  }
}

class _PromotionListTile extends StatelessWidget {
  const _PromotionListTile({required this.flyer, required this.onTap});

  final PromotionFlyer flyer;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: getProportionateScreenHeight(10, context),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: MyColors.blue3.withOpacity(0.12)),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Container(
                height: getProportionateScreenHeight(260, context),
                width: double.infinity,
                color: Colors.white,
                child: PromotionImageCarousel(
                  imageUrls: flyer.imageUrls,
                  fit: BoxFit.contain,
                  indicatorColor: MyColors.blue3,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(getProportionateScreenWidth(12, context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    flyer.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: MyColors.brown3,
                      fontSize: getProportionateScreenWidth(14, context),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(4, context)),
                  Text(
                    'by ${flyer.owner}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: MyColors.brown3.withOpacity(0.6),
                      fontSize: getProportionateScreenWidth(11, context),
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(6, context)),
                  Text(
                    flyer.daysUntilExpiry > 0
                        ? '${flyer.daysUntilExpiry}d left'
                        : 'Expired',
                    style: TextStyle(
                      color: flyer.daysUntilExpiry <= 2
                          ? Colors.red
                          : MyColors.blue3,
                      fontSize: getProportionateScreenWidth(10, context),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PromotionGridTile extends StatelessWidget {
  const _PromotionGridTile({required this.flyer, required this.onTap});

  final PromotionFlyer flyer;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.mintcream,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Container(
                height: getProportionateScreenHeight(150, context),
                width: double.infinity,
                color: Colors.white,
                child: PromotionImageCarousel(
                  imageUrls: flyer.imageUrls,
                  fit: BoxFit.contain,
                  indicatorColor: MyColors.blue3,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(getProportionateScreenWidth(10, context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    flyer.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: MyColors.brown3,
                      fontSize: getProportionateScreenWidth(13, context),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(4, context)),
                  Text(
                    'by ${flyer.owner}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: MyColors.brown3.withOpacity(0.6),
                      fontSize: getProportionateScreenWidth(10, context),
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(6, context)),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(8, context),
                      vertical: getProportionateScreenHeight(2, context),
                    ),
                    decoration: BoxDecoration(
                      color: flyer.daysUntilExpiry <= 2
                          ? Colors.red.withOpacity(0.1)
                          : MyColors.blue3.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      flyer.daysUntilExpiry > 0
                          ? '${flyer.daysUntilExpiry}d left'
                          : 'Expired',
                      style: TextStyle(
                        color: flyer.daysUntilExpiry <= 2
                            ? Colors.red
                            : MyColors.blue3,
                        fontSize: getProportionateScreenWidth(9, context),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showPromotionDetailsDialog(BuildContext context, PromotionFlyer flyer) {
  showDialog<void>(
    context: context,
    barrierColor: Colors.black.withOpacity(0.62),
    builder: (context) => PromotionDetailsDialog(flyer: flyer),
  );
}

class PromotionDetailsDialog extends StatelessWidget {
  const PromotionDetailsDialog({super.key, required this.flyer});

  final PromotionFlyer flyer;

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
                    SizedBox(
                      height: screenSize.height * 0.7,
                      child: PromotionImageCarousel(
                        imageUrls: flyer.imageUrls,
                        fit: BoxFit.contain,
                        indicatorColor: MyColors.blue3,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(
                        getProportionateScreenWidth(16, context),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            flyer.title,
                            style: TextStyle(
                              color: MyColors.brown3,
                              fontSize: getProportionateScreenWidth(
                                18,
                                context,
                              ),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(8, context),
                          ),
                          Text(
                            'By ${flyer.owner}',
                            style: TextStyle(
                              color: MyColors.brown3.withOpacity(0.7),
                              fontSize: getProportionateScreenWidth(
                                13,
                                context,
                              ),
                            ),
                          ),
                          if (flyer.expireDate != null) ...[
                            SizedBox(
                              height: getProportionateScreenHeight(12, context),
                            ),
                            Container(
                              padding: EdgeInsets.all(
                                getProportionateScreenWidth(10, context),
                              ),
                              decoration: BoxDecoration(
                                color: MyColors.blue3.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    color: MyColors.blue3,
                                    size: getProportionateScreenWidth(
                                      16,
                                      context,
                                    ),
                                  ),
                                  SizedBox(
                                    width: getProportionateScreenWidth(
                                      8,
                                      context,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      flyer.daysUntilExpiry > 0
                                          ? 'Expires in ${flyer.daysUntilExpiry} days'
                                          : 'Promotion has expired',
                                      style: TextStyle(
                                        color: MyColors.brown3,
                                        fontSize: getProportionateScreenWidth(
                                          12,
                                          context,
                                        ),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          if (flyer.link.isNotEmpty) ...[
                            SizedBox(
                              height: getProportionateScreenHeight(16, context),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () => _launchUrl(flyer.link),
                                icon: const Icon(Icons.open_in_browser),
                                label: const Text('Visit Link'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: MyColors.blue3,
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                    vertical: getProportionateScreenHeight(
                                      12,
                                      context,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
                      tooltip: 'Close',
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

  Future<void> _launchUrl(String url) async {
    try {
      if (!url.startsWith('http://') && !url.startsWith('https://')) {
        url = 'https://$url';
      }
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        debugPrint('Could not launch $url');
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }
}
