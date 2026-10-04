import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:maraka/service/promotion_flyer_service.dart';
import 'package:maraka/service/promotion_management_service.dart';

void main() {
  setUp(() {
    PromotionFlyerService.clearCache();
    PromotionManagementService.clearMockPromotions();
  });

  test('creating a mock promotion retains all images', () async {
    final tempImage = File('${Directory.systemTemp.path}/mock-promo.png');
    final secondImage = File('${Directory.systemTemp.path}/mock-promo-2.png');
    await tempImage.writeAsBytes([1, 2, 3, 4]);
    await secondImage.writeAsBytes([4, 3, 2, 1]);

    await PromotionManagementService.createPromotion(
      images: [tempImage, secondImage],
      title: 'Mock weekend offer',
      promotionType: 'customizable',
      link: 'https://example.com',
      expireDate: DateTime.now().add(const Duration(days: 7)),
      home: true,
      owner: 'Test Shop',
    );

    final flyer = PromotionManagementService.mockPromotions.singleWhere(
      (flyer) => flyer.title == 'Mock weekend offer',
    );
    expect(flyer.imageUrls, [tempImage.path, secondImage.path]);
  });
}
