import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maraka/widgets/promotion_image_carousel.dart';

void main() {
  testWidgets('promotion image carousel can navigate between images', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 320,
            height: 240,
            child: PromotionImageCarousel(
              imageUrls: [
                'https://example.com/page-1.jpg',
                'https://example.com/page-2.jpg',
              ],
            ),
          ),
        ),
      ),
    );

    expect(find.bySemanticsLabel('Image 1 of 2'), findsOneWidget);

    await tester.drag(find.byType(PageView), const Offset(-260, 0));
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.bySemanticsLabel('Image 2 of 2'), findsOneWidget);
    semantics.dispose();
  });
}
