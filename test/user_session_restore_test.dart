import 'package:flutter_test/flutter_test.dart';
import 'package:maraka/logic/user_logic.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('restoreSession does not authenticate when only an email is persisted', () async {
    SharedPreferences.setMockInitialValues({
      'email': 'hazualityelectronics@gmail.com',
      'jwt': '',
    });

    final user = User();
    await user.restoreSession();

    expect(user.email, isNull);
    expect(user.jwt, isNull);
    expect(user.isAuthenticated, isFalse);
  });
}
