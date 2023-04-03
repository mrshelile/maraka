import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maraka/logic/constants.dart';
import 'package:maraka/logic/products_logic.dart';
import 'package:maraka/logic/user_logic.dart';
import 'package:maraka/models/product.dart';
import 'package:maraka/pages/home/components/List_productPage.dart';

class StoreController extends GetxController {
  var selectedCategory = "Cars";
  var search = '';
  List<Product> products = [];
  List<Product> myProducts = [];
  List<Map<int, List<Product>>> pagesContents = [];

  void _generatePages() {
    // int carsTotal = 0, others = 0;
    // for (var element in products) {
    //   if (element.category.toString().toLowerCase() == 'cars') {
    //     carsTotal++;
    //   } else {
    //     others++;
    //   }
    // }
    // int pageEstimate = products.length % pageSize != 0
    //     ? products.length ~/ pageSize + 1
    //     : products.length ~/ pageSize;
    // int startadd = 0;
    // // print(pageEstimate);
    // int end = products.length > pageSize ? pageSize - 1 : products.length - 1;
    // int remaining = products.length > pageSize ? products.length - pageSize : 0;
    // for (var i = 0; i < pageEstimate; i++) {
    //   pagesContents.add({i + 1: products.sublist(startadd, end)});
    //   startadd += pageSize;
    //   end += pageSize;
    //   remaining -= pageSize;
    // }
    // print(pageEstimate);
    // pagesContents = [];
  }

  Future<List<Product>> setMyproducts(User owner) async {
    myProducts = [];
    var logic = ProductLogic();
    var ad = await logic.getMyAds(owner);
    for (Product element in ad) {
      myProducts.add(Product(
          views: element.views,
          title: element.title,
          description: element.description,
          price: element.price,
          expiryDate: element.expiryDate,
          id1: element.id1,
          id2: element.id2,
          seller: element.seller,
          images: element.images,
          car: element.car,
          category: element.category));
    }
    update();
    return ad;
  }

  void selectCategory(String value, User owner) async {
    selectedCategory = value;
    var logic = ProductLogic();

    List<Product> products =
        await logic.getProducts(owner, selectedCategory.toLowerCase());
    setProducts(products);
    //
    update();
  }

  void searchNow(String value) {
    search = value;
    update();
  }

  void onchangeCategory(User owner) async {
    var logic = ProductLogic();

    List<Product> products1 =
        await logic.getProducts(owner, selectedCategory.toLowerCase());
    setProducts(products1);

    update();
    // return products;
  }

  void setProducts(List<Product> data) {
    products = [];

    for (Product element in data) {
      products.add(Product(
          id1: element.id1,
          views: element.views,
          title: element.title,
          description: element.description,
          price: element.price,
          expiryDate: element.expiryDate,
          id2: element.id2,
          seller: element.seller,
          images: element.images,
          car: element.car,
          category: element.category));
    }
    // products.shuffle();
    // _generatePages();
    update();
  }
}
