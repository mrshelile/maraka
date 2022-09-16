// // ignore_for_file: non_constant_identifier_names

// import 'dart:math';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:maraka/logic/banner_logic.dart';
// import 'package:maraka/logic/products_logic.dart';
// import 'package:maraka/logic/user_logic.dart';
// import 'package:maraka/models/product.dart';
// import 'package:maraka/models/products.dart';
// import 'package:maraka/themes/background.dart';
// import 'package:maraka/logic/constants.dart';
// import 'package:maraka/screens/componets/widget/products_item.dart';
// import 'package:maraka/themes/color.dart';
// // ignore: import_of_legacy_library_into_null_safe
// import 'package:carousel_pro/carousel_pro.dart';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// // import 'package:flutter_svg/svg.dart';
// import 'package:flutter_svg_provider/flutter_svg_provider.dart';


// const cellRed = Color(0xffc73232);
// const cellMustard = Color(0xffd7aa22);
// const cellGrey = Color(0xffcfd4e0);
// const cellBlue = Color(0xff1553be);
// const background = Color(0xff242830);

// // ignore: must_be_immutable
// class HomePage extends StatefulWidget {
//   User owner;
//   HomePage({Key? key, required this.owner}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   List<Product> products = [];
//   double value = 0;
//   var selected_category = "All";
//   final List<String> _pageCategories = [];
//   List<dynamic> bottomImgs = [
//     {"image": const AssetImage("assets/alldata.png"), "url": server},
//     {"image": const AssetImage("assets/payment.png"), "url": server}
//   ];
//   // Widget imageCarousel = Carousel(
//   //   boxFit: BoxFit.fill,
    
//   //   images: [
//   //     SvgPicture.asset(
//   //       "assets/market.svg",
//   //     ),
//   //   ],
//   // );
//   Widget imageCarousel = CarouselSlider(
//     items:  [
//     Container(
//       margin: const EdgeInsets.all(5.0),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10.0),
//         image:  const DecorationImage(
//           image: Svg('assets/connect.svg'),
//           fit: BoxFit.cover
//         )
//       ),
//       // child: SvgPicture.asset(
//       //   "assets/connect.svg",
//       // ),
//     ),
//     ], 
//     options: CarouselOptions(
//       height: 200,
//       aspectRatio: 16/9,
//       viewportFraction: 0.8,
//       initialPage: 0,
//       enableInfiniteScroll: true,
//       reverse: false,
//       autoPlay: true,
//       autoPlayInterval: const Duration(seconds: 3),
//       autoPlayAnimationDuration: const Duration(microseconds: 200),
//       autoPlayCurve: Curves.fastOutSlowIn,
//       enlargeCenterPage: true,
//       scrollDirection: Axis.horizontal
//       ),
//   );
//   Future<dynamic> getAllData() async {
//     var resp1 = await makeBanner();
//     if (resp1 != null) {
//       if (resp1.statusCode == 200) {
//         var resp2 = await makeBottomBanner();
//         if (resp2 != null) {
//           if (resp2.statusCode == 200) {
//             var resp = await makeProductList();
//             products = resp;

//             return resp;
//           }
//         }
//       }
//     }

//     return Null;
//   }

//   Future<List<Product>> makeProductList() async {
//     var logic = ProductLogic();
//     List<Product> products =
//         await logic.getProducts(widget.owner, selected_category.toLowerCase());

//     return products;
//   }

//   Future makeBottomBanner() async {
//     var logic = BannerLogic();
//     await logic.getBottomBanner();
//     if (logic.response != null) {
//       bottomImgs = [];
//       if (logic.response.statusCode == 200) {
//         for (var item in logic.bannersBottom) {
//           if (item.display != null) {
//             if (item.display['data'] != null) {
//               if (item.display['data']['attributes'] != null) {
//                 if (item.display['data']['attributes']['url'] != null) {
//                   bottomImgs.add({
//                     "image": NetworkImage(
//                         server + item.display['data']['attributes']['url']),
//                     "url": item.url
//                   });
//                 }
//               }
//             }
//           }
//         }
//       }
//     }
//     return logic.response;
//   }

