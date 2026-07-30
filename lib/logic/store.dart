import 'package:get/get.dart';

import '../models/product.dart';
import 'constants.dart';
import 'products_logic.dart';
import 'user_logic.dart';

class StoreController extends GetxController {
  final _selectedCategory = "Cars".obs;
  var search = '';
  List<Product> productsFromdb = [];
  List<Product> products = [];
  List<Product> myProducts = [];
  int currentPageProduct = 1;
  int pageStart = 0;
  int pageEnd = pageSize;
  bool ishomeProductsLoading = false;

  String get selectedCategory => _selectedCategory.value;

  set selectedCategory(String value) {
    _selectedCategory.value = value;
  }

  @override
  onInit() async {
    super.onInit();
    await loadProducts();
  }

  Future<bool> loadProducts() async {
    try {
      ishomeProductsLoading = true;
      update();

      final logic = ProductLogic();
      final res = await logic.getProducts(selectedCategory);
      setProducts(res);
      ishomeProductsLoading = false;
      update();
      return true;
    } catch (e) {
      ishomeProductsLoading = false;
      update();
      return false;
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
    selectedCategory = value;
    update();
    ishomeProductsLoading = true;
    products = [];
    productsFromdb = [];
    update();

    try {
      final logic = ProductLogic();
      final loadedProducts = await logic.getProducts(selectedCategory);
      setProducts(loadedProducts);
    } catch (e) {
      products = [];
      productsFromdb = [];
    } finally {
      ishomeProductsLoading = false;
      update();
    }
  }

  void searchNow(String value) {
    search = value;
    var temp = productsFromdb;
    products = [];
    if (search.isNotEmpty) {
      if (selectedCategory.toLowerCase() == 'cars') {
        for (var element in temp) {
          if (element.car!['model']
                  .toString()
                  .toLowerCase()
                  .contains(search.toLowerCase()) ||
              element.car!['make']
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
