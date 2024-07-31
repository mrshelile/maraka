import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maraka/models/product.dart';
import 'package:maraka/size_config.dart';
import 'package:maraka/themes/color.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

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
    bool isZoomed = false; // Track the zoom-in state
    // int zoomIndex = 0;
    // double _scale = 1.0;
    int currentIndex = 0;
    // double _previousScale = 1.0;
    // var imgs = [];
    final List<PhotoViewGalleryPageOptions> imageList = widget.product.images!
        .map((item) => PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(item.url),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 2.5,
              initialScale: PhotoViewComputedScale.contained,
            ))
        .toList();
    final store = Get.find<StoreController>();
    // final ProductLogic logic = ProductLogic();
    void toggleZoomState() {
      setState(() {
        isZoomed = !isZoomed;
      });
    }

    Widget buildZoomedView(PhotoViewGalleryPageOptions imageOption) {
      return GestureDetector(
        onTap: toggleZoomState, // Toggle zoom state on tap
        child: PhotoView(
          imageProvider: imageOption.imageProvider,
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 2.5,
          initialScale: PhotoViewComputedScale.contained,
        ),
      );
    }

    // Widget buildProductDetails(double width) {

    // }
    List<Widget> carInfo() {
      return [
        Container(
            padding: EdgeInsets.only(
                top: getProportionateScreenHeight(30, context),
                left: getProportionateScreenWidth(25, context)),
            width: width * 0.95,
            child: Text(
              "Transmission: ${widget.product.car != null ? widget.product.car!['transmission'] : ''}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 16, color: Color.fromARGB(255, 80, 78, 78)),
            )),
        Container(
            padding: EdgeInsets.only(
                top: getProportionateScreenHeight(10, context),
                left: getProportionateScreenWidth(25, context)),
            width: width * 0.95,
            child: Text(
              "Mileage: ${widget.product.car != null ? widget.product.car!['kilos'] : ''}Km",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 16, color: Color.fromARGB(255, 80, 78, 78)),
            )),
        Container(
            padding: EdgeInsets.only(
                top: getProportionateScreenHeight(10, context),
                left: getProportionateScreenWidth(25, context)),
            width: width * 0.95,
            child: Text(
              "Fuel: ${widget.product.car != null ? widget.product.car!['fuel'] : ''}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 16, color: Color.fromARGB(255, 80, 78, 78)),
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
                  fontSize: 16, color: Color.fromARGB(255, 80, 78, 78)),
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
                  fontSize: 16, color: Color.fromARGB(255, 80, 78, 78)),
            )),
      ];
    }

    return Scaffold(
        body: GetBuilder(
            init: store,
            builder: (controller) {
              return FutureBuilder(
                future: widget.product.seller!.makeAllInformationFromUrl(),
                builder: (context, snapshot) {
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
                              child: PhotoViewGallery.builder(
                                itemCount: imageList.length,
                                builder: (BuildContext context, int index) {
                                  return PhotoViewGalleryPageOptions(
                                    imageProvider: NetworkImage(
                                        widget.product.images![index].url),
                                    minScale: PhotoViewComputedScale.contained,
                                    maxScale:
                                        PhotoViewComputedScale.covered * 2.5,
                                    initialScale:
                                        PhotoViewComputedScale.contained,
                                  );
                                },
                                loadingBuilder: (context, event) =>
                                    const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                backgroundDecoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                pageController:
                                    PageController(initialPage: currentIndex),
                                onPageChanged: (index) {
                                  setState(() {
                                    currentIndex = index;
                                  });
                                },
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
                                      ? "${widget.product.car!['make']}, ${widget.product.car!['model']}, ${widget.product.car!['year']}"
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
