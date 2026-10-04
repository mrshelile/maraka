import 'package:flutter_test/flutter_test.dart';
import 'package:maraka/service/promotion_flyer_service.dart';

void main() {
  group('PromotionFlyerService.parseFlyers', () {
    test('parses a direct list payload', () {
      final flyers = PromotionFlyerService.parseFlyers([
        {
          'id': 1,
          'title': 'Summer sale',
          'promotion_type': 'fresh_arrivals',
          'image_url': 'https://example.com/promo.jpg',
          'splashscreen': true,
          'home': true,
          'owner': 'Maraka',
          'expire_date': '2099-01-01T00:00:00Z',
        }
      ]);

      expect(flyers, hasLength(1));
      expect(flyers.first.title, 'Summer sale');
    });

    test('parses a wrapped results payload', () {
      final flyers = PromotionFlyerService.parseFlyers({
        'results': [
          {
            'id': 2,
            'title': 'Weekend deal',
            'promotion_type': 'monthend_specials',
            'image_url': 'https://example.com/weekend.jpg',
            'splashscreen': false,
            'home': true,
            'owner': 'Shop',
            'expire_date': '2099-01-01T00:00:00Z',
          }
        ]
      });

      expect(flyers, hasLength(1));
      expect(flyers.first.owner, 'Shop');
    });

    test('parses multiple images and keeps legacy image URL compatibility', () {
      final flyers = PromotionFlyerService.parseFlyers([
        {
          'id': 3,
          'title': 'Multi-page sale',
          'images': [
            {'image_url': 'https://example.com/page-1.jpg'},
            {'image_url': 'https://example.com/page-2.jpg'},
          ],
          'image_url': 'https://example.com/page-1.jpg',
          'expire_date': '2099-01-01T00:00:00Z',
        },
      ]);

      expect(flyers, hasLength(1));
      expect(
        flyers.first.imageUrls,
        [
          'https://example.com/page-1.jpg',
          'https://example.com/page-2.jpg',
        ],
      );
      expect(flyers.first.imageUrl, 'https://example.com/page-1.jpg');

      final legacyFlyer = PromotionFlyerService.parseFlyers([
        {
          'id': 4,
          'image_url': 'https://example.com/legacy.jpg',
          'expire_date': '2099-01-01T00:00:00Z',
        },
      ]).single;
      expect(legacyFlyer.imageUrls, ['https://example.com/legacy.jpg']);
    });

    test('returns an empty list for invalid payloads', () {
      final flyers = PromotionFlyerService.parseFlyers({'unexpected': 'shape'});

      expect(flyers, isEmpty);
    });
  });
}
