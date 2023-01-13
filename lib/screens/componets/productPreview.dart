import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maraka/models/product.dart';
import 'package:maraka/themes/color.dart';

// ignore: must_be_immutable
class ProductPreview extends StatefulWidget {
  Product? product;
  ProductPreview({Key? key, this.product}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProductPreviewState createState() => _ProductPreviewState();
}

class _ProductPreviewState extends State<ProductPreview> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).copyWith().size.width;
    final height = MediaQuery.of(context).copyWith().size.height;
    var imgs = [];
    for (var item in widget.product!.images!) {
      imgs.add(NetworkImage(item.url));
    }
    return Scaffold(
        body: FutureBuilder(
            future: widget.product!.seller!.makeAllInformationFromUrl(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Stack(
                  children: <Widget>[
                    SizedBox(
                      width: width,
                      height: height * 0.5,
                      child: Stack(
                        children: [
                          Carousel(
                            dotBgColor: Colors.transparent,
                            dotSize: 0,
                            boxFit: BoxFit.scaleDown,
                            images: imgs,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: height * 0.03, left: width * 0.03),
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: MyColors.gold1,
                                size: 40,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.48),
                      child: Container(
                        height: height * 0.58,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(225, 245, 247, 247),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        width: width,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  top: height * 0.12, left: width * 0.05),
                              child: Row(
                                // ignore: prefer_const_literals_to_create_immutables
                                children: <Widget>[
                                  const Text(
                                    "Email: ",
                                    style: TextStyle(
                                        color: MyColors.gold1, fontSize: 17),
                                  ),
                                  Text(
                                    widget.product!.seller!.email.toString(),
                                    style: const TextStyle(fontSize: 17),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: height * 0.04, left: width * 0.05),
                              child: Row(
                                // ignore: prefer_const_literals_to_create_immutables
                                children: <Widget>[
                                  const Text(
                                    "Description",
                                    style: TextStyle(
                                        color: MyColors.gold1, fontSize: 17),
                                  ),
                                  const Icon(
                                    Icons.star,
                                    color: MyColors.blue3,
                                  )
                                ],
                              ),
                            ),
                            if (widget.product!.category
                                    .toString()
                                    .toLowerCase() ==
                                'cars')
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: height * 0.01, left: width * 0.05),
                                  child: SizedBox(
                                    height: height * 0.24,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Make: ${widget.product!.car['make']}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * 0.01,
                                          ),
                                          Text(
                                            "Model: ${widget.product!.car['model']}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * 0.01,
                                          ),
                                          Text(
                                            "Year: ${widget.product!.car['year'].toString()}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * 0.01,
                                          ),
                                          Text(
                                            "Transmission: ${widget.product!.car['transmission']}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * 0.01,
                                          ),
                                          Text(
                                            "Fuel: ${widget.product!.car['fuel']}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * 0.01,
                                          ),
                                          Text(
                                            "Mileage: ${widget.product!.car['kilos']}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 20.0,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            if (widget.product!.category
                                    .toString()
                                    .toLowerCase() !=
                                'cars')
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.01, left: width * 0.05),
                                child: SizedBox(
                                  height: height * 0.24,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Text(
                                      widget.product!.description!.toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.25, top: height * 0.43),
                      child: Container(
                        width: width * 0.47,
                        height: height * 0.10,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: height * 0.02),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  SizedBox(
                                    width: width * 0.35,
                                    child: Text(
                                      widget.product!.seller!.fullNames
                                          .toString(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: MyColors.gold1),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.sell,
                                    color: MyColors.blue2,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: width * 0.06),
                              child: Text(
                                  "- (+266)${widget.product!.seller!.phone1}"),
                            ),
                            // SizedBox(
                            //   height: height * 0.01,
                            // ),
                            // if (widget.product!.seller!.phone2 == null)
                            // Padding(
                            // padding: EdgeInsets.only(right: width * 0.06),
                            //child: Text(
                            //  "- (+266)${widget.product!.seller!.phone2!.toLowerCase()}"),
                            // ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              }
              return Container();
            }));
  }
}
