import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:maraka/service/promotion_flyer_service.dart';
import 'package:maraka/service/promotion_management_service.dart';

void main() {
  setUp(() {
    PromotionFlyerService.clearCache();
    PromotionFlyerService.clearMockPromotions();
  });

  test('creating a mock promotion adds it to home flyers', () async {
    final tempImage = File('${Directory.systemTemp.path}/mock-promo.png');
    await tempImage.writeAsBytes([1, 2, 3, 4]);

    await PromotionManagementService.createPromotion(
      image: tempImage,
      title: 'Mock weekend offer',
      promotionType: 'customizable',
      link: 'https://example.com',
      expireDate: DateTime.now().add(const Duration(days: 7)),
      home: true,
    );

    final flyers = await PromotionFlyerService.fetchHomePageFlyers();

    expect(flyers.any((flyer) => flyer.title == 'Mock weekend offer'), isTrue);
  });
}
