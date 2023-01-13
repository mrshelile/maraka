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
    this.aspectRetio = 5 / 3,
    required this.product,
  }) : super(key: key);

  final double width, aspectRetio;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        debugPrint(constraints.toString());
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
                      color: const Color.fromARGB(221, 199, 211, 211)
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).copyWith().size.width *
                              0.45,
                          height: MediaQuery.of(context).copyWith().size.height,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(221, 199, 211, 211)
                                .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Hero(
                            tag: product.id1.toString() +
                                Random().nextInt(90).toString(),
                            child: Image.network(
                              product.images![0].url,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        AspectRatio(
                          aspectRatio: 0.7,
                          child: Container(
                            padding: EdgeInsets.only(left: 7, top: 15),
                            width: 190,
                            height: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  "2016 BMW X5 XDrive30d auto",
                                  textScaleFactor: 5 / 3.5,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: SizedBox(
                                    child: Text(
                                        style: TextStyle(color: MyColors.blue2),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        "M123 000"),
                                  ),
                                ),
                               if(constraints.maxWidth>=294) Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: SizedBox(
                                    child: Text(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        "123.035Km | Automatic | Petrol"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
            ),
          ),
        );
      },
    );
  }
}