// Future makeBanner() async {
//     var logic = BannerLogic();
//     await logic.getHomeScreenTop();
//     if (logic.response != null) {
//       if (logic.response.statusCode == 200) {
//         List<dynamic> imgs = [];
//         if (logic.bannersHomeScreen.isNotEmpty) {
//           for (var item in logic.bannersHomeScreen) {
//             bool skip = false;
//             if (item.display != null) {
//               if (item.display['data'] != null) {
//                 if (item.display['data']['attributes'] != null) {
//                   if (item.display['data']['attributes']['url'] != null) {
//                     imgs.add( NetworkImage(
//                         server + item.display['data']['attributes']['url']));
//                     // imgs.add(NetworkImage(
//                     //     "https://www.freepngimg.com/thumb/advertising/11-2-advertising-png-clipart-thumb.png"));
//                   }
//                 }
//               }
//             }
//           }
//           // imageCarousel = Carousel(
//           //   // dotHorizontalPadding: 10.0,
//           //   dotBgColor: Colors.transparent,
//           //   boxFit: BoxFit.fill,
//           //   images: imgs,
//           //   dotColor: MyColors.goldFusion,
//           //   dotIncreasedColor: MyColors.blue2,
//           // );
//              imageCarousel = CarouselSlider(
//               items: imgs.map((item) => Container(
//               margin: const EdgeInsets.all(5.0),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10.0),
//                   image:   DecorationImage(
//                     image: item,
//                     fit: BoxFit.cover
//                   )
//                 ),
//                 // child: Align(
//                 //   alignment: Alignment.bottomRight,
//                 //   child: Container(
//                 //     width:MediaQuery.of(context).copyWith().size.width*0.25,
//                 //     height: MediaQuery.of(context).copyWith().size.height*0.07,
//                 //     decoration:  const BoxDecoration(
//                 //     boxShadow: [
//                 //       BoxShadow(
//                 //         color: Colors.white,
//                 //         spreadRadius: 1,
//                 //         blurRadius: 2,
//                 //       )
//                 //       ],
//                 //     gradient: LinearGradient(
//                 //       begin: Alignment.topLeft,
//                 //       end: Alignment.bottomRight,
//                 //       stops: [
//                 //         0.2,
//                 //         0.4,
//                 //         0.6
//                 //       ],
//                 //       colors: [
//                 //         MyColors.blue2,
//                 //         MyColors.blue3,
//                 //         MyColors.blue2,
//                 //         ]),
//                 //       borderRadius:BorderRadius.only(topLeft: Radius.circular(15.0)) 
//                 //     ),
//                 //     child: GestureDetector(
//                 //       onTap: (() {
                        
//                 //       }),
//                 //       child: const Center(
//                 //         child: Text("CHECK",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
//                 //       ),
//                 //     ),
//                 //   ),
//                 // ),
//               )).toList(),
//               options: CarouselOptions(
//                 aspectRatio: 16/9,
//                 viewportFraction: 0.8,
//                 initialPage: 0,
//                 height: 180.0,
//                 enableInfiniteScroll: true,
//                 reverse: false,
//                 autoPlay: true,
//                 autoPlayInterval: const Duration(seconds: 3),
//                 autoPlayAnimationDuration: const Duration(microseconds: 800),
//                 autoPlayCurve: Curves.slowMiddle,
//                 enlargeCenterPage: true,
//                 scrollDirection: Axis.horizontal
//                 ),
//             );
//         }
//       }
//     }
//     return logic.response;
//   }

//   @override
//   void initState() {
//     categories.forEach((key, value) {
//       _pageCategories.add(key);
//     });
//     setState(() {
//       selected_category = "All".toLowerCase();
//     });

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // ProductLogic productLogic = ProductLogic();
//     // productLogic.getProduct(1);
//     var height = MediaQuery.of(context).copyWith().size.height;
//     var width = MediaQuery.of(context).copyWith().size.width;
//     return Stack(
//       children: <Widget>[
//         Container(
//           decoration: const BoxDecoration(
//               gradient: LinearGradient(
//             colors: [MyColors.blue3, MyColors.blue2],
//             begin: Alignment.bottomCenter,
//             end: Alignment.topCenter,
//           )),
//         ),
//         Container(
//           margin: EdgeInsets.only(
//               top: MediaQuery.of(context).copyWith().size.height * 0.04,
//               left: MediaQuery.of(context).copyWith().size.width * 0.05),
//           height: MediaQuery.of(context).copyWith().size.height * 0.2,
//           width: MediaQuery.of(context).copyWith().size.width * 0.4,
//           child: Image.asset(
//             "assets/maraka.png",
//           ),
//         ),
//         SafeArea(
//             child: SizedBox(
//           width: MediaQuery.of(context).copyWith().size.width * 0.5,
//           // padding: EdgeInsets.all(5.0),

