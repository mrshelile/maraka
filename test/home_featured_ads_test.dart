import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:maraka/logic/store.dart';
import 'package:maraka/logic/user_logic.dart';
import 'package:maraka/pages/home/home_page.dart';
import 'package:maraka/service/promotion_flyer_service.dart';
import 'package:maraka/service/promotion_management_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    Get.reset();
    PromotionFlyerService.clearCache();
    PromotionManagementService.clearMockPromotions();
  });

  testWidgets('Home page shows the branded hero', (tester) async {
    Get.put(StoreController(), permanent: true);
    Get.put(User(), permanent: true);

    await tester.pumpWidget(const MaterialApp(home: HomePage()));
    await tester.pumpAndSettle();

    expect(find.textContaining('Shopping made easy'), findsOneWidget);
  });

  testWidgets('Creating a home promotion retains the branded home layout',
      (tester) async {
    Get.put(StoreController(), permanent: true);
    Get.put(User(), permanent: true);

    await PromotionManagementService.createPromotion(
      images: [File('test/assets/test_image.png')],
      title: 'Spring Launch',
      promotionType: 'discount',
      link: 'https://example.com',
      expireDate: DateTime.now().add(const Duration(days: 3)),
      home: true,
      splashscreen: false,
      owner: 'Test Shop',
    );

    final promotion = PromotionManagementService.mockPromotions.single;
    expect(promotion.title, 'Spring Launch');
    expect(promotion.owner, 'Test Shop');
    expect(promotion.home, isTrue);

    await tester.pumpWidget(const MaterialApp(home: HomePage()));
    await tester.pumpAndSettle();

    expect(find.textContaining('Shopping made easy'), findsOneWidget);
  });
}
