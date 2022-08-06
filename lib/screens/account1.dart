// import 'package:maraka/screens/home.dart';
// import 'package:maraka/themes/color.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class Account {
//   static var name = "Vikile Hata-Hata";
//   static var phone1 = "69356845";
//   static var phone2 = "";
//   static bool isSecondNumber = false;
//   static final profileformKey = GlobalKey<FormState>();
//   static final phone1Controller = TextEditingController();
//   static final phone2Controller = TextEditingController();
//   static final fullNameController = TextEditingController();
//   static final emailController = TextEditingController();
//   static var email = "davertzshelile@gmail.com";
//   static bool isenabled = false;
//   static var months = 8;

//   static Widget account(context, setState) {
//     var height = MediaQuery.of(context).copyWith().size.height;
//     var width = MediaQuery.of(context).copyWith().size.width;
//     return SingleChildScrollView(
//       child: Form(
//         key: profileformKey,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             Padding(
//               padding: EdgeInsets.only(top: height * 0.1, left: width * 0),
//               child: Column(
//                 children: <Widget>[
//                   Padding(
//                     padding: EdgeInsets.only(
//                       left: width * 0,
//                     ),
//                     child: SvgPicture.asset(
//                       "assets/profile.svg",
//                       semanticsLabel: "Profile Image",
//                       fit: BoxFit.scaleDown,
//                       width: width * 0.4,
//                       height: height * 0.3,
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(left: width * 0.1),
//                     child: SizedBox(
//                       width: width * 0.45,
//                       child: TextFormField(
//                         controller: fullNameController,
//                         decoration: InputDecoration(
//                           labelStyle: const TextStyle(color: MyColors.blue3),
//                           hintText: "full Names",
//                           labelText: name,
//                           enabled: isenabled,
//                           border: InputBorder.none,
//                         ),
//                         validator: (String? value) {
//                           return value == null || value.isEmpty
//                               ? 'Enter Your Full Names'
//                               : null;
//                         },
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(
//                 top: height * 0.05,
//               ),
//               child: SingleChildScrollView(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15),
//                     // border: Border(top: BorderSide(color: MyColors.blue2)),
//                     color: Colors.white,
//                   ),
//                   width: width,
//                   height: height * 0.352,
//                   child: SingleChildScrollView(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: <Widget>[
//                         SizedBox(
//                           height: height * 0.02,
//                         ),
//                         const Text(
//                           "Personal Information",
//                           style: TextStyle(fontSize: 15),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(left: width * 0.1),
//                           child: SizedBox(
//                             width: width,
//                             height: height * 0.08,
//                             child: TextFormField(
//                               controller: phone1Controller,
//                               keyboardType: TextInputType.phone,
//                               decoration: InputDecoration(
//                                 prefixIcon: const Icon(
//                                   Icons.phone_rounded,
//                                   color: MyColors.brown3,
//                                 ),
//                                 // suffixIcon: IconButton(
//                                 //   onPressed: () {
//                                 //     Navigator.push(
//                                 //         context,
//                                 //         MaterialPageRoute(
//                                 //             builder: (context) => Home()));
//                                 //   },
//                                 //   icon: Icon(
//                                 //     Icons.add,
//                                 //     color: MyColors.blue3,
//                                 //   ),
//                                 // ),
//                                 labelStyle: const TextStyle(color: MyColors.blue3),
//                                 hintText: "Phone Numbers",
//                                 labelText: phone1,
//                                 enabled: isenabled,
//                                 border: InputBorder.none,
//                               ),
//                               validator: (String? value) {
//                                 return value == null || value.isEmpty
//                                     ? 'Phone Number'
//                                     : null;
//                               },
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(left: width * 0.1),
//                           child: SizedBox(
//                             width: width,
//                             height: height * 0.08,
//                             child: TextFormField(
//                               controller: phone2Controller,
//                               keyboardType: TextInputType.phone,
//                               decoration: InputDecoration(
//                                 prefixIcon: const Icon(
//                                   Icons.phone_rounded,
//                                   color: MyColors.brown3,
//                                 ),
//                                 labelStyle: isSecondNumber
//                                     ? const TextStyle(color: MyColors.blue3)
//                                     : const TextStyle(color: Colors.brown),
//                                 hintText: "Phone Numbers",
//                                 labelText: phone2.isEmpty?"Phone Numbers":phone2,
//                                 enabled: isenabled,
//                                 border: InputBorder.none,
//                               ),
//                               // validator: (String? value) {
//                               //   return value == null || value.isEmpty
//                               //       ? 'Phone Number'
//                               //       : null;
//                               // },
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(left: width * 0.1),
//                           child: SizedBox(
//                             width: width,
//                             height: height * 0.08,
//                             child: TextFormField(
//                               controller: emailController,
//                               decoration: InputDecoration(
//                                 prefixIcon: const Icon(
//                                   Icons.email,
//                                   color: MyColors.brown3,
//                                 ),
//                                 labelStyle: const TextStyle(color: MyColors.blue3),
//                                 hintText: "Email Address",
//                                 labelText: email,
//                                 enabled: isenabled,
//                                 border: InputBorder.none,
//                               ),
//                               keyboardType: TextInputType.emailAddress,
//                               validator: (String? value) {
//                                 return value == null || value.isEmpty
//                                     ? 'Email Address Cannot be empty'
//                                     : null;
//                               },
//                             ),
//                           ),
//                         ),
//                         const Divider(
//                           color: MyColors.brown2,
//                         ),
//                         SizedBox(
//                           width: width,
//                           child: Text(
//                             "Subscription: $months months Left",
//                             style: const TextStyle(fontSize: 15),
//                           ),
//                         ),
//                         Container(
//                             alignment: Alignment.topLeft,
//                             width: width,
//                             margin: EdgeInsets.only(
//                                 right: width * 0.3,
//                                 top: height * 0.035,
//                                 left: width * 0.01,
//                                 bottom: width * 0.05),
//                             child: LinearProgressIndicator(
//                               value: months / 12,
//                               valueColor: const AlwaysStoppedAnimation<Color>(
//                                   MyColors.green3),
//                               backgroundColor: Colors.grey,
//                             ))
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
