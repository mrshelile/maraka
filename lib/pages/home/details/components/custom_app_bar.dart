import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maraka/size_config.dart';
import 'package:maraka/themes/color.dart';

class CustomAppBar extends StatelessWidget {
  // final double rating;

  const CustomAppBar({Key? key}) : super(key: key);

  // AppBar().preferredSize.height provide us the height that appy on our app bar
  // Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20, context)),
        child: Row(
          children: [
            SizedBox(
              height: getProportionateScreenWidth(40, context),
              width: getProportionateScreenWidth(40, context),
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: MyColors.blue2, shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60),
                  ),
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.zero,
                ),
                onPressed: () => Navigator.pop(context),
                child: SvgPicture.asset(
                  "assets/Back ICon.svg",
                  height: 15,
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
