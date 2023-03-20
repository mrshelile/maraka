import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maraka/logic/products_logic.dart';
import 'package:maraka/logic/store.dart';
import 'package:maraka/models/product.dart';

import 'package:maraka/themes/color.dart';

class TopBTnsProductPreview extends StatefulWidget {
  int product;
  TopBTnsProductPreview({Key? key, required this.product}) : super(key: key);

  @override
  State<TopBTnsProductPreview> createState() => _TopBTnsProductPreviewState();
}

class _TopBTnsProductPreviewState extends State<TopBTnsProductPreview> {
  @override
  Widget build(BuildContext context) {
    ProductLogic logic = ProductLogic();
    final store = Get.find<StoreController>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: Colors.white),
          child: IconButton(
              onPressed: () async {
                await confirmDialog(
                    context: context,
                    store: store,
                    product: widget.product,
                    logic: logic);
                // var res = await logic
                //     .deleteProduct(store.myProducts[widget.product].id1);
                // store.myProducts.removeAt(widget.product);
                // store.update();
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

confirmDialog(
    {required BuildContext context,
    required StoreController store,
    required int product,
    required ProductLogic logic}) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm'),
          content: Text("Are you sure?"),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(backgroundColor: MyColors.blue3),
              child: Text(
                'No',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              child: Text(
                'Yes',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                var res =
                    await logic.deleteProduct(store.myProducts[product].id1);
                if (res.statusCode == 204) {
                  store.myProducts.removeAt(product);
                  store.update();
                  Navigator.of(context).pop();
                }
              },
            )
          ],
        );
      });
}
