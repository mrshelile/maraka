import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:maraka/logic/constants.dart';

import 'package:mailer/smtp_server.dart';
import 'package:maraka/logic/user_logic.dart';

const username = 'mrdavertzshelile@outlook.com';
const password = 'S1helile@com';
const _userUrl = "/list_users";
const _sendEmailUrl = "/sendEmail/";
const _validateAcc = '/validate-account';
bool isvalid = false;
final smtpServer = SmtpServer(
  'smtp-mail.outlook.com',
  port: 587,
  username: username,
  password: password,
);
Future verifyOTP(User user, otp) async {
  isvalid = false;

  var response = await http
      .get(Uri.parse("$server$_userUrl?search=${user.email.toString()}"));

  if (response.statusCode == 200) {
    if (jsonDecode(response.body).isNotEmpty) {
      if (jsonDecode(response.body)[0]['otp'].toString() == otp.toString()) {
        isvalid = true;
      }
    }
  } else {
    isvalid = false;
  }
  return response;
}

Future validateAcc(User user) async {
  var response = await http.put(
      // ignore: prefer_interpolation_to_compose_strings
      Uri.parse(server + _validateAcc),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({"email": user.email}),
      encoding: Encoding.getByName("utf-8"));
  return response;
}

// Future updateOTP(id, otp) async {
//   var data = {"otp": otp};
//   var respose = await http.put(Uri.parse(server + _userUrl + id.toString()),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(data),
//       encoding: Encoding.getByName("utf-8"));
//   return respose;
// }

Future sendOTP(to, otp) async {
  Map data = {
    'email': to,
    'subject': "OTP CODE",
    "body": "go to the app and add this otp code $otp"
  };

  var response = await http.post(Uri.parse(server + _sendEmailUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
      encoding: Encoding.getByName("utf-8"));
  return response;
}
