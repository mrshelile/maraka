import 'dart:convert';
import 'dart:core';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:maraka/logic/constants.dart';
import 'package:maraka/logic/email.dart';
import 'package:otp/otp.dart';
import 'package:shared_preferences/shared_preferences.dart';

Map<String, dynamic> _extractPayload(Map<String, dynamic> payload) {
  if (payload.containsKey('user') && payload['user'] is Map) {
    return Map<String, dynamic>.from(payload['user'] as Map);
  }
  return payload;
}

Map<String, dynamic> buildLoginPayload(
    String loginIdentifier, String? password) {
  final normalizedIdentifier = loginIdentifier.trim();
  return <String, dynamic>{
    'username': normalizedIdentifier,
    'email': normalizedIdentifier,
    'password': password ?? '',
  };
}

Map<String, dynamic> buildLocalPartLoginPayload(
    String loginIdentifier, String? password) {
  final normalizedIdentifier = loginIdentifier.trim();
  if (!normalizedIdentifier.contains('@')) {
    return buildLoginPayload(normalizedIdentifier, password);
  }

  final localPart = normalizedIdentifier.split('@').first;
  return <String, dynamic>{
    'username': localPart,
    'email': normalizedIdentifier,
    'password': password ?? '',
  };
}

class UserController extends GetxController {
  User? _user;

  bool get isAuthenticated {
    final emailValue = _user?.email?.trim();
    final jwtValue = _user?.jwt?.toString().trim();
    return _user != null &&
        emailValue != null &&
        emailValue.isNotEmpty &&
        jwtValue != null &&
        jwtValue.isNotEmpty;
  }

  User? get user => _user;
}

class User extends GetxController {
  bool canUpdatePassword = false;
  String? name;
  String? email;
  late int? phone1;
  late int? phone2;
  String? password;
  DateTime? subscription;
  dynamic otp;
  int id = 0;
  // bool isValidatedAcc = false;
  bool isConfirmed = false;
  bool isBlocked = false;
  bool isSuperuser = false;
  dynamic jwt;
  dynamic response;

  final _login = "/auth/login/";
  final _register = "/auth_user";
  final _userUrl = "/list_users";
  final _userPasswordReset = "/reset-password";
  final _updatePasswordUrl = "/update-password";

  bool get isAuthenticated {
    final emailValue = email?.trim();
    final jwtValue = jwt?.toString().trim();
    return emailValue != null &&
        emailValue.isNotEmpty &&
        jwtValue != null &&
        jwtValue.isNotEmpty;
  }

  User(
      {this.name,
      this.email,
      this.phone1,
      this.phone2,
      this.password,
      this.jwt});

  void init(User user) {
    name = user.name;
    email = user.email;
    phone1 = user.phone1;
    phone2 = user.phone2;
    password = user.password;
    subscription = user.subscription;
    otp = user.otp;
    id = user.id;
    isConfirmed = user.isConfirmed;
    isBlocked = user.isBlocked;
    isSuperuser = user.isSuperuser;
    jwt = user.jwt;
    response = user.response;
  }

