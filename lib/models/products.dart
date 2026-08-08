import 'package:maraka/models/product.dart';

class Recents {
  String? name;
  String? price;
  String? imgUrl;
  List<String>? detailUrl;
  String? category;
  String? description;
  String? car;
  Recents({this.name, this.price, this.imgUrl, this.detailUrl,this.car});

  // static List<Recents> generateFavourites() {
  //   return [
  //     Recents(
  //         name: "Girls Takkie",
  //         price: "M 200.00",
  //         imgUrl:
  //             "https://cdn.quotesgram.com/img/11/15/1763747386-slide_333724_3333281_free.jpg",
  //         detailUrl: [
  //           "https://cdn.quotesgram.com/img/11/15/1763747386-slide_333724_3333281_free.jpg"
  //         ]),
  //     Recents(
  //         name: "Make up",
  //         price: "M 200.00",
  //         imgUrl:
  //             "https://cdn.quotesgram.com/img/11/15/1763747386-slide_333724_3333281_free.jpg",
  //         detailUrl: [
  //           "https://cdn.quotesgram.com/img/11/15/1763747386-slide_333724_3333281_free.jpg"
  //         ]),
  //     Recents(
  //         name: "Make up",
  //         price: "M 200.00",
  //         imgUrl:
  //             "https://cdn.quotesgram.com/img/11/15/1763747386-slide_333724_3333281_free.jpg",
  //         detailUrl: [
  //           "https://cdn.quotesgram.com/img/11/15/1763747386-slide_333724_3333281_free.jpg"
  //         ]),
  //     Recents(
  //         name: "All Star",
  //         price: "M 1 500.00",
  //         imgUrl:
  //             "https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/310b9b131363011.6193b2b78c1ce.png",
  //         detailUrl: [
  //           "https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/310b9b131363011.6193b2b78c1ce.png"
  //         ])
  //   ];
  // }
  static List<Recents> generateFavourites(List<Product> items) {
    List<Recents> products = [];
    for (var element in items) {
      products.add(Recents(
          name: element.title,
          price: "M ${element.price}",
          imgUrl: element.images![0].url));
    }
    return products;
  }

  static List<Recents> generateMyAds(List<Product> items) {
    List<Recents> products = [];
    for (var element in items) {
      products.add(Recents(
          name: element.title,
          price: "M ${element.price}",
          imgUrl: element.images![0].url));
    }
    return products;
  }

  static List<Recents> generateHome(List<Product> items) {
    List<Recents> products = [];
    for (var element in items) {
      products.add(Recents(
          name: element.title,
          price: "M ${element.price}",
          imgUrl: element.images![0].url));
    }
    return products;
  }
}
