import 'package:flutter_test/flutter_test.dart';
import 'package:maraka/logic/banner_logic.dart';

void main() {
  group('BannerLogic', () {
    test('uses a direct display URL when provided', () {
      final logic = BannerLogic();
      final resolved = logic.resolveImageUrl({
        'display': 'https://example.com/banner.png',
      });

      expect(resolved, 'https://example.com/banner.png');
    });

    test('falls back to image_url when display is missing', () {
      final logic = BannerLogic();
      final resolved = logic.resolveImageUrl({
        'image_url': 'https://example.com/banner.jpg',
      });

      expect(resolved, 'https://example.com/banner.jpg');
    });
  });
}
