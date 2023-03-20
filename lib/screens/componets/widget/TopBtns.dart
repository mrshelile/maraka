import 'package:flutter/material.dart';
import 'package:maraka/logic/products_logic.dart';
import 'package:maraka/models/product.dart';

import 'package:maraka/themes/color.dart';

class TopBTnsProductPreview extends StatefulWidget {
  Product product;
  TopBTnsProductPreview({Key? key, required this.product}) : super(key: key);

  @override
  State<TopBTnsProductPreview> createState() => _TopBTnsProductPreviewState();
}

class _TopBTnsProductPreviewState extends State<TopBTnsProductPreview> {
  @override
  Widget build(BuildContext context) {
    ProductLogic logic = ProductLogic();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: Colors.white),
          child: IconButton(
              onPressed: () async {
                print("delete pressed");
               var res= await logic.deleteProduct(widget.product.id1);
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              )),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: Colors.white),
          child: IconButton(
              onPressed: () {
                print("edit pressed");
              },
              icon: Icon(
                Icons.edit_note_rounded,
                color: MyColors.blue2,
              )),
        ),
      ],
    );
  }
}
