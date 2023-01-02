import 'package:flutter/material.dart';
import 'package:maraka/logic/user_logic.dart';

import '../../../size_config.dart';
import 'search_field.dart';

class HomeHeader extends StatelessWidget {
  User owner;
  HomeHeader({Key? key, required this.owner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20, context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SearchField(owner: owner,),
        ],
      ),
    );
  }
}
