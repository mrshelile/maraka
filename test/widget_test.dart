// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:maraka/logic/email.dart';
import 'package:maraka/logic/products_logic.dart';
import 'package:maraka/logic/sendVisitor.dart';
import 'package:maraka/logic/user_logic.dart';
import 'package:maraka/models/product.dart';

void main() {
  // test("send email from flutter vir django", () async {
  //   final res = await sendOTP("davertzshelile@gmail.com", "1212");
  //   expect(res.statusCode, 200);
  // });
  // test("user registration", () async {
  //   User user = User(
  //       name: "test user",
  //       email: 'davertzshelile@gmail.com',
  //       phone1: 1212,
  //       password: "Password@1");
  //   final res = await user.register();
  //   expect(res.statusCode, 201);
  // });
  // test("verify otp by email", () async {
  //   User user = User(
  //       name: "test user",
  //       email: 'davertzshelile@gmail.com',
  //       phone1: 1212,
  //       password: "Password@1");
  //   final res = await verifyOTP(user, 304118);
  //   expect(res.statusCode, 200);
  //   expect(isvalid, true);
  // });
  // test("reset password by also sending otp", () async {
  //   User user = User(email: "test@test.com");
  //   final res = await user.resetPassword();
  //   expect(res.statusCode, 200);
  //   expect(user.canUpdatePassword, true);
  // });
  // test("validate email account", () async {
  //   var res = await validateAcc(User(email: "test@test.com"));
  //   expect(res.statusCode, 200);
  // });
  // testWidgets("registration widget testing", (tester) async {
  //   await tester.pumpWidget(Registration());
  // });
  // test("Update-password by username and email", () async {
  //   User user = User(email: "test@test.com");
  //   var res = await user.updatePassword("Password@5", 55, user.email);
  //   expect(res.statusCode, 200);
  // });
  // test("create product ", () async {
  //   ProductLogic logic = ProductLogic();
  //   var response = await logic.postProduct(
  //       Product(
  //           title: "_nameController.text.trim()",
  //           description: "_descriptionController.text.trim()",
  //           price: 12,
  //           expiryDate: DateTime.now().add(const Duration(days: 31)),
  //           id2: '',
  //           seller: Seller(),
  //           images: [],
  //           imageUrls: [24, 25],
  //           category: "cars"),
  //       14);
  //   expect(response.statusCode, 201);
  // });
  test("test create visitor", () async {
    Visitor visitor = Visitor();
    var res = await visitor.createVisitor();
    expect(res.statusCode, 201);
  });
}
