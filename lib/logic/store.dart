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
  List<Product> productsFromdb = [];
  List<Product> products = [];
  List<Product> myProducts = [];
  int currentPageProduct = 1;
  int pageStart = 0;
  int pageEnd = pageSize;

  @override
  onInit() async {
    super.onInit();
    final logic = ProductLogic();
    var res = await logic.getProducts(selectedCategory);
    setProducts(res);
  }

  void pageUp() {
    pageStart = pageEnd;
    pageEnd += pageSize;
  }

  void pageDown() {
    pageEnd = pageStart;
    pageStart -= pageSize;
  }

  void pageFilter() {
    if (pageStart > -1) {
      if (pageEnd <= productsFromdb.length) {
        products = productsFromdb.sublist(pageStart, pageEnd);
      } else {
        if (pageStart <= productsFromdb.length) {
         
          products = productsFromdb.sublist(pageStart, productsFromdb.length);
        }
      }
    }
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

  Future selectCategory(String value, User owner) async {
    selectedCategory = value;
    var logic = ProductLogic();

    List<Product> products =
        await logic.getProducts(selectedCategory.toLowerCase());
    setProducts(products);
    
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
    productsFromdb = [];

    for (Product element in data) {
      productsFromdb.add(Product(
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

      // products.shuffle();
    }
    products = productsFromdb;

    pageFilter();
    update();
  }
}
