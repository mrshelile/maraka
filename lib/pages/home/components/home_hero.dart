import 'package:flutter/material.dart';

import '../../../size_config.dart';
import '../../../themes/color.dart';

class HomeHero extends StatelessWidget {
  const HomeHero({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(
        left: width * 0.04,
        right: width * 0.04,
        top: getProportionateScreenHeight(28, context),
      ),
      child: AspectRatio(
        aspectRatio: 2.18,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(1),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(color: MyColors.blue3),
              Align(
                alignment: Alignment.centerLeft,
                child: ClipPath(
                  clipper: _HeroWhiteCurveClipper(),
                  child: Container(
                    width: width * 0.61,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                left: width * 0.035,
                bottom: getProportionateScreenHeight(12, context),
                top: getProportionateScreenHeight(18, context),
                child: Image.asset(
                  'assets/iconlogo.png',
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                left: width * 0.51,
                right: width * 0.055,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Text(
                    'Shopping made easy, buy and sell\nanything, anytime',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: getProportionateScreenWidth(14, context),
                      fontWeight: FontWeight.w500,
                      height: 1.2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroWhiteCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..lineTo(0, 0)
      ..lineTo(size.width * 0.7, 0)
      ..quadraticBezierTo(
        size.width * 0.22,
        size.height * 0.36,
        size.width,
        size.height,
      )
      ..lineTo(0, size.height)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
