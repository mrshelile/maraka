import 'package:maraka/logic/products_logic.dart';
import 'package:maraka/logic/user_logic.dart';
import 'package:maraka/models/product.dart';
import 'package:maraka/models/products.dart';
import 'package:flutter/material.dart';
import 'package:maraka/screens/componets/productPreview.dart';
import 'package:maraka/screens/home.dart';
import 'package:maraka/themes/color.dart';

// ignore: must_be_immutable
class ProductsItem extends StatefulWidget {
  final Recents recents;
  Product product;
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
      required this.recents,
      required this.isFavouriteBtn})
      : super(key: key);


  @override
  State<ProductsItem> createState() => _ProductsItemState();
}

class _ProductsItemState extends State<ProductsItem> {
  @override
  Widget build(BuildContext context) {
    if (widget.owner.email != null) {
      widget.isFavouriteclicked = widget.product.isLiked;
    }
    final width = MediaQuery.of(context).copyWith().size.width;
    final height = MediaQuery.of(context).copyWith().size.height;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductPreview(
                      product: widget.product,
                    )));
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(children: [
              Container(
                margin: const EdgeInsets.all(8),
                height: 170,
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    image: DecorationImage(
                        image: NetworkImage(widget.recents.imgUrl!),
                        fit: BoxFit.fitHeight)),
              ),
              
            ]),
            Text(
              widget.recents.name!,
              style: const TextStyle(fontWeight: FontWeight.bold, height: 1.5),
            ),
            // Text(
            //   widget.recents.name!,
            //   style: const TextStyle(fontWeight: FontWeight.bold, height: 1.5),
            // ),
            Text(widget.recents.price!,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                    color: Color(0xff4f6612)))
          ],
        ),
      ),
    );
  }
}
