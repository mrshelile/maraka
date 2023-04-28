import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get_ip_address/get_ip_address.dart';
import 'package:maraka/logic/constants.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class Visitor {
  var _visitorUrl = "/visitor";
  Future createVisitor() async {
    /// Initialize Ip Address
    dynamic data;
    var response;
    try {
      var ipAddress = IpAddress(type: RequestType.json);

      /// Get the IpAddress based on requestType.
      data = await ipAddress.getIpAddress();

      var uuid = const Uuid();
      // print(DateTime.now().add(const Duration(days: 31)));

      var bytes = utf8.encode(data['ip']); // data being hashed

      var digest = sha256.convert(bytes);

      // print("Digest as bytes: ${digest.bytes}");
      // print("Digest as hex string: $digest");
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      var data1 = {
        "universal": uuid.v4(),
        "ip_address_hash": digest.toString()
      };
      var filter = "search=${digest.toString()}";
      var res1 = await http.get(Uri.parse("$server$_visitorUrl?$filter"));

      if (res1.statusCode == 200) {
        if (jsonDecode(res1.body).length <= 0) {
          response = await http.post(Uri.parse(server + _visitorUrl),
              headers: headers,
              body: jsonEncode(data1),
              encoding: Encoding.getByName("utf-8"));
          return response;
        }
      }
    } on IpAddressException catch (exception) {
      /// Handle the exception.
      debugPrint(exception.message.toString());
    } catch (error) {
      debugPrint(error.toString());
    }
    return http.Response("{failed}", 500);
  }
}
