import 'package:get/get.dart';
import 'package:maraka/logic/constants.dart';
import 'package:maraka/logic/user_logic.dart';
import 'package:maraka/models/ImageStrapi.dart';
import 'package:maraka/models/product.dart';

class StoreController extends GetxController {
  var selectedCategory = "All";
  List<Product> products = [];
  void selectCategory(String value) {
    selectedCategory = value;
    update();
  }

  void setProducts() {
    products = [
      Product(
        title: "Wireless Controller for PS4™",
        description: "Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing …",
        price: 56.7,
        expiryDate: DateTime.now(),
        id2: "sds5",
        id1: 1,
        seller: Seller(
          fullNames: "Thuto Shelile",
          phone1: "(+266) 6943334",
          email: "email3@email.com"
        ), 
        images: [
          ImageStrapi(
          name: "name0",
          url:"$server/uploads/image_picker5044624901605407229_1b2e18d817.jpg?updated_at=2022-08-18T08:05:08.992Z" 
          ),
          ImageStrapi(
          name: "name1",
          url:"$server/uploads/shop_990fcf64b6.jpg?updated_at=2022-08-18T14:22:26.200Z" 
        )], 
        isLiked: true, 
        category: "cars"
        ),
        Product(
        title: "Wireless Controller for PS4™",
        description: "Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing …",
        price: 56.7,
        expiryDate: DateTime.now(),
        id2: "sds",
        id1: 2,
        seller: Seller(
          fullNames: "Malefetsane Shelile",
          phone1: "(+266) 69356845",
          email: "email1@email.com"
        ), 
        images: [
          ImageStrapi(
          name: "name1",
          url:"$server/uploads/shop_990fcf64b6.jpg?updated_at=2022-08-18T14:22:26.200Z" 
        )], 
        isLiked: true, 
        category: "other"
        )

    ];
    update();
  }
}
