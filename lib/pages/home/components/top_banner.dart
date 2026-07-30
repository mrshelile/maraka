import 'package:flutter/material.dart';
import 'package:maraka/pages/home/promotions_real.dart';

class DiscountBanner extends StatefulWidget {
  const DiscountBanner({
    super.key,
  });

  @override
  State<DiscountBanner> createState() => _DiscountBannerState();
}

class _DiscountBannerState extends State<DiscountBanner> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Display real promotion flyers from Django backend
    // Falls back to static banner if no promotions available
    return RealPromotionsBanner();
  }
}
