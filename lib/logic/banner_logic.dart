import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:maraka/models/ImageStrapi.dart';
import 'package:maraka/models/banner.dart';
import 'package:maraka/logic/constants.dart';

class BannerLogic {
  final String _banner = "/api/banners";
  final String _bannerBottom = "/api/bottom-banners";
  var response;
  List<Banner> bannersSplashScreen = [];
  List<Banner> bannersHomeScreen = [];
  List<Banner> bannersBottom = [];
  Future getSplashscreen() async {
    response = await http.get(
      Uri.parse("$server$_banner?populate=*"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];

      for (var item in data) {
        Banner ad = Banner(
          id: item['id'],
          url: item['attributes']['url'],
          owner: item['attributes']['owner'],
          expire_date: item['attributes']['expire_date'],
          splashscreen: item['attributes']['splashscreen'],
          home: item['attributes']['home'],
          display: item['attributes']['display'],
          imgUrl: item['attributes']['display']['data']['attributes']['url'],
        );

        if (ad.splashscreen == true) {
          bannersSplashScreen.add(ad);
        }
      }

      return response;
    }
  }

  Future getHomeScreenTop() async {
    response = await http.get(
      Uri.parse("$server$_banner?populate=*"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];

      for (var item in data) {
        Banner ad =  Banner(
          id: item['id'],
          url: item['attributes']['url'],
          owner: item['attributes']['owner'],
          expire_date: item['attributes']['expire_date'],
          splashscreen: item['attributes']['splashscreen'],
          home: item['attributes']['home'],
          display: item['attributes']['display'],
          imgUrl: item['attributes']['display']['data']['attributes']['url'],
        );
        if (ad.home == true) {
          bannersHomeScreen.add(ad);
        }
      }

      return response;
    }
  }

  Future getBottomBanner() async {
    response = await http.get(
      Uri.parse("$server$_bannerBottom?populate=*"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];

      for (var item in data) {
        Banner ad =  Banner(
          id: item['id'],
          url: item['attributes']['url'],
          owner: item['attributes']['owner'],
          expire_date: item['attributes']['expire_date'],
          display: item['attributes']['display'],
          imgUrl: item['attributes']['display']['data']['attributes']['url'],
        );
        bannersBottom.add(ad);
      }

      return response;
    }
  }
}
