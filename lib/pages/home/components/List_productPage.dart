import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:maraka/logic/store.dart';
import 'package:maraka/models/product.dart';
import 'package:maraka/pages/home/components/ListProductCard.dart';

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
