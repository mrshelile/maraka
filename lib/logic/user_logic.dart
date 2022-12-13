import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:maraka/logic/constants.dart';
import 'package:maraka/logic/email.dart';
import 'package:otp/otp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  bool canUpdatePassword = false;
  String? name;
  String? email = '';
  late int? phone1;
  late int? phone2;
  String? password = '';
  DateTime? subscription;
  var otp;
  int id = 0;
  // bool isValidatedAcc = false;
  // ignore: non_constant_identifier_names
  bool is_confirmed = false;
  // ignore: non_constant_identifier_names
  bool is_blocked = false;
  // ignore: prefer_typing_uninitialized_variables
  var jwt;
  // ignore: prefer_typing_uninitialized_variables
  var response;

  final _login = "/auth/login/";
  final _register = "/auth_user";
  final _userUrl = "/list_users";
  final _userPasswordReset = "/reset-password";
  final _updatePasswordUrl = "/update-password";
  User(
      {this.name,
      this.email,
      this.phone1,
      this.phone2,
      this.password,
      this.jwt});
  Future removeAll() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    email = null;
    jwt = null;
  }

  Future retrieveToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString('jwt');

    jsonEncode(value).toString().isEmpty ||
            // ignore: unrelated_type_equality_checks
            jsonEncode(value) == 0 ||
            jwt == null
        ? jwt = null
        : jwt = jsonEncode(value);
    return prefs;
  }

  Future _storeOTP(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('otp', value);
  }

  Future _retrieveOTP(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString('otp');

    jsonEncode(value).toString().isEmpty ||
            // ignore: unrelated_type_equality_checks
            jsonEncode(value) == 0 ||
            otp == null
        ? otp = null
        : otp = jsonEncode(value);
    return prefs;
  }

  Future _storeToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt', value);
  }

  Future removeToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("jwt").whenComplete(() => jwt = null);
  }

  Future _storeEmail(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', value);
  }

  Future removeEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("email").whenComplete(() => jwt = null);
  }

  Future retrieveEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString('email');

    jsonEncode(value).toString().isEmpty ||
            // ignore: unrelated_type_equality_checks
            jsonEncode(value) == 0 ||
            email == null
        ? email = null
        : email = jsonEncode(value);
    return prefs;
  }

  Future<bool> isServerAvailable() async {
    response = await http.post(Uri.parse(_login));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future updateDetails() async {
    Map data = {'phone1': phone1, 'phone2': phone2};
    response = await http.put(Uri.parse("$server$_userUrl$id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
        encoding: Encoding.getByName("utf-8"));
    return response;
  }

  Future login() async {
    Map data = {'username': email, 'password': password};

    response = await http.post(Uri.parse(server + _login),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      // isValidatedAcc = jsonDecode(response.body)['user']['validated'];

      jwt = jsonDecode(response.body)['token'];
      name = jsonDecode(response.body)['user']['full_name'];

      if (jsonDecode(response.body)['user']['phone1'] != null) {
        phone1 = int.parse(jsonDecode(response.body)['user']['phone1']);
      }

      is_blocked = jsonDecode(response.body)['user']['is_active'] ?? false;
      is_confirmed = jsonDecode(response.body)['user']['validated'] ?? false;
      id = jsonDecode(response.body)['user']['id'];
      password = null;
      await _storeToken(jwt);
      await _storeEmail(email.toString());
    }
    return response;
    //  if(response.staus)
    //
  }

  Future resetPassword() async {
    canUpdatePassword = false;
    otp = OTP.generateTOTPCodeString(
        'JBSWY3DPEHPK3PXP', DateTime.now().millisecondsSinceEpoch);
    var data = {"email": email, "otp": otp};
    response = await http.put(Uri.parse(server + _userPasswordReset),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      var res = await sendOTP(email, otp);
      if (res.statusCode == 200) {
        canUpdatePassword = true;
        return res;
      }
    }
    return http.Response("internal error", 500);
  }

  // ignore: non_constant_identifier_names
  Future updatePassword(Newpassword, int OTP, email) async {
    var data = {
      "password": Newpassword.toString(),
      "email": email,
    };
    var respose = await http.put(Uri.parse(server + _updatePasswordUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
        encoding: Encoding.getByName("utf-8"));
    return respose;
  }

  Future register() async {
    otp = OTP.generateTOTPCodeString(
        'JBSWY3DPEHPK3PXP', DateTime.now().millisecondsSinceEpoch);

    Map data = {
      'email': email,
      "username": email,
      "phone1": phone1.toString(),
      "phone2": phone2.toString(),
      "otp": otp,
      "full_name": name,
      "validated": false,
      "is_active": true,
      "is_superuser": false,
      'password': password
    };

    response = await http.post(Uri.parse(server + _register),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
        encoding: Encoding.getByName("utf-8"));
    password = null;
    if (response.statusCode == 201 || response.statusCode==200) {
      await _storeEmail(email!).then((value) async => await sendOTP(email, otp)
          .then((value) async => await _storeOTP(otp)));
    }
    return response;
  }
}
