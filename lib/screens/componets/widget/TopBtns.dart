import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maraka/logic/products_logic.dart';
import 'package:maraka/logic/store.dart';
import 'package:maraka/logic/user_logic.dart';
import 'package:maraka/models/product.dart';
import 'package:maraka/pages/EditAd.dart';
import 'package:maraka/screens/home.dart';

import 'package:maraka/themes/color.dart';

class TopBTnsProductPreview extends StatefulWidget {
  int product;
  User owner;
  TopBTnsProductPreview({Key? key, required this.product, required this.owner})
      : super(key: key);

  @override
  State<TopBTnsProductPreview> createState() => _TopBTnsProductPreviewState();
}

class _TopBTnsProductPreviewState extends State<TopBTnsProductPreview> {
  @override
  Widget build(BuildContext context) {
    ProductLogic logic = ProductLogic();
    final store = Get.find<StoreController>();
    return GetBuilder(
        init: store,
        builder: (_) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
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
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    )),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
                child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditAdForm(
                                    product: widget.product,
                                    owner: widget.owner,
                                  )));
                      Get.to(context);
                    },
                    icon: const Icon(
                      Icons.edit_note_rounded,
                      color: MyColors.blue2,
                    )),
              ),
            ],
          );
        });
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
          title: const Text('Confirm'),
          content: const Text("Are you sure?"),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(backgroundColor: MyColors.blue3),
              child: const Text(
                'No',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                var res =
                    await logic.deleteProduct(store.myProducts[product].id1);
                if (res.statusCode == 204) {
                  store.myProducts.removeAt(product);
                  store.update();
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                }
              },
            )
          ],
        );
      });
}
