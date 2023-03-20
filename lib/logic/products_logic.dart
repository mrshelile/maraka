import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:maraka/logic/user_logic.dart';
import 'package:maraka/models/ImageStrapi.dart';
import 'package:maraka/models/product.dart';
import 'package:maraka/logic/constants.dart';
import 'package:uuid/uuid.dart';
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';

class ProductLogic {
  List<Product> products = [];
  List<Product> myAds = [];
  List<Product> favourites = [];
  final String _allProducts = "/product";
  final _productCreate = '/product-create';
  final _carCreate = '/car';
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
      headers:headers,
    );
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
    var uuid = const Uuid();
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
  // List<Product> getOwnerProducts(List<Product> items) {
  //   return Null;
  // }

  Future<List<Product>> getProducts(User ownerModel, String category) async {
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

        if (DateTime.now().isBefore(DateTime.parse(expire_date))) {
          products.add(Product(
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

      return products;
    } else {
      throw Null;
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

        for (var element in imagesJson) {
          images.add(ImageStrapi(url: element['image']));
        }
        if (DateTime.now().isBefore(DateTime.parse(expire_date))) {
          myAds.add(Product(
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
