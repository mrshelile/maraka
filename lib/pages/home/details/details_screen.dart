import 'package:flutter/material.dart';
import 'package:maraka/models/product.dart';
import 'components/body.dart';
import 'components/custom_app_bar.dart';

// ignore: must_be_immutable
class DetailsScreen extends StatefulWidget {
  Product agrs;
  DetailsScreen({Key? key, required this.agrs}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    // final ProductDetailsArguments agrs =
    //     ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F9),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: CustomAppBar(),
      ),
      body: Body(product: widget.agrs),
    );
  }
}

class ProductDetailsArguments {
  final Product product;

  ProductDetailsArguments({required this.product});
}
