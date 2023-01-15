import 'package:get/get.dart';
import 'package:maraka/logic/products_logic.dart';
import 'package:maraka/logic/user_logic.dart';
import 'package:maraka/models/product.dart';

class StoreController extends GetxController {
  var selectedCategory = "Cars";
  var search = '';
  List<Product> products = [];
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
    products.shuffle();
    update();
  }
}
