// import 'dart:ffi';

// import 'package:maraka/themes/color.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class CategoriesNav extends StatefulWidget {
//   @override
//   _CategoriesNavState createState() => _CategoriesNavState();
// }

// class _CategoriesNavState extends State<CategoriesNav> {
//   final List<String> categories = [
//     "All",
//     "Cars",
//     "Cell phone & Computers",
//     "Home & Appliances",
//     "Tv & Audio",
//     "Fashion & waerable",
//     "Sport & Training",
//     "Stationary & Office",
//     "Baby & Toddler",
//     "Beauty",
//     "Jobs"
//   ];
//   var _activeColor = Colors.transparent;
//   Map<dynamic, dynamic> clickableIndicator = {};
//   @override
//   void initState() {
//     super.initState();
//     for (int i = 0; i < categories.length; i++)
//       if (i == 0)
//         clickableIndicator[i] = true;
//       else
//         clickableIndicator[i] = false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).copyWith().size.height;
//     var width = MediaQuery.of(context).copyWith().size.width;
//     return Container(
//         height: height * 0.21,
//         child: ListView.builder(
//           shrinkWrap: true,
//           scrollDirection: Axis.horizontal,
//           itemCount: categories.length,
//           // padding: EdgeInsets.only(right: width * 0.05),
//           itemBuilder: (BuildContext context, int index) {
//             return Container(
//               decoration: BoxDecoration(
//                   border: Border(
//                       bottom: BorderSide(width: 3, color: _activeColor))),
//               width: MediaQuery.of(context).copyWith().size.width * 0.3,
//               height: MediaQuery.of(context).copyWith().size.height * 0.5,
//               child: Column(
//                 children: <Widget>[
//                   Container(
//                     width: MediaQuery.of(context).copyWith().size.width * 0.15,
//                     height:
//                         MediaQuery.of(context).copyWith().size.height * 0.15,
//                     child: SvgPicture.asset(
//                       "assets/tabs.svg",
//                       semanticsLabel: "Categories",
//                     ),
//                   ),
//                   new Padding(
//                     padding: EdgeInsets.only(
//                         left:
//                             MediaQuery.of(context).copyWith().size.width * 0.04,
//                         top: MediaQuery.of(context).copyWith().size.height * 0),
//                     child: InkWell(
//                       onTap: () {
//                         setState(() {
//                           for (int i = 0; i < categories.length; i++)
//                             index == i
//                                 ? clickableIndicator[index] = true
//                                 : clickableIndicator[index] = false;
//                         });
//                         clickableIndicator[index]
//                             ? _activeColor = MyColors.orange1
//                             : Colors.transparent;
//                       },
//                       child: Text(categories[index]),
//                     ),
//                   )
//                 ],
//               ),
//             );
//           },
//         ));
//   }

//   bool isClicked({index, click}) {
//     return click[index];
//   }

//   Widget buildCard({context, name, index, Map<dynamic, dynamic>? click}) =>
//       Container(
//         width: MediaQuery.of(context).copyWith().size.width * 0.3,
//         height: MediaQuery.of(context).copyWith().size.height * 0.5,
//         child: Column(
//           children: <Widget>[
//             // Image.asset("assets/tabs.png"),
//             Container(
//               width: MediaQuery.of(context).copyWith().size.width * 0.2,
//               height: MediaQuery.of(context).copyWith().size.height * 0.15,
//               child: SvgPicture.asset(
//                 "assets/tabs.svg",
//                 semanticsLabel: "Categories",
//               ),
//             ),
//             new Padding(
//               padding: EdgeInsets.only(
//                   left: MediaQuery.of(context).copyWith().size.width * 0.04,
//                   top: MediaQuery.of(context).copyWith().size.height * 0),
//               child: Text(
//                 name,
//               ),
//             )
//           ],
//         ),
//       );
// }
