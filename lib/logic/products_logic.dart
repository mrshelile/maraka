import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
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
  final String _allProducts = "/api/products";
  // ignore: prefer_typing_uninitialized_variables
  var response;
  Future likeProduct(User owner, Product product) async {
    var filter = "filters[identifier][\$eq]=${product.id2}";
    List<int> likedIds = [];
    var response = await http.get(
      Uri.parse("$server$_allProducts?populate=*&$filter"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      // print(jsonDecode(response.body)['data'][0]['attributes']['likedby']);
      var data = jsonDecode(response.body)['data'];
      for (var item in data) {
        var favourites = item['attributes']['likedby']['data'];
        // print(favourites);
        for (var like in favourites) {
          likedIds.add(like['id']);
        }
        likedIds.add(owner.id);
        break;
      }
    }
    var data = {
      "data": {
        "likedby": likedIds,
      }
    };

    var response2 =
        await http.put(Uri.parse("$server$_allProducts/${product.id1}"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(data),
            encoding: Encoding.getByName("utf-8"));
    product.isLiked = true;
    return response2;
  }

  Future unlikeProduct(User owner, Product product) async {
    var filter = "filters[identifier][\$eq]=${product.id2}";
    List<int> likedIds = [];
    var response = await http.get(
      Uri.parse("$server$_allProducts?populate=*&$filter"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      for (var item in data) {
        var favourites = item['attributes']['likedby']['data'];
        // print(favourites);
        for (var like in favourites) {
          likedIds.add(like['id']);
        }
        likedIds.removeWhere((element) => element == owner.id);
        product.isLiked = false;
        break;
      }
    }
    var data = {
      "data": {
        "likedby": likedIds,
      }
    };

    var response2 =
        await http.put(Uri.parse("$server$_allProducts/${product.id1}"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(data),
            encoding: Encoding.getByName("utf-8"));
    return response2;
  }

  Future postImages(XFile image, String name) async {
    // ignore: unrelated_type_equality_checks
    if (image == Null) return;
    final imageTemporary = File(image.path);
    var stream = http.ByteStream(image.openRead());
    stream.cast();
    var length = await imageTemporary.length();
    var req = http.MultipartRequest('POST', Uri.parse("$server/api/upload"));
    var multiport = http.MultipartFile("files", stream, length,
        filename: name, contentType: MediaType('images', 'png'));
    req.files.add(multiport);
    var streamResponse = await req.send();
    var response = await http.Response.fromStream(streamResponse);
    if (streamResponse.statusCode == 200) {
      // print(response.body);
      print("file uploaded");
    } else
      print("failed");

    return response;
  }

  Future postProduct(Product ad, User owner) async {
    var uuid = const Uuid();
    // print(DateTime.now().add(const Duration(days: 31)));
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    var data = {
      "data": {
        "name": ad.title,
        "category": ad.category,
        "description": ad.description,
        "price": ad.price,
        "expire_date": DateTime.now().add(const Duration(days: 31)).toString(),
        'identifier': uuid.v4(),
        'owner': [owner.id],
        'display': ad.imageUrls
      }
    };

    response = await http.post(Uri.parse(server + _allProducts),
        headers: headers,
        body: jsonEncode(data),
        encoding: Encoding.getByName("utf-8"));
    return response;
  }
  // List<Product> getOwnerProducts(List<Product> items) {
  //   return Null;
  // }

  Future<List<Product>> getProducts(User ownerModel, String category) async {
    var filter1 = "filters[owner][email][\$ne]=${ownerModel.email}";
    var filter2;

    if (category.toLowerCase() != "all") {
      filter2 = "filters[category][\$eq]=${category.toLowerCase()}";
    } else {
      filter2 = "filters[category][\$ne]=$category";
    }

    var response = await http.get(
      Uri.parse(
          // ignore: prefer_interpolation_to_compose_strings
          "$server$_allProducts?populate=*&$filter1&" + filter2),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];

      for (var item in data) {
        var id1 = item['id'];
        var id2 = item['attributes']['identifier'];
        // print(id2);

        var name = item['attributes']['name'];
        var createAt = item["attributes"]['createdAt'];
        var category = item["attributes"]['category'];
        var description = item["attributes"]['description'];
        var price = item["attributes"]['price'];
        var expire_date = item["attributes"]['expire_date'];
        // var identifier = item["attributes"]['identifier'];
        var owner = item["attributes"]['owner']['data']['attributes'];
        var likedby = false;
        // if()

        // for (var ite in item['attributes']['likedbies']['data']) {
        //   // print(ownerModel.email.toString());

        //   if (ownerModel.email
        //       .toString()
        //       .contains(ite['attributes']['email'])) {
        //     likedby = true;
        //   }
        // }
        //  print(item['attributes']['likedby']['data'][0]['attributes']['email']);

        Seller seller = Seller(
            fullNames: owner['full_name'].toString(),
            phone1: owner['phone1'].toString(),
            phone2: owner['phone2'].toString(),
            subscription_end: owner['subscription_end'],
            email: owner['email'].toString());
        List imagesJson = item['attributes']['display']['data'];
        List<ImageStrapi> images = [];

        for (var element in imagesJson) {
          
          images.add(ImageStrapi(
              name: element['attributes']['name'],
              url: server + element['attributes']['url']));
        }

        //  print(DateTime.parse(createAt));
        if (DateTime.now().isBefore(DateTime.parse(expire_date))) {
          products.add(Product(
              id1: id1,
              id2: id2,
              isLiked: likedby,
              title: name,
              category: category.toString().toLowerCase(),
              seller: seller,
              images: images,
              price: price,
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
    var filter = "filters[owner][email][\$eq]=${owner.email!}";
    // print(filter);
    var response = await http.get(
      Uri.parse("$server$_allProducts?populate=*&$filter"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      for (var item in data) {
        var id1 = item['id'];
        var id2 = item['attributes']['identifier'];
        var name = item['attributes']['name'];
        var createAt = item["attributes"]['createdAt'];
        var category = item["attributes"]['category'];
        var description = item["attributes"]['description'];
        var price = item["attributes"]['price'];
        var expire_date = item["attributes"]['expire_date'];
        // var identifier = item["attributes"]['identifier'];
        var owner = item["attributes"]['owner']['data']['attributes'];
        Seller seller = Seller(
            fullNames: owner['full_name'].toString(),
            phone1: owner['phone1'].toString(),
            phone2: owner['phone2'].toString(),
            subscription_end: owner['subscription_end'],
            email: owner['email'].toString());
        List imagesJson = item['attributes']['display']['data'];
        List<ImageStrapi> images = [];
        imagesJson.forEach((element) {
          images.add(ImageStrapi(
              name: element['attributes']['name'],
              url: server + element['attributes']['url']));
        });
        ;
        if (DateTime.now().isBefore(DateTime.parse(expire_date))) {
       
          myAds.add(Product(
              isLiked: false,
              id1: id1,
              id2: id2,
              title: name,
              createdAt: createAt,
              category: category.toString().toLowerCase(),
              seller: seller,
              images: images,
              price: price,
              expiryDate: DateTime.parse(expire_date),
              description: description));
        }
      }
      // print(myAds[0].images![0].url);
      return myAds;
    } else {
      throw Null;
    }
  }

  Future<List<Product>> getFavourites(User owner) async {
    var filter = "filters[likedby][email][\$in]=${owner.email!}";

    var response = await http.get(
      Uri.parse("$server$_allProducts?populate=*&$filter"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      for (var item in data) {
        var id1 = item['id'];
        var id2 = item['attributes']['identifier'];
        var name = item['attributes']['name'];
        var createAt = item["attributes"]['createdAt'];
        var category = item["attributes"]['category'];
        var description = item["attributes"]['description'];
        var price = item["attributes"]['price'];
        var expire_date = item["attributes"]['expire_date'];
        // var identifier = item["attributes"]['identifier'];
        var owner = item["attributes"]['owner']['data']['attributes'];
        Seller seller = Seller(
            fullNames: owner['full_name'].toString(),
            phone1: owner['phone1'].toString(),
            phone2: owner['phone2'].toString(),
            subscription_end: owner['subscription_end'],
            email: owner['email'].toString());
        List imagesJson = item['attributes']['display']['data'];
        List<ImageStrapi> images = [];
        imagesJson.forEach((element) {
          images.add(ImageStrapi(
              name: element['attributes']['name'],
              url: server + element['attributes']['url']));
        });
        ;
        {
          favourites.add(Product(
              expiryDate: DateTime.parse(expire_date),
              createdAt: DateTime.parse(createAt),
              isLiked: true,
              id1: id1,
              id2: id2,
              title: name,
              category: category.toString().toLowerCase(),
              seller: seller,
              images: images,
              price: price,
              description: description));
        }
      }
      // print(myAds[0].images![0].url);
      return favourites;
    } else {
      throw Null;
    }
  }
}
