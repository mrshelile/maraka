import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:maraka/pages/home/components/ListProductCard.dart';
import 'package:maraka/pages/home/components/section_title.dart';
import '../../../logic/store.dart';
import '../../../logic/user_logic.dart';
import '../../../size_config.dart';

class ProductList extends StatefulWidget {
  User owner;
  ProductList({Key? key, required this.owner}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final store = Get.find<StoreController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(350, context),
      child: ListView(
        children: [
          Padding(
            padding:
                EdgeInsets.only(left: getProportionateScreenWidth(38, context)),
            child: GetBuilder(
                init: store,
                builder: (_) {
                  return SectionTitle(
                      title: store.selectedCategory.toUpperCase());
                }),
          ),
          // SizedBox(height: getProportionateScreenWidth(20, context)),
          GetBuilder(
              init: store,
              builder: (_) {
                return store.ishomeProductsLoading
                    ? Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).copyWith().size.height *
                                0.06),
                        child: const SpinKitSpinningLines(
                          color: Color.fromARGB(255, 102, 198, 201),
                          size: 160,
                          // duration: Duration(milliseconds: 1000),
                        ),
                      )
                    : GridView.builder(
                        physics: const ScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount:store.products.length,
                        itemBuilder: (context, index) =>
                            ListProductCard(product: store.products[index]),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 0.6,
                                // mainAxisExtent: 280,
                                // mainAxisSpacing: 12,
                                crossAxisCount: 2,
                                ),
                      );
              })
        ],
      ),
    );
  }
}
