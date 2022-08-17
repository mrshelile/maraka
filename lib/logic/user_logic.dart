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

  final _login = "/api/auth/local";
  final _register = "/api/auth/local/register";
  final _userUrl = "/api/users/";
  final _updatePasswordUrl="/api/marakapasswordreset";
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
    var value = await prefs.getString('jwt') ?? null;

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
    var value = await prefs.getString('otp') ?? null;

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
    Map data = {'identifier': email, 'password': password};
    
    response = await http.post(Uri.parse(server + _login),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
        encoding: Encoding.getByName("utf-8"));
   
    if (response.statusCode == 200) {
      // isValidatedAcc = jsonDecode(response.body)['user']['validated'];
      
      jwt = jsonDecode(response.body)['jwt'];
      name = jsonDecode(response.body)['user']['full_name'];
      
      if(jsonDecode(response.body)['user']['phone1']!=null) {
        phone1 = int.parse(jsonDecode(response.body)['user']['phone1']);
          
      }
      
      is_blocked = jsonDecode(response.body)['user']['blocked']??false;
      is_confirmed = jsonDecode(response.body)['user']['validated']??false;
      id = jsonDecode(response.body)['user']['id'];
      password = null;
      await _storeToken(jsonDecode(response.body)['jwt']);
      await _storeEmail(email.toString());
    }
    return response;
    //  if(response.staus)
    //
  }

  Future resetPassword() async {
    var filter = "filters[email][\$eq]=$email";
    otp = OTP.generateTOTPCodeString(
        'JBSWY3DPEHPK3PXP', DateTime.now().millisecondsSinceEpoch);
    response = await http.get(
      Uri.parse("$server$_userUrl?$filter"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      // print(jsonDecode(response.body)[0]);
      if (jsonDecode(response.body).isNotEmpty) {
        id = jsonDecode(response.body)[0]['id'];
        await updateOTP(id, int.parse(otp)).whenComplete(() async =>
            await sendOTP(email.toString(), int.parse(otp))
                .whenComplete(() => canUpdatePassword = true));
      } else {
        canUpdatePassword = false;
      }
    }
    // ignore: avoid_print
    print(canUpdatePassword);
  }

  // ignore: non_constant_identifier_names
  Future updatePassword(Newpassword,int OTP,email) async {
    var data = {"password": Newpassword.toString(),"confirmPassword":Newpassword.toString(),"OTP":OTP,"email":email,};
    var respose = await http.post(Uri.parse(server + _updatePasswordUrl),
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
      'identifier': email,
      "username": email,
      "phone1": phone1.toString(),
      "phone2": phone2.toString(),
      "otp": otp,
      "full_name": name,
      "validated": false,
      'password': password
    };
    response = await http.post(Uri.parse(server + _register),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
        encoding: Encoding.getByName("utf-8"));
    password = null;
    await _storeEmail(email!).then((value) async =>
        await sendOTP(email, otp).then((value) async => await _storeOTP(otp)));

    return response;
  }
}
