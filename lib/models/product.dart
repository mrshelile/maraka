import 'package:maraka/models/ImageStrapi.dart';

class Product {
  String? category;
  String? title;
  var price;
  String? description;
  List<ImageStrapi>? images;
  Seller? seller;
  int? id1;
  String id2;
  bool isLiked = false;
  var createdAt;
  var expiryDate;
  List<int>? imageUrls;
  Product(
      {required this.title,
      required this.description,
      required this.price,
      this.id1,
      this.createdAt,
      this.imageUrls,
      required this.expiryDate,
      required this.id2,
      required this.seller,
      required this.images,
      required this.isLiked,
      required this.category});
}

class Seller {
  String? phone1;
  String? phone2;
  String? fullNames;
  String? email;
  var subscription_end;
  Seller(
      {this.fullNames,
      this.phone1,
      this.phone2,
      this.email,
      this.subscription_end});
}
