import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:maraka/logic/constants.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

final username = 'mrdavertzshelile@outlook.com';
final password = 'S1helile@com';
final _userUrl = "/api/users/";
bool isvalid = false;
final smtpServer = SmtpServer(
  'smtp-mail.outlook.com',
  port: 587,
  username: username,
  password: password,
);
Future verifyOTP(user, otp) async {
  isvalid = false;

  var filter =
      "filters[email][\$eq]=" + user.email + "&filters[otp][\$eq]=" + otp;
  var response = await http.get(Uri.parse(server + _userUrl + "?" + filter));
  if (response.statusCode == 200) {
    if (jsonDecode(response.body).isNotEmpty) {
      isvalid = true;
    }
  } else {
    print("failed");
    isvalid = false;
    return response;
  }
}

Future activateAcc(user) async {
  var filter = "filters[email][\$eq]=" + user.email;
  var response = await http.get(Uri.parse(server + _userUrl + "?" + filter));
  if (response.statusCode == 200) {
    if (jsonDecode(response.body).isNotEmpty)
      response = await http.put(
          Uri.parse(server +
              _userUrl +
              "" +
              jsonDecode(response.body)[0]['id'].toString()),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({"validated": true}),
          encoding: Encoding.getByName("utf-8"));
    return response;
  } else {
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
  final message = Message()
    ..from = Address(username, 'Malefetsane Shelile')
    ..recipients.add(to)
    ..subject = 'OTP CODE'
    ..text = "go to the app and add this otp code $otp";
  int statusCode;
  try {
    final sendReport = await send(message, smtpServer);
    print(sendReport.toString());
    statusCode = HttpStatus.ok;
  } on MailerException catch (e) {
    print('Message not sent: ${e.problems}');
    statusCode = HttpStatus.internalServerError;
  }
  print(statusCode);
}