  Future removeAll() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    name = null;
    email = null;
    phone1 = null;
    phone2 = null;
    subscription = null;
    id = 0;
    jwt = null;
    isSuperuser = false;
    isConfirmed = false;
    isBlocked = false;
  }

  Future<void> restoreSession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isSuperuser = prefs.getBool('is_superuser') ?? false;
    isConfirmed = prefs.getBool('is_confirmed') ?? false;
    isBlocked = prefs.getBool('is_blocked') ?? false;

    final storedEmail = prefs.getString('email');
    final storedJwt = prefs.getString('jwt');

    if (storedEmail != null &&
        storedEmail.trim().isNotEmpty &&
        storedJwt != null &&
        storedJwt.trim().isNotEmpty) {
      name = prefs.getString('name');
      email = storedEmail;
      phone1 = prefs.getInt('phone1');
      phone2 = prefs.getInt('phone2');
      id = prefs.getInt('id') ?? 0;
      jwt = storedJwt;

      final storedSubscription = prefs.getString('subscription');
      subscription = storedSubscription != null
          ? DateTime.tryParse(storedSubscription)
          : null;
    } else {
      name = null;
      email = null;
      phone1 = null;
      phone2 = null;
      subscription = null;
      id = 0;
      jwt = null;
    }
  }

  Future<void> persistSession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_superuser', isSuperuser);
    await prefs.setBool('is_confirmed', isConfirmed);
    await prefs.setBool('is_blocked', isBlocked);
    await prefs.setInt('id', id);
    if (name != null) {
      await prefs.setString('name', name!);
    }
    if (email != null) {
      await prefs.setString('email', email!);
    }
    if (phone1 != null) {
      await prefs.setInt('phone1', phone1!);
    }
    if (phone2 != null) {
      await prefs.setInt('phone2', phone2!);
    }
    if (subscription != null) {
      await prefs.setString('subscription', subscription!.toIso8601String());
    }
    if (jwt != null) {
      await prefs.setString('jwt', jwt.toString());
    }
  }

  void applyLoginPayload(Map<String, dynamic> payload) {
    final userPayload = _extractPayload(payload);
    name = userPayload['full_name']?.toString();
    final phone = userPayload['phone1'];
    if (phone != null) {
      phone1 = int.tryParse(phone.toString());
    }
    isBlocked = userPayload['is_active'] ?? false;
    isConfirmed = userPayload['validated'] ?? false;
    isSuperuser = userPayload['is_superuser'] ?? false;
    id = int.tryParse(userPayload['id']?.toString() ?? '0') ?? 0;
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
    final loginIdentifier = email?.trim() ?? '';
    const bool debugLogin = true;
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    };

    var data = buildLoginPayload(loginIdentifier, password);

    if (debugLogin && kDebugMode) {
      print('DEBUG: Login attempt payload: ${jsonEncode(data)}');
    }

    response = await http.post(Uri.parse(server + _login),
        headers: headers,
        body: jsonEncode(data),
        encoding: Encoding.getByName("utf-8"));

    if (debugLogin && kDebugMode) {
      try {
        print(
            'DEBUG: Login response: status=${response.statusCode} body=${response.body}');
      } catch (e) {
        print('DEBUG: Login response - could not read body: $e');
      }
    }

    if (response.statusCode != 200 && loginIdentifier.contains('@')) {
      data = buildLocalPartLoginPayload(loginIdentifier, password);
      if (debugLogin && kDebugMode) {
        print('DEBUG: Fallback login payload: ${jsonEncode(data)}');
      }
      response = await http.post(Uri.parse(server + _login),
          headers: headers,
          body: jsonEncode(data),
          encoding: Encoding.getByName("utf-8"));
      if (debugLogin && kDebugMode) {
        try {
          print(
              'DEBUG: Fallback login response: status=${response.statusCode} body=${response.body}');
        } catch (e) {
          print('DEBUG: Fallback login response - could not read body: $e');
        }
      }
    }

    if (response.statusCode == 200) {
      final decodedBody = jsonDecode(response.body);
      final payload = decodedBody is Map<String, dynamic>
          ? decodedBody
          : Map<String, dynamic>.from(decodedBody as Map);

      jwt = payload['token'];
      applyLoginPayload(payload);
      password = null;
      await _storeToken(jwt.toString());
      await _storeEmail(email.toString());
      await persistSession();
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
    if (response.statusCode == 201 || response.statusCode == 200) {
      await _storeEmail(email!).then((value) async => await sendOTP(email, otp)
          .then((value) async => await _storeOTP(otp)));
    }
    return response;
  }
}

Future<Map<String, String>> authenticatedHeaders({bool json = true}) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('jwt');
  return {
    if (json) 'Content-Type': 'application/json; charset=UTF-8',
    if (token != null && token.isNotEmpty) 'Authorization': 'Token $token',
  };
}

/// Older version

// import 'dart:convert';
// import 'dart:core';
// import 'package:http/http.dart' as http;
// import 'package:maraka/logic/constants.dart';
// import 'package:maraka/logic/email.dart';
// import 'package:otp/otp.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class User {
//   bool canUpdatePassword = false;
//   String? name;
//   String? email = '';
//   late int? phone1;
//   late int? phone2;
//   String? password = '';
//   DateTime? subscription;
//   var otp;
//   int id = 0;
//   // bool isValidatedAcc = false;
//   // ignore: non_constant_identifier_names
//   bool is_confirmed = false;
//   // ignore: non_constant_identifier_names
//   bool is_blocked = false;
//   // ignore: prefer_typing_uninitialized_variables
//   var jwt;
//   // ignore: prefer_typing_uninitialized_variables
//   var response;

//   final _login = "/auth/login/";
//   final _register = "/auth_user";
//   final _userUrl = "/list_users";
//   final _userPasswordReset = "/reset-password";
//   final _updatePasswordUrl = "/update-password";
//   User(
//       {this.name,
//       this.email,
//       this.phone1,
//       this.phone2,
//       this.password,
//       this.jwt});
//   Future removeAll() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.clear();
//     email = null;
//     jwt = null;
//   }

//   Future retrieveToken() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     var value = prefs.getString('jwt');

