// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:maraka/logic/email.dart';
import 'package:maraka/logic/user_logic.dart';

void main() {
  // test("send email from flutter vir django", () async {
  //   final res = await sendOTP("davertzshelile@gmail.com", "1212");
  //   expect(res.statusCode, 200);
  // });
  test("user registration", () async {
    User user = User(
        name: "test user",
        email: 'email@email.com',
        phone1: 1212,
        password: "Password@1");
    final res = await user.register();
    expect(res.statusCode, 201);
  });
}
