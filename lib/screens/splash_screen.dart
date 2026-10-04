import 'dart:async';
import 'dart:ui' as ui;

import 'package:maraka/widgets/compat_loading.dart';
import 'package:get/get.dart';
import 'package:maraka/logic/user_logic.dart';
import 'package:maraka/service/promotion_flyer_service.dart';
import 'package:maraka/models/promotion_flyer.dart';
import 'package:maraka/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:maraka/widgets/promotion_image_carousel.dart';
import '../logic/store.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {
  User user = User();
  final store = Get.find<StoreController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<String> _bannerFuture;
  final PageController _promotionController = PageController();
  final Completer<void> _promotionClosedCompleter = Completer<void>();
  List<PromotionFlyer> _splashFlyers = <PromotionFlyer>[];
  int _promotionPage = 0;
  bool _promotionClosed = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _bannerFuture = makeBanners();
    _initializeApp();
  }

  @override
  void dispose() {
    _promotionController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {
        _bannerFuture = makeBanners();
      });
    }
  }

  Future<void> _initializeApp() async {
    await Future.wait([
      store.loadProducts(),
      _bannerFuture,
    ]);

    if (_splashFlyers.isNotEmpty && !_promotionClosed) {
      await _promotionClosedCompleter.future;
    }

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

  Future<String> makeBanners() async {
    try {
      final flyers = await PromotionFlyerService.fetchSplashScreenFlyers(
          forceRefresh: true);

      if (flyers.isNotEmpty) {
        _splashFlyers = flyers;
      }

      return flyers.isNotEmpty ? 'loaded' : '';
    } catch (e) {
      debugPrint('Error loading splash promotions: $e');
      return '';
    }
  }

  Future<void> _openPromotion(PromotionFlyer flyer) async {
    final link = flyer.link.trim();
    if (link.isEmpty) return;

    final uri = Uri.tryParse(link);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _closePromotion() {
    if (!_promotionClosedCompleter.isCompleted) {
      _promotionClosedCompleter.complete();
    }

    if (mounted) {
      setState(() => _promotionClosed = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    // makeBanners();

    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          Home(currentIndex: 0),
          if (!_promotionClosed)
            Positioned.fill(
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: ColoredBox(color: Colors.black.withOpacity(0.28)),
              ),
            ),
          if (!_promotionClosed)
            Positioned.fill(
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.38,
                  ),
                  child: FutureBuilder<String>(
                    future: _bannerFuture,
                    builder: (context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SpinKitThreeInOut(
                          color: Color.fromARGB(255, 12, 131, 125),
                        );
                      }
                      if (snapshot.hasError || _splashFlyers.isEmpty) {
                        return const SizedBox.shrink();
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: _SplashPromotionViewer(
                          flyers: _splashFlyers,
                          controller: _promotionController,
                          currentPage: _promotionPage,
                          onPageChanged: (page) =>
                              setState(() => _promotionPage = page),
                          onTap: _openPromotion,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          if (!_promotionClosed)
            Positioned(
              top: MediaQuery.of(context).padding.top + 16,
              right: 20,
              child: Material(
                color: Colors.white.withOpacity(0.94),
                borderRadius: BorderRadius.circular(24),
                child: InkWell(
                  onTap: _closePromotion,
                  borderRadius: BorderRadius.circular(24),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 10,
                    ),
                    child: Text(
                      'Close',
                      style: TextStyle(
                        color: Color(0xff313131),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _SplashPromotionViewer extends StatelessWidget {
  const _SplashPromotionViewer({
    required this.flyers,
    required this.controller,
    required this.currentPage,
    required this.onPageChanged,
    required this.onTap,
  });

  final List<PromotionFlyer> flyers;
  final PageController controller;
  final int currentPage;
  final ValueChanged<int> onPageChanged;
  final ValueChanged<PromotionFlyer> onTap;

  @override
  Widget build(BuildContext context) {
    final imageHeight = MediaQuery.of(context).size.height * 0.35;
    final pages = <_SplashFlyerPage>[
      for (final flyer in flyers)
        for (final imageUrl in flyer.imageUrls)
          _SplashFlyerPage(flyer: flyer, imageUrl: imageUrl),
    ];

    return Column(
      children: [
        SizedBox(
          height: imageHeight,
          child: PageView.builder(
            controller: controller,
            itemCount: pages.length,
            onPageChanged: onPageChanged,
            itemBuilder: (context, index) => _SplashPromotionImage(
              page: pages[index],
              onTap: () => onTap(pages[index].flyer),
            ),
          ),
        ),
        if (pages.length > 1)
          _SplashPromotionPageControls(
            currentPage: currentPage,
            pageCount: pages.length,
            controller: controller,
          ),
      ],
    );
  }
}

class _SplashFlyerPage {
  const _SplashFlyerPage({required this.flyer, required this.imageUrl});

  final PromotionFlyer flyer;
  final String imageUrl;
}

class _SplashPromotionImage extends StatelessWidget {
  const _SplashPromotionImage({
    required this.page,
    required this.onTap,
  });

  final _SplashFlyerPage page;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          fit: StackFit.expand,
          children: [
            PromotionImageCarousel(
              imageUrls: <String>[page.imageUrl],
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}

class _SplashPromotionPageControls extends StatelessWidget {
  const _SplashPromotionPageControls({
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
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            tooltip: 'Previous promotion page',
            onPressed: currentPage > 0 ? () => _goToPage(currentPage - 1) : null,
            icon: const Icon(Icons.chevron_left_rounded, size: 28),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black.withOpacity(0.18)),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Page ${currentPage + 1}',
                  style: const TextStyle(
                    color: Color(0xff313131),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 12),
                const Icon(Icons.keyboard_arrow_down_rounded, size: 20),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Next promotion page',
            onPressed: currentPage < pageCount - 1
                ? () => _goToPage(currentPage + 1)
                : null,
            icon: const Icon(Icons.chevron_right_rounded, size: 28),
          ),
        ],
      ),
    );
  }
}