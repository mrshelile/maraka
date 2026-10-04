import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maraka/logic/user_logic.dart';
import 'package:maraka/models/promotion_flyer.dart';
import 'package:maraka/service/promotion_flyer_service.dart';
import 'package:maraka/pages/create_promotion.dart';
import 'package:maraka/pages/home/promotions_real.dart';
import 'package:maraka/themes/background.dart';
import 'package:maraka/themes/color.dart';
import 'package:maraka/widgets/promotion_image_carousel.dart';

class PromotionsDashboardPage extends StatefulWidget {
  const PromotionsDashboardPage({super.key});

  @override
  State<PromotionsDashboardPage> createState() =>
      _PromotionsDashboardPageState();
}

class _PromotionsDashboardPageState extends State<PromotionsDashboardPage>
    with WidgetsBindingObserver {
  final User _owner = Get.find();
  late Future<List<PromotionFlyer>> _promotionsFuture;
  StreamSubscription<void>? _promotionSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadPromotions();
    _promotionSubscription =
        PromotionFlyerService.promotionUpdates.listen((_) => _loadPromotions());
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
      _loadPromotions();
    }
  }

  void _loadPromotions() {
    final ownerId = _owner.name ?? _owner.email ?? '';
    _promotionsFuture = PromotionFlyerService.fetchFlyersByOwner(
      ownerId,
      forceRefresh: true,
    );
    setState(() {});
  }

  Future<void> _refreshPromotions() async {
    PromotionFlyerService.clearCache();
    _loadPromotions();
  }

  Widget _buildSummaryCard(
    String label,
    String value,
    IconData icon,
    Color iconColor,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: iconColor, size: 26),
            const SizedBox(height: 12),
            Text(
              label,
              style: TextStyle(
                color: MyColors.brown3.withOpacity(0.8),
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                color: MyColors.brown3,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final displayName = _owner.name ?? _owner.email ?? 'Your';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Promotions dashboard'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: MyColors.brown3,
      ),
      body: Stack(
        children: [
          CustomPaint(painter: BackgroundDesign(), child: Container()),
          SafeArea(
            child: RefreshIndicator(
              onRefresh: _refreshPromotions,
              child: FutureBuilder<List<PromotionFlyer>>(
                future: _promotionsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 52,
                              color: MyColors.blue3.withOpacity(0.75),
                            ),
                            const SizedBox(height: 18),
                            const Text(
                              'Could not load promotions',
                              style: TextStyle(
                                color: MyColors.brown3,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              snapshot.error.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: MyColors.brown3.withOpacity(0.72),
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton.icon(
                              onPressed: _loadPromotions,
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

                  final promotions = snapshot.data ?? <PromotionFlyer>[];
                  final activeCount = promotions.length;
                  final homeCount = promotions.where((p) => p.home).length;
                  final expiringCount = promotions
                      .where((p) =>
                          p.daysUntilExpiry > 0 && p.daysUntilExpiry <= 3)
                      .length;

                  return ListView(
                    padding: const EdgeInsets.fromLTRB(18, 12, 18, 24),
                    children: [
                      Text(
                        '$displayName promotions',
                        style: const TextStyle(
                          color: MyColors.brown3,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Track all active promotions and create new ones here.',
                        style: TextStyle(
                          color: MyColors.brown3.withOpacity(0.72),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          _buildSummaryCard('Active', '$activeCount',
                              Icons.local_offer_outlined, MyColors.blue3),
                          const SizedBox(width: 12),
                          _buildSummaryCard('Home', '$homeCount',
                              Icons.home_outlined, MyColors.green3),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildSummaryCard('Expiring soon', '$expiringCount',
                          Icons.schedule_outlined, MyColors.gold),
                      const SizedBox(height: 24),
                      if (promotions.isEmpty) ...[
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 12,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'No active promotions yet',
                                style: TextStyle(
                                  color: MyColors.brown3,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Create your first promotion and it will appear here immediately.',
                                style: TextStyle(
                                  color: MyColors.brown3.withOpacity(0.7),
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 18),
                              FilledButton.icon(
                                onPressed: () async {
                                  await Get.to(
                                      () => const CreatePromotionPage());
                                  _loadPromotions();
                                },
                                icon: const Icon(Icons.add),
                                label: const Text('Create promotion'),
                                style: FilledButton.styleFrom(
                                  backgroundColor: MyColors.blue3,
                                  foregroundColor: Colors.white,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ] else ...[
                        for (final flyer in promotions)
                          _PromotionDashboardTile(
                            flyer: flyer,
                            onTap: () =>
                                showPromotionDetailsDialog(context, flyer),
                          ),
                      ],
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Get.to(() => const CreatePromotionPage());
          _loadPromotions();
        },
        icon: const Icon(Icons.add),
        label: const Text('New promotion'),
        backgroundColor: MyColors.blue3,
      ),
    );
  }
}

class _PromotionDashboardTile extends StatelessWidget {
  const _PromotionDashboardTile({required this.flyer, required this.onTap});

  final PromotionFlyer flyer;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: SizedBox(
            width: 64,
            height: 64,
            child: PromotionImageCarousel(
              imageUrls: flyer.imageUrls,
              fit: BoxFit.cover,
              indicatorColor: Colors.white,
            ),
          ),
        ),
        title: Text(
          flyer.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: MyColors.brown3,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          '${flyer.daysUntilExpiry > 0 ? '${flyer.daysUntilExpiry}d left' : 'Expired'} · ${flyer.home ? 'Home' : 'Hidden'}',
          style: TextStyle(
            color: MyColors.brown3.withOpacity(0.7),
          ),
        ),
        trailing: const Icon(Icons.chevron_right, color: MyColors.blue3),
      ),
    );
  }
}
