import 'package:get/get.dart';

class StoreController extends GetxController {
  var selectedCategory = "All";

  void selectCategory(String value) {
    selectedCategory = value;
    update();
  }
}
