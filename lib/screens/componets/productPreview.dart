import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:maraka/logic/products_logic.dart';
import 'package:maraka/models/product.dart';
import 'package:maraka/size_config.dart';
import 'package:maraka/themes/color.dart';
import 'package:photo_view/photo_view.dart';

import '../../logic/store.dart';

// ignore: must_be_immutable
class ProductPreview extends StatefulWidget {
  Product product;
  ProductPreview({Key? key, required this.product}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProductPreviewState createState() => _ProductPreviewState();
}

class _ProductPreviewState extends State<ProductPreview> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).copyWith().size.width;
    final height = MediaQuery.of(context).copyWith().size.height;
    double _scale = 1.0;
    double _previousScale = 1.0;
    var imgs = [];
    for (var item in widget.product.images!) {
      imgs.add(PhotoView(
          imageProvider: NetworkImage(item.url),
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 2.5,
          initialScale: PhotoViewComputedScale.contained,
          backgroundDecoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
          )));
    }
    final store = Get.find<StoreController>();
    final ProductLogic logic = ProductLogic();
    return Scaffold(
        body: GetBuilder(
            init: store,
            builder: (controller) {
              return FutureBuilder(
                future: widget.product.seller!.makeAllInformationFromUrl(),
                builder: (context, snapshot) {
                  List<Widget> carInfo() {
                    return [
                      Container(
                          padding: EdgeInsets.only(
                              top: getProportionateScreenHeight(30, context),
                              left: getProportionateScreenWidth(25, context)),
                          width: width * 0.95,
                          child: Text(
                            "Transmission: ${widget.product.car != null ? widget.product.car['transmission'] : ''}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 80, 78, 78)),
                          )),
                      Container(
                          padding: EdgeInsets.only(
                              top: getProportionateScreenHeight(10, context),
                              left: getProportionateScreenWidth(25, context)),
                          width: width * 0.95,
                          child: Text(
                            "Mileage: ${widget.product.car != null ? widget.product.car['kilos'] : ''}Km",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 80, 78, 78)),
                          )),
                      Container(
                          padding: EdgeInsets.only(
                              top: getProportionateScreenHeight(10, context),
                              left: getProportionateScreenWidth(25, context)),
                          width: width * 0.95,
                          child: Text(
                            "Fuel: ${widget.product.car != null ? widget.product.car['fuel'] : ''}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 80, 78, 78)),
                          )),
                      Container(
                          padding: EdgeInsets.only(
                              top: getProportionateScreenHeight(10, context),
                              left: getProportionateScreenWidth(25, context)),
                          width: width * 0.95,
                          child: Text(
                            "Description: ${widget.product.description}",
                            maxLines: 10,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 80, 78, 78)),
                          )),
                    ];
                  }

                  List<Widget> otherInfo() {
                    return [
                      Container(
                          padding: EdgeInsets.only(
                              top: getProportionateScreenHeight(10, context),
                              left: getProportionateScreenWidth(25, context)),
                          width: width * 0.95,
                          child: Text(
                            "Description: ${widget.product.description}",
                            maxLines: 10,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 80, 78, 78)),
                          )),
                    ];
                  }

                  return SingleChildScrollView(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: <Widget>[
                        IconButton(
                            color: MyColors.black,
                            padding: EdgeInsets.only(
                                left: getProportionateScreenWidth(8, context),
                                top: getProportionateScreenHeight(20, context)),
                            onPressed: (() => Navigator.pop(context)),
                            icon: const Icon(Icons.arrow_back_ios)),
                        Container(
                            padding: EdgeInsets.only(
                                top: getProportionateScreenHeight(26, context),
                                left: getProportionateScreenWidth(9, context)),
                            width: width * 0.95,
                            child: const Text(
                              "Details",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 17),
                            )),
                        AspectRatio(
                          aspectRatio: 1.5,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8, left: 8, right: 8),
                            child: Container(
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(25))),
                              width: width,
                              child: Carousel(
                                autoplay: false,
                                dotBgColor: Colors.transparent,
                                dotSize: 0,
                                boxFit: BoxFit.cover,
                                borderRadius: true,
                                images: imgs,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                padding: EdgeInsets.only(
                                    top: getProportionateScreenHeight(
                                        6, context),
                                    left: getProportionateScreenWidth(
                                        20, context)),
                                width: width * 0.7,
                                child: Text(
                                  store.selectedCategory.toLowerCase() ==
                                              "cars" &&
                                          widget.product.car != null
                                      ? "${widget.product.car['make']}, ${widget.product.car['model']}, ${widget.product.car['year']}"
                                      : widget.product.title!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17),
                                )),
                            SizedBox(
                              width: width * 0.23,
                              child: Text(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                "Seen: ${widget.product.views}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 17),
                              ),
                            )
                          ],
                        ),
                        Container(
                            padding: EdgeInsets.only(
                                top: getProportionateScreenHeight(9, context),
                                left: getProportionateScreenWidth(25, context)),
                            width: width * 0.95,
                            child: Text(
                              "M${widget.product.price}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 98, 152, 184)),
                            )),
                        if (widget.product.category!.toLowerCase() == "cars")
                          ...carInfo(),
                        if (widget.product.category!.toLowerCase() != "cars")
                          ...otherInfo(),
                        Container(
                            padding: EdgeInsets.only(
                                top: getProportionateScreenHeight(15, context),
                                left: getProportionateScreenWidth(25, context)),
                            width: width * 0.95,
                            child: Text(
                              "Names: ${widget.product.seller!.fullNames ?? ""}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 80, 78, 78)),
                            )),
                        Container(
                            padding: EdgeInsets.only(
                                top: getProportionateScreenHeight(10, context),
                                left: getProportionateScreenWidth(25, context)),
                            width: width * 0.95,
                            child: Text(
                              "Email: ${widget.product.seller!.email ?? ""}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 80, 78, 78)),
                            )),
                        Container(
                            padding: EdgeInsets.only(
                                top: getProportionateScreenHeight(7, context),
                                left: getProportionateScreenWidth(25, context)),
                            width: width * 0.95,
                            child: Text(
                              "Phone Numbers: ${widget.product.seller!.phone1 ?? ""}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 80, 78, 78)),
                            )),
                        SizedBox(
                          height: height * 0.05,
                        )
                      ],
                    ),
                  );
                },
              );
            }));
  }
}
