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
        boxShadow:const [
           BoxShadow(
            color: Color.fromARGB(209, 240, 236, 236),
            spreadRadius: 5,
            blurRadius:7,
            offset: Offset(1,3)
          )
        ],
        color: const Color.fromARGB(255, 224, 229, 240).withOpacity(0.9),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        onChanged: (value) async {
          store.searchNow(value);
        },
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20, context),
                vertical: getProportionateScreenWidth(9, context)),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: "Search product",
            prefixIcon: const Icon(Icons.search)),
      ),
    );
  }
}
