import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maraka/logic/store.dart';
import 'package:maraka/models/product.dart';

import 'list_product_card.dart';

// ignore: must_be_immutable
class ProductListPage extends StatefulWidget {
  List<Product> products;
  ProductListPage({super.key, required this.products});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final store = Get.find<StoreController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...List.generate(widget.products.length,
            (index) => ListProductCard(product: widget.products[index]))
      ],
    );
  }
}
