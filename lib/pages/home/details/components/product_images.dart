import 'package:flutter/material.dart';
import 'package:maraka/logic/constants.dart';
import 'package:maraka/models/product.dart';
import 'package:maraka/size_config.dart';
import 'package:maraka/themes/color.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  // ignore: library_private_types_in_public_api
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: getProportionateScreenWidth(238, context),
          child: AspectRatio(
            aspectRatio: 1,
            child: Hero(
              tag: widget.product.id1.toString(),
              child: Image.network(widget.product.images![selectedImage].url),
            ),
          ),
        ),
        // SizedBox(height: getProportionateScreenWidth(20)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(widget.product.images!.length,
                (index) => buildSmallProductPreview(index)),
          ],
        )
      ],
    );
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
        duration: defaultDuration,
        margin: const EdgeInsets.only(right: 15),
        padding: const EdgeInsets.all(8),
        height: getProportionateScreenWidth(48, context),
        width: getProportionateScreenWidth(48, context),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color:
                  MyColors.blue2.withOpacity( selectedImage == index ? 1 : 0)),
        ),
        // child: Image.asset(widget.product.images[index]),
        child: Image.network(widget.product.images![index].url),
      ),
    );
  }
}