//     jsonEncode(value).toString().isEmpty ||
//             // ignore: unrelated_type_equality_checks
//             jsonEncode(value) == 0 ||
//             jwt == null
//         ? jwt = null
//         : jwt = jsonEncode(value);
//     return prefs;
//   }

//   Future _storeOTP(String value) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('otp', value);
//   }

//   Future _retrieveOTP(String value) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     var value = prefs.getString('otp');

//     jsonEncode(value).toString().isEmpty ||
//             // ignore: unrelated_type_equality_checks
//             jsonEncode(value) == 0 ||
//             otp == null
//         ? otp = null
//         : otp = jsonEncode(value);
//     return prefs;
//   }

//   Future _storeToken(String value) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('jwt', value);
//   }

//   Future removeToken() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.remove("jwt").whenComplete(() => jwt = null);
//   }

//   Future _storeEmail(String value) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('email', value);
//   }

//   Future removeEmail() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.remove("email").whenComplete(() => jwt = null);
//   }

//   Future retrieveEmail() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     var value = prefs.getString('email');

//     jsonEncode(value).toString().isEmpty ||
//             // ignore: unrelated_type_equality_checks
//             jsonEncode(value) == 0 ||
//             email == null
//         ? email = null
//         : email = jsonEncode(value);
//     return prefs;
//   }

//   Future<bool> isServerAvailable() async {
//     response = await http.post(Uri.parse(_login));
//     if (response.statusCode == 200) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   Future updateDetails() async {
//     Map data = {'phone1': phone1, 'phone2': phone2};
//     response = await http.put(Uri.parse("$server$_userUrl$id"),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(data),
//         encoding: Encoding.getByName("utf-8"));
//     return response;
//   }

//   Future login() async {
//     Map data = {'username': email, 'password': password};

//     response = await http.post(Uri.parse(server + _login),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(data),
//         encoding: Encoding.getByName("utf-8"));

//     if (response.statusCode == 200) {
//       // isValidatedAcc = jsonDecode(response.body)['user']['validated'];

//       jwt = jsonDecode(response.body)['token'];
//       name = jsonDecode(response.body)['user']['full_name'];

//       if (jsonDecode(response.body)['user']['phone1'] != null) {
//         phone1 = int.parse(jsonDecode(response.body)['user']['phone1']);
//       }

//       is_blocked = jsonDecode(response.body)['user']['is_active'] ?? false;
//       is_confirmed = jsonDecode(response.body)['user']['validated'] ?? false;
//       id = jsonDecode(response.body)['user']['id'];
//       password = null;
//       await _storeToken(jwt);
//       await _storeEmail(email.toString());
//     }

//     return response;
//     //  if(response.staus)
//     //
//   }

//   Future resetPassword() async {
//     canUpdatePassword = false;
//     otp = OTP.generateTOTPCodeString(
//         'JBSWY3DPEHPK3PXP', DateTime.now().millisecondsSinceEpoch);
//     var data = {"email": email, "otp": otp};
//     response = await http.put(Uri.parse(server + _userPasswordReset),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(data),
//         encoding: Encoding.getByName("utf-8"));

//     if (response.statusCode == 200) {
//       var res = await sendOTP(email, otp);
//       if (res.statusCode == 200) {
//         canUpdatePassword = true;
//         return res;
//       }
//     }
//     return http.Response("internal error", 500);
//   }

//   // ignore: non_constant_identifier_names
//   Future updatePassword(Newpassword, int OTP, email) async {
//     var data = {
//       "password": Newpassword.toString(),
//       "email": email,
//     };
//     var respose = await http.put(Uri.parse(server + _updatePasswordUrl),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(data),
//         encoding: Encoding.getByName("utf-8"));
//     return respose;
//   }

//   Future register() async {
//     otp = OTP.generateTOTPCodeString(
//         'JBSWY3DPEHPK3PXP', DateTime.now().millisecondsSinceEpoch);

//     Map data = {
//       'email': email,
//       "username": email,
//       "phone1": phone1.toString(),
//       "phone2": phone2.toString(),
//       "otp": otp,
//       "full_name": name,
//       "validated": false,
//       "is_active": true,
//       "is_superuser": false,
//       'password': password
//     };

//     response = await http.post(Uri.parse(server + _register),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(data),
//         encoding: Encoding.getByName("utf-8"));
//     password = null;
//     if (response.statusCode == 201 || response.statusCode == 200) {
//       await _storeEmail(email!).then((value) async => await sendOTP(email, otp)
//           .then((value) async => await _storeOTP(otp)));
//     }
//     return response;
//   }
// }
