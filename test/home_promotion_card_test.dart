import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maraka/models/promotion_flyer.dart';
import 'package:maraka/pages/home/promotions_real.dart';

void main() {
  testWidgets('HomePromotionCard shows flyer title and expiry label', (tester) async {
    final flyer = PromotionFlyer(
      id: 1,
      type: 'promotion',
      title: 'Weekend Deals',
      promotionType: 'discount',
      link: 'https://example.com',
      imageUrl: 'https://example.com/banner.png',
      splashscreen: false,
      home: true,
      owner: 'Maraka Store',
      expireDate: DateTime.now().add(const Duration(days: 5)),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HomePromotionCard(
            flyer: flyer,
            onTap: () {},
            onClose: () {},
          ),
        ),
      ),
    );

    expect(find.text('Weekend Deals'), findsOneWidget);
    expect(find.text('Maraka Store'), findsOneWidget);
    expect(find.textContaining('days left'), findsOneWidget);
  });
}
