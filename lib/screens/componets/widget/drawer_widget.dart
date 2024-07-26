

// import 'package:flutter/material.dart';
// import 'package:test_sidebar/data/drawer_items.dart';
// import 'package:test_sidebar/model/drawer_item.dart';

// class DrawerWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) => SingleChildScrollView(
//         child: Column(
//           children: [buildDrawerItems(context)],
//         ),
//       );

//   Widget buildDrawerItems(BuildContext context) => Column(
//       children: DrawerItems.all
//           .map(
//             (item) => ListTile(
//               contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
//               leading: Icon(item.icon, color: Colors.white,),
//               title: Text(
//                 item.title,
//                 style: TextStyle(color: Colors.white, fontSize: 20),
//               ),
//               onTap: () {},
//             ),
//           )
//           .toList());
// }
