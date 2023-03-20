import 'package:get/get.dart';
import 'package:maraka/logic/products_logic.dart';
import 'package:maraka/logic/store.dart';
import 'package:maraka/logic/user_logic.dart';
import 'package:maraka/models/product.dart';
import 'package:maraka/models/products.dart';
import 'package:flutter/material.dart';
import 'package:maraka/screens/componets/productPreview.dart';
import 'package:maraka/screens/componets/widget/TopBtns.dart';
import 'package:maraka/screens/home.dart';
import 'package:maraka/themes/color.dart';

// ignore: must_be_immutable
class ProductsItem extends StatefulWidget {
  int product;
  bool isFavouritedPage = true;
  bool isFavouriteBtn = true;
  bool isFavouriteclicked = false;
  User owner;
  Function? getData;
  ProductsItem(
      {Key? key,
      this.getData,
      required this.isFavouritedPage,
      required this.owner,
      required this.product,
      required this.isFavouriteclicked,
      required this.isFavouriteBtn})
      : super(key: key);

  @override
  State<ProductsItem> createState() => _ProductsItemState();
}

class _ProductsItemState extends State<ProductsItem> {
  @override
  Widget build(BuildContext context) {
    final store = Get.find<StoreController>();
    if (widget.owner.email != null) {
      widget.isFavouriteclicked = store.myProducts[widget.product].isLiked;
    }
    final width = MediaQuery.of(context).copyWith().size.width;
    final height = MediaQuery.of(context).copyWith().size.height;

    return GetBuilder(
      init: store,
      builder: (_) {
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
          child: Stack(
            children: [
              // TopBTnsProductPreview(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductPreview(
                                product: store.myProducts[widget.product],
                              )));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8),
                      height: 170,
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          image: DecorationImage(
                              image: NetworkImage(store.myProducts[widget.product].images![0].url),
                              fit: BoxFit.fitHeight)),
                    ),
                    Text(
                      store.myProducts[widget.product].category!.toLowerCase() == "cars"
                          ? "${store.myProducts[widget.product].car['year'].toString()} ${store.myProducts[widget.product].car['make']} ${store.myProducts[widget.product].car['model']}"
                          : store.myProducts[widget.product].title!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, height: 1.7, fontSize: 18),
                    ),
                    Text(store.myProducts[widget.product].price!.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            height: 1.7,
                            fontSize: 17,
                            color: Color(0xff4f6612)))
                  ],
                ),
              ),
              TopBTnsProductPreview(
                product: widget.product,
              ),
            ],
          ),
        );
      }
    );
  }
}
