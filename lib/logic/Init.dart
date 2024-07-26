import 'package:shared_preferences/shared_preferences.dart';

class Init {

  static Future initialize() async {
    await _checkToken();
  }
  static Future<String> _checkToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var value =  prefs.getString('jwt') ?? '';
    // this.jwt = jsonEncode(value).toString();
    return value;
  }
}
