import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maraka/logic/store.dart';
import 'package:maraka/logic/user_logic.dart';
import 'package:maraka/themes/color.dart';

import '../../../size_config.dart';

class SearchField extends StatefulWidget {
  User owner;
  SearchField({Key? key, required this.owner}) : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final store = Get.find<StoreController>();

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig();
    sizeConfig.init(context);
    return Container(
      width: sizeConfig.screenWidth * 0.6,
      decoration: BoxDecoration(
        color: MyColors.blue4.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        onChanged: (value) async {
          print(value);
        },
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20, context),
                vertical: getProportionateScreenWidth(9, context)),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: "Search product",
            prefixIcon: Icon(Icons.search)),
      ),
    );
  }
}
