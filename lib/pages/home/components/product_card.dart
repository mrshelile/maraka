import 'dart:math';

import 'package:flutter/material.dart';
import 'package:maraka/models/product.dart';
import 'package:maraka/pages/home/details/details_screen.dart';
import 'package:maraka/screens/componets/productPreview.dart';
import 'package:maraka/size_config.dart';
import 'package:maraka/themes/color.dart';

// import 'Product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.product,
  }) : super(key: key);

  final double width, aspectRetio;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20, context)),
      child: SizedBox(
        width: getProportionateScreenWidth(width, context),
        height: getProportionateScreenHeight(
            MediaQuery.of(context).copyWith().size.height * 0.35, context),
        child: GestureDetector(
          onTap: () => {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductPreview(
                          product: product,
                        )))
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.02,
                child: Container(
                  padding:
                      EdgeInsets.all(getProportionateScreenWidth(20, context)),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Color.fromARGB(68, 102, 99, 99),
                        width: 0.8,
                        style: BorderStyle.solid),
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
              ),
              const SizedBox(height: 10),
              Text(
                product.title.toString(),
                // style: TextStyle(color: Colors.black),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "M${product.price}",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(18, context),
                      fontWeight: FontWeight.w600,
                      color: MyColors.blue4,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
