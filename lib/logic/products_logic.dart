import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:maraka/logic/user_logic.dart';
import 'package:maraka/models/ImageStrapi.dart';
import 'package:maraka/models/product.dart';
import 'package:maraka/logic/constants.dart';
import 'package:mobile_device_identifier/mobile_device_identifier.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:http_parser/http_parser.dart';
import 'package:crypto/crypto.dart';

class ProductLogic {
  List<Product> products = [];
  List<Product> myAds = [];
  List<Product> favourites = [];
  final String _allProducts = "/product";
  final _productCreate = '/product-create';
  final _carCreate = '/car';
  final String _productViewer = "/product-viewer";
  final String _userProduct = "/user-product/";
  // ignore: prefer_typing_uninitialized_variables
  var response;

  Future postImages(File image, String name) async {
    // ignore: unrelated_type_equality_checks
    if (image == Null) return;
    // final imageTemporary = File(image.path);
    var stream = http.ByteStream(image.openRead());
    stream.cast();
    var length = await image.length();
    var req = http.MultipartRequest('POST', Uri.parse("$server/multi-image"));
    var multiport = http.MultipartFile("image", stream, length,
        filename: name, contentType: MediaType('images', 'png'));
    req.files.add(multiport);
    var streamResponse = await req.send();
    var response = await http.Response.fromStream(streamResponse);

    return response;
  }

  Future deleteProduct(var id) async {
    Map<String, String> headers = {
      "dataType": "json",
      'Content-Type': 'application/json; charset=UTF-8',
    };
    var response = await http.delete(
      Uri.parse(
          // ignore: prefer_interpolation_to_compose_strings
          "$server$_productCreate/$id"),
      headers: headers,
    );
    return response;
  }

  Future updateCar(
      {String? model,
      var year,
      String? fuel,
      String? make,
      String? mileage,
      String? transmition,
      var car}) async {
    Map<String, String> headers = {
      "dataType": "json",
      'Content-Type': 'application/json; charset=UTF-8',
    };
    var data = {};
    if (model != null || model.toString() != '') {
      data['model'] = model;
    }
    if (year != null || year.toString() != '') {
      data['year'] = year;
    }
    if (fuel != null || fuel.toString() != '') {
      data['fuel'] = fuel;
    }
    if (make != null || make.toString() != '') {
      data['make'] = make;
    }
    if (mileage != null || mileage.toString() != '') {
      data['kilos'] = mileage;
    }
    if (transmition != null || transmition.toString() != '') {
      data[' transmission'] = transmition;
    }
    var response = await http.patch(Uri.parse(
            // ignore: prefer_interpolation_to_compose_strings
            "$server$_carCreate/$car"),
        headers: headers,
        body: jsonEncode(data),
        encoding: Encoding.getByName("utf-8"));

    return response;
  }

  Future updateProduct(Product product, var car) async {
    Map<String, String> headers = {
      "dataType": "json",
      'Content-Type': 'application/json; charset=UTF-8',
    };
    var preparedData = {
      "price": product.price,
      "description": product.description,
    };
    if (product.imageUrls!.isNotEmpty) {
      preparedData['display'] = product.imageUrls;
    }
    if (product.category.toString().toLowerCase() != "cars") {
      if (product.title.toString().isNotEmpty) {
        preparedData['name'] = product.title.toString();
      }
    } else {
      if (car != null || car != -1) {
        preparedData['car'] = car;
      }
    }

    var response = await http.patch(Uri.parse(
            // ignore: prefer_interpolation_to_compose_strings
            "$server$_productCreate/${product.id1}"),
        headers: headers,
        body: jsonEncode(preparedData),
        encoding: Encoding.getByName("utf-8"));

    return response;
  }

  Future postProduct(Product ad, int id, var car) async {
    var uuid = const Uuid();
    Map<String, String> headers = {
      "dataType": "json",
      'Content-Type': 'application/json; charset=UTF-8',
    };
    var data = {
      "name": ad.title,
      "category": ad.category,
      "description": ad.description,
      "price": ad.price,
      "expire_date": DateTime.now().add(const Duration(days: 93)).toString(),
      'identifier': uuid.v4(),
      'owner': id,
      'display': ad.imageUrls
    };
    if (car != null || car != -1) {
      data['car'] = car;
    }

    response = await http.post(Uri.parse(server + _productCreate),
        headers: headers,
        body: jsonEncode(data),
        encoding: Encoding.getByName("utf-8"));

    return response;
  }

  Future postCar(
      {required String model,
      required var year,
      required String fuel,
      required String make,
      required String mileage,
      required String transmition}) async {
    // var uuid = const Uuid();
    Map<String, String> headers = {
      "dataType": "json",
      'Content-Type': 'application/json; charset=UTF-8',
    };
    var data = {
      "model": model,
      "make": make,
      "year": year,
      "fuel": fuel,
      "kilos": mileage,
      "transmission": transmition
    };

    response = await http.post(Uri.parse(server + _carCreate),
        headers: headers,
        body: jsonEncode(data),
        encoding: Encoding.getByName("utf-8"));
    return response;
  }

