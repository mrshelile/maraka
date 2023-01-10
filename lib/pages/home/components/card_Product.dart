import 'dart:math';

import 'package:flutter/material.dart';
import 'package:maraka/models/product.dart';
import 'package:maraka/pages/home/details/details_screen.dart';
import 'package:maraka/screens/componets/productPreview.dart';
import 'package:maraka/size_config.dart';
import 'package:maraka/themes/color.dart';

// import 'Product.dart';

class ListProductCard extends StatelessWidget {
  const ListProductCard({
    Key? key,
    this.width = 320,
    this.aspectRetio = 5/2,
    required this.product,
  }) : super(key: key);

  final double width, aspectRetio;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: getProportionateScreenHeight(15, context),
          left: getProportionateScreenWidth(15, context)),
      child: SizedBox(
        width: getProportionateScreenWidth(width, context),
        child: GestureDetector(
          onTap: () => {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductPreview(
                          product: product,
                        )))
          },
          child: AspectRatio(
              aspectRatio: aspectRetio,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Color.fromARGB(68, 102, 99, 99),
                      width: 0.8,
                      style: BorderStyle.solid),
                  color:
                      const Color.fromARGB(221, 199, 211, 211).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).copyWith().size.width * 0.5,
                      height: MediaQuery.of(context).copyWith().size.height,
                      padding: EdgeInsets.all(
                          getProportionateScreenWidth(20, context)),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(221, 199, 211, 211)
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Hero(
                        tag: product.id1.toString() +
                            Random().nextInt(90).toString(),
                        child: Image.network(product.images![0].url),
                      ),
                    ),
                    Text("data")
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
