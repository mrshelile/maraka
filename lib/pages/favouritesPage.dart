// import 'package:get/get_connect/http/src/utils/utils.dart';
// import 'package:maraka/logic/products_logic.dart';
// import 'package:maraka/logic/user_logic.dart';
// import 'package:maraka/models/product.dart';
// import 'package:maraka/models/products.dart';
// import 'package:maraka/themes/background.dart';
// import 'package:maraka/screens/componets/widget/products_item.dart';
// import 'package:flutter/material.dart';

// // ignore: must_be_immutable
// class FavouritesPage extends StatefulWidget {
//   User owner;
//   FavouritesPage({Key? key, required this.owner}) : super(key: key);

//   @override
//   _FavouritesPageState createState() => _FavouritesPageState();
// }

// class _FavouritesPageState extends State<FavouritesPage> {
//   List<Product> favouritesList = [];

//   Future<List<Product>> myFavList() async {
//     var logic = ProductLogic();
//     List<Product> ad = await logic.getFavourites(widget.owner);
//     this.favouritesList = ad;
//     return ad;
//   }

//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).copyWith().size.height;
//     var width = MediaQuery.of(context).copyWith().size.width;
 
//     return Scaffold(
//       body: Stack(
//         children: <Widget>[
//           CustomPaint(
//             painter: BackgroundDesign(),
//             child: Container(),
//           ),
//           Column(
//             children: <Widget>[
//               Padding(
//                 padding: EdgeInsets.only(top: height * 0.0, right: width * 0.6),
//                 child: SizedBox(
//                   height: height * 0.22,
//                   width: width * 0.35,
//                   child: Image.asset(
//                     "assets/maraka.png",
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 // decoration: BoxDecoration(
//                 //     border: Border.all(color: Colors.black)),
//                 height: height * 0.4,
//                 width: width,
//                 child: FutureBuilder<dynamic>(
//                   future: myFavList(),
//                   builder: (context, AsyncSnapshot snapshot) {
//                     if (snapshot.hasData) {
//                       return GridView.builder(
//                           itemCount: favouritesList.length,
//                           gridDelegate:
//                               const SliverGridDelegateWithFixedCrossAxisCount(
//                                   //childAspectRatio: 2,
//                                   mainAxisExtent: 280,
//                                   mainAxisSpacing: 12,
//                                   crossAxisCount: 2,
//                                   crossAxisSpacing: 10),
//                           itemBuilder: (context, index) => ProductsItem(
//                             isFavouritedPage: true,
//                             owner: widget.owner,
//                                 isFavouriteBtn: true,
//                                 isFavouriteclicked: true,
//                                 product: favouritesList[index],
//                                 recents: Recents.generateFavourites(favouritesList)[index],
//                               ));
//                     }
//                     return Text("");
//                   },
//                 ),
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
