import 'dart:convert';

import 'package:maraka/models/ImageStrapi.dart';
import 'package:http/http.dart' as http;

class Product {
  String? category;
  String? title;
  var price;
  String? description;
  List<ImageStrapi>? images;
  Seller? seller;
  int id1;
  String id2;
  bool isLiked = false;
  var createdAt;
  var expiryDate;
  List<int>? imageUrls;
  Map<String, dynamic>? car;
  int views = 0;

  String get priceStr {
    String pStr = price.toString();
    String a = '';
    int start = pStr.length - 3;
    if (start <= 0) {
      return pStr;
    }
    for (; start > 0; start -= 3) {
      a = " ${pStr.substring(start, start + 3)}$a";
    }
    a = "${pStr.substring(0, start + 3)}$a";
    return a;
  }

  Product(
      {required this.title,
      required this.description,
      required this.price,
      required this.id1,
      this.car,
      this.createdAt,
      this.imageUrls,
      required this.views,
      required this.expiryDate,
      required this.id2,
      required this.seller,
      required this.images,
      required this.category});
  @override
  String toString() {
    return title ?? car?['model'];
  }
}

class Seller {
  String? phone1;
  String? phone2;
  String? fullNames;
  String? email;
  String? url;
  String? id;
  var subscription_end;
  Seller(
      {this.fullNames,
      this.phone1,
      this.phone2,
      this.email,
      this.url,
      this.id,
      this.subscription_end});
  Future makeAllInformationFromUrl() async {
    if (url != null) {
      var response = await http.get(Uri.parse(
          // ignore: prefer_interpolation_to_compose_strings
          "$url"), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });
      if (response.statusCode == 200) {
        var item = jsonDecode(response.body);
        // id = int.parse(item['id']);
        fullNames = item['full_name'];
        email = item['email'];
        phone1 = item['phone1'];
        //print(item);
      }
      return response;
    }

    return http.Response("{data:'no URL'}", 200);
  }
}
