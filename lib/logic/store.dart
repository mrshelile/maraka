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
  int currentPageProduct = 0;
  int lastProductPage = 0;
  @override
  onInit() async {
    super.onInit();
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
        await logic.getProducts( selectedCategory.toLowerCase());
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
        await logic.getProducts(selectedCategory.toLowerCase());
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
    update();
  }
}
