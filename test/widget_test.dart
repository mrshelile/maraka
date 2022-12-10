// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:maraka/logic/email.dart';

void main() {
  test("send email from flutter vir django", () async {
    final res = await sendOTP("davertzshelile@gmail.com", "1212");
    expect(res.statusCode, 200);
  });
}
