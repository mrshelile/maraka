// import 'package:maraka/themes/color.dart';
// import 'package:flutter/material.dart';

// class Categories extends StatefulWidget {
//   @override
//   _CategoriesState createState() => _CategoriesState();
// }

// class _CategoriesState extends State<Categories> {

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
//   int selectedIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     var _height = MediaQuery.of(context).copyWith().size.height;
//     var _width = MediaQuery.of(context).copyWith().size.width;
//     return Padding(
//       padding: EdgeInsets.only(
//         left: _width * 0.1,
//         top: _height * 0.15,
//       ),
//       child: SizedBox(
//         height: 25,
//         child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount: categories.length,
//           itemBuilder: (context, index) => buildCategories(index),
//         ),
//       ),
//     );
// }

//   Widget buildCategories(int index) {
//     return GestureDetector(
//       onTap: () {
//         selectedIndex = index;
//         print(categories[index]);
//       },
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 20 / 4),
//         child: Text(
//           categories[index],
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: selectedIndex == index ? MyColors.blue2 : MyColors.green2,
//           ),
//         ),
//       ),
//     );
//   }
// }
