import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:maraka/models/banner.dart';
import 'package:maraka/logic/constants.dart';

class BannerLogic {
  final String _banner = "/banners";
  final String _bannerBottom = "/featured-ads";
  // ignore: prefer_typing_uninitialized_variables
  var response;
  List<Banner> bannersSplashScreen = [];
  List<Banner> bannersHomeScreen = [];
  List<Banner> bannersBottom = [];

  Future<String> fetchImage(String imgUrl) async {
    var res = await http.get(
      Uri.parse(imgUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (res.statusCode == 200) {
      return jsonDecode(res.body)['image'];
    } else {
      return ''; // Handle the case when image fetching fails
    }
  }

  Future getSplashscreen() async {
    response = await http.get(
      Uri.parse("$server$_banner"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      var imagesFuture = <Future>[];
      for (var item in data) {
        imagesFuture.add(fetchImage(item['display']));
      }
      List images = await Future.wait(imagesFuture);
      for (int i = 0; i < data.length; i++) {
        var item = data[i];
        Banner ad = createbannerFromData(item, images[i]);

        if (ad.splashscreen == true) {
          bannersSplashScreen.add(ad);
        }
      }
      bannersSplashScreen.shuffle();

      return response;
    }
  }

  Banner createbannerFromData(var item, image) {
    return Banner(
      id: item['id'],
      url: item['link'],
      owner: item['owner'],
      expire_date: item['expire_date'],
      splashscreen: item['splashscreen'],
      home: item['home'],
      display: image,
      imgUrl: image,
    );
  }

  Future getHomeScreenTop() async {
    response = await http.get(
      Uri.parse("$server$_banner"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var imagesFuture = <Future>[];
      for (var item in data) {
        imagesFuture.add(fetchImage(item['display']));
      }
      List images = await Future.wait(imagesFuture);
      for (var i = 0; i < data.length; i++) {
        var item = data[i];
        Banner ad = createbannerFromData(item, images[i]);
        if (ad.home == true) {
          bannersHomeScreen.add(ad);
        }
      }
      bannersHomeScreen.shuffle();
      return response;
    }
  }

// this banner is not displayed on UI
  Future getBottomBanner() async {
    response = await http.get(
      Uri.parse("$server$_bannerBottom"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      for (var item in data) {
        var imag = '';
        var res = await http.get(
          Uri.parse(item['display']),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );

        if (res.statusCode == 200) {
          imag = jsonDecode(res.body)['image'];
        }
        Banner ad = Banner(
          id: item['id'],
          url: item['link'],
          owner: item['owner'],
          expire_date: item['expire_date'],
          // how_Long: item['how_long'],
          display: imag,
          imgUrl: imag,
        );
        bannersBottom.add(ad);
      }
      bannersBottom.shuffle();
      return response;
    }
  }
}
