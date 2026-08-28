// ignore_for_file: must_be_immutable

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:get/get.dart';
import 'package:maraka/logic/user_logic.dart';
import 'package:maraka/pages/home/promotions_real.dart';

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
      const RealPromotionsPage(),
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

          if (index == 2 || index == 3) {
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
          if (index == 0 || index == 1) {
            setState(() {
              widget.currentIndex = index;
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
          BottomNavyBarItem(
            icon: const _PromotionsNavIcon(),
            title: const Text(
              'Promotions',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            activeColor: MyColors.gold,
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
            title: const Text('My Ads'),
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

class _PromotionsNavIcon extends StatefulWidget {
  const _PromotionsNavIcon();

  @override
  State<_PromotionsNavIcon> createState() => _PromotionsNavIconState();
}

class _PromotionsNavIconState extends State<_PromotionsNavIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _pulse;
  bool _isResting = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );
    _pulse = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _playAttentionLoop();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _playAttentionLoop() async {
    while (mounted) {
      setState(() => _isResting = false);

      for (var i = 0; i < 3 && mounted; i++) {
        await _controller.forward(from: 0);
        if (!mounted) return;
        await _controller.reverse();
      }

      if (!mounted) return;
      setState(() => _isResting = true);
      await Future<void>.delayed(const Duration(seconds: 4));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulse,
      builder: (context, child) {
        final value = _pulse.value;

        return Transform.rotate(
          angle: _isResting ? 0 : -0.08 + (value * 0.16),
          child: Transform.scale(
            scale: _isResting ? 1 : 1 + (value * 0.12),
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: MyColors.gold.withOpacity(
                  _isResting ? 0.12 : 0.12 + (value * 0.1),
                ),
                boxShadow: [
                  BoxShadow(
                    color: MyColors.gold.withOpacity(
                      _isResting ? 0.2 : 0.2 + (value * 0.18),
                    ),
                    blurRadius: _isResting ? 7 : 7 + (value * 7),
                    spreadRadius: _isResting ? 0 : value * 1.5,
                  ),
                ],
              ),
              child: child,
            ),
          ),
        );
      },
      child: const Icon(
        Icons.local_offer_rounded,
        color: MyColors.gold,
        size: 24,
      ),
    );
  }
}
