// ignore_for_file: must_be_immutable

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:get/get.dart';
import 'package:maraka/logic/user_logic.dart';

import 'package:maraka/pages/myads_page.dart';
import 'package:maraka/screens/account.dart';
import 'package:maraka/themes/color.dart';
import 'package:flutter/material.dart';

import '../pages/home/home_page.dart';
import 'login.dart';

class Home extends StatefulWidget {
  int currentIndex = 0;
  Home({super.key, required this.currentIndex});

  @override
  // ignore: library_private_types_in_public_api
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User user = Get.find();

    final ktabsPages = <Widget>[
      const HomePage(
          // owner: widget.user,
          ),
      // FavouritesPage(
      //   owner: widget.user,
      // ),
      const MyAds(
          // owner: widget.user,
          ),
      Account(
        currentIndex: widget.currentIndex,
        // user: widget.user,
      ),
    ];

    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.topStart,
        children: <Widget>[
          // CustomPaint(
          //   painter: BackgroundDesign(),
          //   child: Container(),
          // ),

          ktabsPages[widget.currentIndex],
          // CustomNavBar(),
          //Categories(),
        ],
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: widget.currentIndex,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        onItemSelected: (index) async {
          // await widget.user.removeToken();
          // await widget.user.retrieveEmail();
          // print(widget.user.email);

          if (index == 1 || index == 2) {
            if (!user.isAuthenticated) {
              Get.to(() => Login(pageTo: index));
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => const Login()));
            } else {
              if (user.email != null) {
                setState(() {
                  widget.currentIndex = index;
                });
              }
            }
          }
          if (index != 1 || index != 2 || index != 3) {
            if (user.email != null) {
              setState(() {
                widget.currentIndex = index;
              });
            }
          }
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: const Icon(Icons.apps),
            title: const Text('Home'),
            activeColor: MyColors.blue2,
            textAlign: TextAlign.center,
          ),
          // BottomNavyBarItem(
          //   icon: const Icon(Icons.favorite),
          //   title: const Text('Favourites'),
          //   activeColor: MyColors.blue4,
          //   textAlign: TextAlign.center,
          // ),
          BottomNavyBarItem(
            icon: const Icon(Icons.collections_bookmark_outlined),
            title: const Text(
              'My Ads',
            ),
            activeColor: MyColors.green3,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.account_box_outlined),
            title: const Text('Account'),
            activeColor: MyColors.brown2,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
