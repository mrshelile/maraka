import 'package:flutter_test/flutter_test.dart';
import 'package:maraka/logic/user_logic.dart';

void main() {
  test('buildLoginPayload sends both username and email fields for compatibility', () {
    final payload = buildLoginPayload('thabo@maraka.co.ls', 'Lekoba@1');

    expect(payload['username'], 'thabo@maraka.co.ls');
    expect(payload['email'], 'thabo@maraka.co.ls');
    expect(payload['password'], 'Lekoba@1');
  });
}
