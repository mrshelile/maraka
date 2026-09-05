import 'dart:async';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:maraka/logic/user_logic.dart';
import 'package:maraka/service/promotion_flyer_service.dart';
import 'package:maraka/models/promotion_flyer.dart';
import 'package:maraka/themes/background.dart';
import 'package:maraka/screens/home.dart';
import 'package:maraka/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
                      future: _bannerFuture,
                      builder: (context, AsyncSnapshot<String> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SpinKitThreeInOut(
                            color: Color.fromARGB(255, 12, 131, 125),
                          );
                        } else if (snapshot.hasError) {
                          return const SizedBox();
                        } else if (_promotionClosed || _splashFlyers.isEmpty) {
                          return const SizedBox.shrink();
                        } else {
                          return _SplashPromotionViewer(
                            flyers: _splashFlyers,
                            controller: _promotionController,
                            currentPage: _promotionPage,
                            onPageChanged: (page) =>
                                setState(() => _promotionPage = page),
                            onClose: _closePromotion,
                            onTap: _openPromotion,
                          );
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

class _SplashPromotionViewer extends StatelessWidget {
  const _SplashPromotionViewer({
    required this.flyers,
    required this.controller,
    required this.currentPage,
    required this.onPageChanged,
    required this.onClose,
    required this.onTap,
  });

  final List<PromotionFlyer> flyers;
  final PageController controller;
  final int currentPage;
  final ValueChanged<int> onPageChanged;
  final VoidCallback onClose;
  final ValueChanged<PromotionFlyer> onTap;

  @override
  Widget build(BuildContext context) {
    final imageHeight = MediaQuery.of(context).size.height * 0.35;

    return Column(
      children: [
        SizedBox(
          height: imageHeight,
          child: Stack(
            children: [
              PageView.builder(
                controller: controller,
                itemCount: flyers.length,
                onPageChanged: onPageChanged,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => onTap(flyers[index]),
                  child: CachedNetworkImage(
                    width: double.infinity,
                    imageUrl: flyers[index].imageUrl,
                    fit: BoxFit.contain,
                    placeholder: (context, url) => const SpinKitThreeInOut(
                      color: Color.fromARGB(255, 12, 131, 125),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Material(
                  color: Colors.white.withOpacity(0.94),
                  borderRadius: BorderRadius.circular(24),
                  child: InkWell(
                    onTap: onClose,
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
        ),
        if (flyers.length > 1)
          _SplashPromotionPageControls(
            currentPage: currentPage,
            pageCount: flyers.length,
            controller: controller,
          ),
      ],
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