//           child: Padding(
//             padding: EdgeInsets.only(
//                 top: MediaQuery.of(context).copyWith().size.height * 0.2,
//                 left: MediaQuery.of(context).copyWith().size.width * 0.03),
//             child: ListView.builder(
//               itemCount: _pageCategories.length,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: EdgeInsets.only(
//                       top: MediaQuery.of(context).copyWith().size.height *
//                           0.025),
//                   child: GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         selected_category =
//                             _pageCategories[index].toLowerCase();

//                         print(selected_category);
//                       });
//                     },
//                     child: Container(
//                         decoration: BoxDecoration(
//                             color: selected_category.toLowerCase().toString() !=
//                                     _pageCategories[index].toLowerCase()
//                                 ? MyColors.blue4
//                                 : MyColors.oldGold,
//                             boxShadow: [
//                               BoxShadow(
//                                   color: MyColors.brown1.withOpacity(0.6),
//                                   spreadRadius: 1,
//                                   blurRadius: 4,
//                                   offset: const Offset(0, 5))
//                             ],
//                             borderRadius: BorderRadius.circular(10),
//                             border:
//                                 Border.all(color: MyColors.blue2, width: 1.5)),
//                         padding: const EdgeInsets.all(5),
//                         child: Center(
//                           child: Text(
//                             categories.values.elementAt(index),
//                             style: const TextStyle(
//                                 color: Colors.white, fontSize: 17),
//                           ),
//                         )),
//                   ),
//                 );
//               },
//             ),
//           ),
//         )),
//         TweenAnimationBuilder(
//             tween: Tween<double>(begin: 0, end: value),
//             duration: const Duration(milliseconds: 500),
//             builder: (_, double val, __) {
//               return Transform(
//                 alignment: Alignment.center,
//                 transform: Matrix4.identity()
//                   ..setEntry(3, 2, 0.001)
//                   ..setEntry(0, 3, 200 * val)
//                   ..rotateY(pi / 6 * value),
//                 child: Scaffold(
//                   body: Stack(
//                     children: <Widget>[
//                       CustomPaint(
//                         painter: BackgroundDesign(),
//                         child: Container(),
//                       ),
//                       FutureBuilder<dynamic>(
//                           future: getAllData(),
//                           builder: (context, AsyncSnapshot snapshot) {
//                             return Column(
//                               children: <Widget>[
//                                 SizedBox(
//                                   height: height * 0.05,
//                                 ),
//                                 imageCarousel,
//                                 // Container(
//                                 //   decoration: BoxDecoration(
//                                 //     boxShadow: [
//                                 //       BoxShadow(
//                                 //           color: const Color.fromARGB(255, 200, 220, 224)
//                                 //               .withOpacity(0.8),
//                                 //           spreadRadius: 1,
//                                 //           blurRadius: 4,
//                                 //           offset: const Offset(0, 5))
//                                 //     ],
//                                 //   ),
//                                 //   height: MediaQuery.of(context)
//                                 //           .copyWith()
//                                 //           .size
//                                 //           .height *
//                                 //       0.30,
//                                 //   width: width,
//                                 //   child: Stack(
//                                 //     children: [
//                                 //       Container(
//                                 //         color: Colors.white.withOpacity(0.8),
//                                 //       ),
//                                 //       imageCarousel,
//                                 //     ],
//                                 //   ),
//                                 // ),
//                                 // SizedBox(
//                                 //   height: height * 0.01,
//                                 // ),
//                                 SizedBox(
//                                   height: height * 0.03,
//                                 ),
//                                 Text(
//                                   categories[selected_category].toUpperCase(),
//                                   style: const TextStyle(
//                                       fontSize: 18, color: MyColors.oldGold),
//                                 ),
//                                 Expanded(
//                                   child: SizedBox(
//                                     // decoration: BoxDecoration(
//                                     //     border: Border.all(color: Colors.black)),
//                                     height: height * 0.4,
//                                     width: width,
//                                     child: GridView.builder(
//                                         itemCount: products.length,
//                                         gridDelegate:
//                                             const SliverGridDelegateWithFixedCrossAxisCount(
//                                                 //childAspectRatio: 2,
//                                                 mainAxisExtent: 280,
//                                                 mainAxisSpacing: 12,
//                                                 crossAxisCount: 2,
//                                                 crossAxisSpacing: 10),
//                                         itemBuilder: (context, index) =>
//                                             ProductsItem(
//                                               isFavouritedPage: false,
//                                               getData: makeProductList,
//                                               owner: widget.owner,
//                                               isFavouriteclicked: false,
//                                               isFavouriteBtn: true,
//                                               product: products[index],
//                                               recents: Recents.generateHome(
//                                                 products,
//                                               )[index],
//                                             )),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.only(
//                                       top: height * 0.02,
//                                       bottom: height * 0.02),
//                                   child: const Text(
//                                     "Featured Ads",
//                                     style: TextStyle(
//                                         fontSize: 18, color: MyColors.gold1),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: height * 0.1,
//                                   width: width,
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: <Widget>[
//                                       Builder(builder: (context) {
//                                         return GestureDetector(
//                                           onTap: () async {
//                                             if (bottomImgs.isNotEmpty) {
//                                               // ignore: prefer_interpolation_to_compose_strings
//                                               if (!await launch("http://" +
//                                                   bottomImgs[0]["url"])) {
//                                                 print("failed launching");
//                                               } else {
//                                                 print("should launch");
//                                               }
//                                             }
//                                           },
//                                           child: Container(
//                                             // margin: const EdgeInsets.all(8),
//                                             // height: height*0.3,
//                                             width: width * 0.44,
//                                             decoration: BoxDecoration(
//                                                 borderRadius:
//                                                     BorderRadius.circular(13),
//                                                 image: DecorationImage(
//                                                     image: bottomImgs.isNotEmpty
//                                                         ? bottomImgs[0]["image"]
//                                                         : const AssetImage(
//                                                             "assets/products.png"),
//                                                     fit: BoxFit.fitHeight)),
//                                           ),
//                                         );
//                                       }),
//                                       GestureDetector(
//                                         onTap: () async {
//                                           if (bottomImgs.isNotEmpty) {
//                                             // ignore: prefer_interpolation_to_compose_strings
//                                             if (!await launch("http://" +
//                                                 bottomImgs[1]["url"])) {
//                                               print("failed launching");
//                                             } else {
//                                               print("should launch");
//                                             }
//                                           }
//                                         },
//                                         child: Container(
//                                           // margin: const EdgeInsets.all(8),
//                                           // height: 170,
//                                           width: width * 0.4,
//                                           decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(13),
//                                               image: DecorationImage(
//                                                   image: bottomImgs.isNotEmpty
//                                                       ? bottomImgs[1]["image"]
//                                                       : const AssetImage(
//                                                           "assets/products.png"),
//                                                   fit: BoxFit.fitHeight)),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             );
//                           }),
//                       Padding(
//                         padding: EdgeInsets.only(
//                             left: width * 0, top: height * 0.55),
//                         child: Container(
//                           width: width * 0.22,
//                           height: height * 0.05,
//                           decoration: const BoxDecoration(
//                               color: MyColors.blue3,
//                               borderRadius: BorderRadius.only(
//                                   topRight: Radius.circular(20),
//                                   bottomRight: Radius.circular(20))),
//                           child: const Center(
//                               child: Text(
//                             "Swipe Right",
//                             style: TextStyle(color: MyColors.snow),
//                           )),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               );
//             }),
//         GestureDetector(
//           onHorizontalDragUpdate: (e) {
//             // print(e.delta.dx);
//             if (e.delta.dx > 0) {
//               setState(() {
//                 value = 1;
//               });
//             } else {
//               setState(() {
//                 value = 0;
//               });
//             }
//           },
//         ),
//       ],
//     );
//   }
// }
