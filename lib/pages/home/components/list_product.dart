import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:maraka/pages/home/components/list_product_card.dart';
import '../../../logic/store.dart';
import '../../../size_config.dart';

// ignore: must_be_immutable
class ProductList extends StatefulWidget {
  const ProductList({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final store = Get.find<StoreController>();
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(400, context),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          // color: Colors.amber,
          borderRadius: BorderRadius.circular(30)),
      child: GetBuilder(
        init: store,
        builder: (_) {
          return store.ishomeProductsLoading
              ? Container(
                  padding: EdgeInsets.only(
                      top:
                          MediaQuery.of(context).copyWith().size.height * 0.06),
                  child: const SpinKitSpinningLines(
                    color: Color.fromARGB(255, 102, 198, 201),
                    size: 160,
                    // duration: Duration(milliseconds: 1000),
                  ),
                )
              : GridView.builder(
                  physics: const ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  controller: _scrollController,
                  shrinkWrap: true,
                  itemCount: store.products.length,
                  itemBuilder: (context, index) =>
                      ListProductCard(product: store.products[index]),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.64,
                    crossAxisCount: 2,
                  ),
                );
        },
      ),
    );
  }
}
