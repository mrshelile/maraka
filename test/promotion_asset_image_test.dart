import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maraka/pages/home/promotions_real.dart';

void main() {
  testWidgets('PromotionAssetImage renders svg assets without throwing', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: PromotionAssetImage(assetPath: 'assets/sale.svg'),
        ),
      ),
    );

    await tester.pump();

    expect(tester.takeException(), isNull);
  });
}
