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
  bool ishomeProductsLoading = false;

  @override
  onInit() async {
    super.onInit();
    final logic = ProductLogic();
    ishomeProductsLoading = true;
    try {
      var res = await logic.getProducts(selectedCategory);
      setProducts(res);
    } finally {
      ishomeProductsLoading = false;
      update();
    }
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
    if (selectedCategory != value) {
      productsFromdb = [];
    }
    selectedCategory = value;
    update();
    var logic = ProductLogic();
    ishomeProductsLoading = true;

    List<Product> products =
        await logic.getProducts(selectedCategory.toLowerCase());
    setProducts(products);
    ishomeProductsLoading = false;
    update();
  }

  void searchNow(String value) {
    search = value;
    var temp = productsFromdb;
    products = [];
    if (search.isNotEmpty) {
      if (selectedCategory.toLowerCase() == 'cars') {
        for (var element in temp) {
          if (element.car['model']
                  .toString()
                  .toLowerCase()
                  .contains(search.toLowerCase()) ||
              element.car['make']
                  .toString()
                  .toLowerCase()
                  .contains(search.toLowerCase())) {
            products.add(element);
          }
        }
      } else {
        for (var element1 in temp) {
          if (element1.title
              .toString()
              .toLowerCase()
              .contains(search.toLowerCase())) {
            products.add(element1);
          }
        }
      }
    } else {
      products = temp;
    }
    print(products);
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

  List<Product> subSetProducts(List<Product> data) {
    List<Product> results = [];
    for (var element in data) {
      var product = Product(
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
          category: element.category);
      bool doesExist = productsFromdb.any((element) =>
          element.id1 == product.id1 || element.id2 == product.id2);
      if (!doesExist) {
        results.add(product);
      }
    }
    return results;
  }

  void setProducts(List<Product> data) {
    if (selectedCategory == categories[0]['text']) {
      productsFromdb = subSetProducts(data);
    } else {
      subSetProducts(data);
    }

    pageFilter();
  }
}
