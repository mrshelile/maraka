import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maraka/logic/store.dart';

import '../../../size_config.dart';

// ignore: must_be_immutable
class SearchField extends StatefulWidget {
  const SearchField({Key? key}) : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final StoreController store = Get.find();
  @override
  void initState() {
    store.search = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig();
    sizeConfig.init(context);
    return Container(
      width: sizeConfig.screenWidth * 0.8,
      decoration: BoxDecoration(
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