  Future<String> _getViewerDeviceId() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'viewer_device_id';
    var deviceId = prefs.getString(key);
    if (deviceId == null || deviceId.isEmpty) {
      deviceId = const Uuid().v4();
      await prefs.setString(key, deviceId);
    }
    return deviceId;
  }

  // List<Product> getOwnerProducts(List<Product> items) {
  //   return Null;
  // }
  Future createProductViews(int product) async {
    final deviceId = await MobileDeviceIdentifier().getDeviceId() ?? '';

    var bytes = utf8.encode(deviceId);

    var digest = sha256.convert(bytes);

    var data = {"veiwer_hash": digest.toString(), "product": product};
    var res = await http
        .get(Uri.parse("$server$_productViewer?search=${digest.toString()}"));
    var response;

    if (res.statusCode == 200) {
      if ((jsonDecode(res.body) as List).isEmpty) {
        response = await http.post(
          Uri.parse(
              // ignore: prefer_interpolation_to_compose_strings
              "$server$_productViewer"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(data),
        );

        return response;
      } else {
        bool found = false;
        for (var element in jsonDecode(res.body)) {
          if (element['product'] == product) {
            found = true;
          }
        }
        if (!found) {
          response = await http.post(
            Uri.parse(
                // ignore: prefer_interpolation_to_compose_strings
                "$server$_productViewer"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(data),
          );

          return response;
        }
      }
    }

    return res;
  }

  Future<List<Product>> getProducts(String category) async {
    String filter = "";
    if (category.toLowerCase() != "All".toLowerCase()) {
      filter = "?search=$category";
    }

    var response = await http.get(
      Uri.parse(
          // ignore: prefer_interpolation_to_compose_strings
          "$server$_allProducts$filter"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      for (var item in data) {
        var id1 = item['id'];
        var id2 = item['identifier'];

        var name = item['name'];
        var createAt = item['created'];
        var category = item['category'];
        var description = item['description'];
        var price = item['price'];
        var expire_date = item['expire_date'];
        var owner = item['owner'];
        Seller seller = Seller(url: owner);

        List imagesJson = item['display'];
        List<ImageStrapi> images = [];
        for (var element in imagesJson) {
          images.add(ImageStrapi(url: element['image']));
        }

        int viewers = item['viewers'].length;

        if (DateTime.now().isBefore(DateTime.parse(expire_date))) {
          products.add(Product(
              views: viewers,
              id1: id1,
              id2: id2,
              title: name,
              category: category.toString().toLowerCase(),
              seller: seller,
              images: images,
              price: price,
              car: item['car'],
              expiryDate: DateTime.parse(expire_date),
              createdAt: DateTime.parse(createAt),
              description: description));
        }
      }
      // print();
      return _quicksortByCreatedAt(products);
    } else {
      return [];
    }
  }

  List<Product> _quicksortByCreatedAt(List<Product> products) {
    if (products.length <= 1) {
      return products;
    }

    final pivotIndex = _getMedianOfThree(products);
    final pivot = products[pivotIndex].createdAt;

    final List<Product> left = [];
    final List<Product> middle = [];
    final List<Product> right = [];

    for (int i = 0; i < products.length; i++) {
      if (i == pivotIndex) {
        middle.add(products[i]);
      } else {
        final comparison = products[i].createdAt.compareTo(pivot);
        if (comparison > 0) {
          left.add(products[i]);
        } else {
          right.add(products[i]);
        }
      }
    }

    return [
      ..._quicksortByCreatedAt(left),
      ...middle,
      ..._quicksortByCreatedAt(right)
    ];
  }

  int _getMedianOfThree(List<Product> products) {
    const first = 0;
    final middle = products.length ~/ 2;
    final last = products.length - 1;

    if ((products[first].createdAt.compareTo(products[middle].createdAt) <= 0 &&
            products[first].createdAt.compareTo(products[last].createdAt) >=
                0) ||
        (products[first].createdAt.compareTo(products[middle].createdAt) >= 0 &&
            products[first].createdAt.compareTo(products[last].createdAt) <=
                0)) {
      return first;
    } else if ((products[middle]
                    .createdAt
                    .compareTo(products[first].createdAt) <=
                0 &&
            products[middle].createdAt.compareTo(products[last].createdAt) >=
                0) ||
        (products[middle].createdAt.compareTo(products[first].createdAt) >= 0 &&
            products[middle].createdAt.compareTo(products[last].createdAt) <=
                0)) {
      return middle;
    } else {
      return last;
    }
  }

  Future<List<Product>> getMyAds(User owner) async {
    var filter = owner.id.toString();

    var response = await http.get(
      Uri.parse("$server$_userProduct$filter"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      for (var item in data) {
        var id1 = item['id'];
        var id2 = item['identifier'];

        var name = item['name'];
        var createAt = item['created'];
        var category = item['category'];
        var description = item['description'];
        var price = item['price'];
        var expire_date = item['expire_date'];
        // var owner = item['owner'];
        Seller seller = Seller(
            fullNames: owner.name,
            phone1: owner.phone1.toString(),
            phone2: owner.phone2.toString(),
            subscription_end: owner.subscription,
            email: owner.email);
        List imagesJson = item['display'];
        List<ImageStrapi> images = [];

        var res = await http.get(
          Uri.parse("$server$_productViewer"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );
        int viewers = 0;
        if (res.statusCode == 200) {
          for (var element in jsonDecode(res.body)) {
            if (element['product'] == id1) {
              viewers++;
            }
          }
        }

        for (var element in imagesJson) {
          images.add(ImageStrapi(url: element['image']));
        }
        if (DateTime.now().isBefore(DateTime.parse(expire_date))) {
          myAds.add(Product(
              views: viewers,
              id1: id1,
              id2: id2,
              title: name,
              createdAt: createAt,
              category: category.toString().toLowerCase(),
              seller: seller,
              images: images,
              price: price,
              car: item['car'],
              expiryDate: DateTime.parse(expire_date),
              description: description));
        }
      }
      return myAds;
    } else {
      throw Null;
    }
  }
}
