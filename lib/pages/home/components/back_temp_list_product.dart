// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:maraka/pages/home/components/section_title.dart';

// import '../../../logic/products_logic.dart';
// import '../../../logic/store.dart';
// import '../../../models/product.dart';
// import '../../../size_config.dart';
// import '../../../themes/color.dart';
// import 'list_product_card.dart';

// class ProductList extends StatefulWidget {
//   const ProductList({Key? key}) : super(key: key);

//   @override
//   State<ProductList> createState() => _ProductListState();
// }

// class _ProductListState extends State<ProductList> {
//   final store = Get.find<StoreController>();
//   Future<List<Product>> makeProductList() async {
//     var logic = ProductLogic();

//     List<Product> products =
//         await logic.getProducts(store.selectedCategory.toLowerCase());
//     store.setProducts(
//       products,
//     );
//     return products;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding:
//           EdgeInsets.only(bottom: getProportionateScreenHeight(270, context)),
//       height: getProportionateScreenHeight(650, context),
//       child: Stack(
//         children: [
//           ListView(
//             shrinkWrap: true,
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(
//                     left: getProportionateScreenWidth(38, context)),
//                 child: GetBuilder(
//                     init: store,
//                     builder: (_) {
//                       return SectionTitle(
//                           title: store.selectedCategory.toUpperCase());
//                     }),
//               ),
//               // SizedBox(height: getProportionateScreenWidth(20, context)),
//               FutureBuilder(
//                   future: makeProductList(),
//                   builder: ((context, snapshot) {
//                     return GetBuilder(
//                         init: store,
//                         builder: (_) {
//                           return Column(
//                             children: [
//                               ...List.generate(
//                                 store.productsFromdb.length,
//                                 (index) {
//                                   return store.search.isEmpty
//                                       ? ProductCard(
//                                           product: store.productsFromdb[index])
//                                       : store.selectedCategory.toLowerCase() !=
//                                               "cars"
//                                           ? store.productsFromdb[index].title!
//                                                   .toLowerCase()
//                                                   .toString()
//                                                   .contains(store.search
//                                                       .toLowerCase()
//                                                       .toString())
//                                               ? ProductCard(
//                                                   product: store
//                                                       .productsFromdb[index])
//                                               : Container()
//                                           : store.productsFromdb[index]
//                                                       .car['model']
//                                                       .toString()
//                                                       .toLowerCase()
//                                                       .contains(store.search
//                                                           .toLowerCase()) ||
//                                                   store.productsFromdb[index]
//                                                       .car['make']
//                                                       .toString()
//                                                       .toLowerCase()
//                                                       .contains(store.search
//                                                           .toLowerCase())
//                                               ? ProductCard(
//                                                   product: store
//                                                       .productsFromdb[index])
//                                               : Container();
//                                 },
//                               ),
//                               SizedBox(
//                                   width:
//                                       getProportionateScreenWidth(20, context)),
//                             ],
//                           );
//                         });
//                   })),
//             ],
//           ),
//           Positioned(
//             bottom: getProportionateScreenHeight(6, context),
//             child: MaterialButton(
//               color: MyColors.blue3,
//               shape: CircleBorder(),
//               onPressed: () {},
//               child: const Icon(
//                 Icons.arrow_back,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//           Positioned(
//             right: getProportionateScreenWidth(13, context),
//             bottom: getProportionateScreenHeight(6, context),
//             child: MaterialButton(
//               color: MyColors.blue3,
//               shape: CircleBorder(),
//               onPressed: () {},
//               child: const Icon(
//                 Icons.arrow_forward,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
