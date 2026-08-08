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

  testWidgets('Home page shows featured ads section', (tester) async {
    Get.put(StoreController(), permanent: true);
    Get.put(User(), permanent: true);

    await tester.pumpWidget(const MaterialApp(home: HomePage()));
    await tester.pumpAndSettle();

    expect(find.text('Feature Ads'), findsOneWidget);
  });

  testWidgets('Created home promotion appears on the top banner', (tester) async {
    Get.put(StoreController(), permanent: true);
    Get.put(User(), permanent: true);

    await PromotionManagementService.createPromotion(
      image: File('test/assets/test_image.png'),
      title: 'Spring Launch',
      promotionType: 'discount',
      link: 'https://example.com',
      expireDate: DateTime.now().add(const Duration(days: 3)),
      home: true,
      splashscreen: false,
      owner: 'Test Shop',
    );

    await tester.pumpWidget(const MaterialApp(home: HomePage()));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    expect(find.text('Test Shop'), findsOneWidget);
    expect(find.text('Spring Launch'), findsOneWidget);
  });
}
