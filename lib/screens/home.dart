// ignore_for_file: must_be_immutable

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:maraka/logic/user_logic.dart';

import 'package:maraka/pages/myadsPage.dart';
import 'package:maraka/screens/account.dart';
import 'package:maraka/themes/color.dart';
import 'package:flutter/material.dart';

import '../pages/home/homePage.dart';
import 'login.dart';

class Home extends StatefulWidget {
  User user;
  int currentIndex = 0;
  Home({Key? key, required this.user, required this.currentIndex})
      : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final _ktabsPages = <Widget>[
      HomePage(
        owner: widget.user,
      ),
      // FavouritesPage(
      //   owner: widget.user,
      // ),
      MyAds(
        owner: widget.user,
      ),
      Account(
        currentIndex: widget.currentIndex,
        user: widget.user,
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

          _ktabsPages[widget.currentIndex],
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

          if (index == 1 || index == 2 ) {
            if (widget.user.email == null) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const Login()));
            } else {
              setState(() {
                if (widget.user.email != null) widget.currentIndex = index;
              });
            }
          }
          if (index != 1 || index != 2 || index != 3) {
            setState(() {
              if (widget.user.email != null) widget.currentIndex = index;
            });
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
