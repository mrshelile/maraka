import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:maraka/logic/constants.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:maraka/logic/user_logic.dart';

const username = 'mrdavertzshelile@outlook.com';
const password = 'S1helile@com';
const _userUrl = "/list_users";
const _sendEmailUrl = "/sendEmail/";
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
      print(jsonDecode(response.body)[0]['otp']);
      if (jsonDecode(response.body)[0]['otp'].toString() == otp.toString()) {
        isvalid = true;
      }
    }
  } else {
    print("failed");
    isvalid = false;
  }
  return response;
}

Future activateAcc(user) async {
  var filter = "filters[email][\$eq]=" + user.email;
  var response = await http.get(Uri.parse("$server$_userUrl?$filter"));
  if (response.statusCode == 200) {
    if (jsonDecode(response.body).isNotEmpty) {
      response = await http.put(
          // ignore: prefer_interpolation_to_compose_strings
          Uri.parse(server +
              _userUrl +
              "" +
              jsonDecode(response.body)[0]['id'].toString()),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({"validated": true}),
          encoding: Encoding.getByName("utf-8"));
    }
    return response;
  } else {
    // ignore: avoid_print
    print("failed");
    isvalid = false;
    return response;
  }
}

Future updateOTP(id, otp) async {
  var data = {"otp": otp};
  var respose = await http.put(Uri.parse(server + _userUrl + id.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
      encoding: Encoding.getByName("utf-8"));
  return respose;
}

Future sendOTP(to, otp) async {
  // final message = Message()
  //   ..from = Address(username, 'Malefetsane Shelile')
  //   ..recipients.add(to)
  //   ..subject = 'OTP CODE'
  //   ..text = "go to the app and add this otp code $otp";
  // int statusCode;
  // try {
  //   final sendReport = await send(message, smtpServer);
  //   print(sendReport.toString());
  //   statusCode = HttpStatus.ok;
  // } on MailerException catch (e) {
  //   print('Message not sent: ${e.problems}');
  //   statusCode = HttpStatus.internalServerError;
  // }
  // print(statusCode);
  Map data = {
    'email': to,
    'subject': "OTP CODE",
    "body": "go to the app and add this otp code $otp"
  };
  print(data);
  var response = await http.post(Uri.parse(server + _sendEmailUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
      encoding: Encoding.getByName("utf-8"));
  return response;
}
