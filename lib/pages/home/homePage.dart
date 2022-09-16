// ignore_for_file: non_constant_identifier_names

import 'package:carousel_slider/carousel_slider.dart';
import 'package:maraka/logic/banner_logic.dart';
import 'package:maraka/logic/products_logic.dart';
import 'package:maraka/logic/user_logic.dart';
import 'package:maraka/models/product.dart';
import 'package:maraka/pages/home/components/body.dart';
import 'package:maraka/themes/background.dart';
import 'package:maraka/logic/constants.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

const cellRed = Color(0xffc73232);
const cellMustard = Color(0xffd7aa22);
const cellGrey = Color(0xffcfd4e0);
const cellBlue = Color(0xff1553be);
const background = Color(0xff242830);

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  User owner;
  HomePage({Key? key, required this.owner}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> products = [];
  double value = 0;
  var selected_category = "All";
  final List<String> _pageCategories = [];

  @override
  void initState() {
    categories.forEach((key, value) {
      _pageCategories.add(key);
    });
    setState(() {
      selected_category = "All".toLowerCase();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ProductLogic productLogic = ProductLogic();
    // productLogic.getProduct(1);
    var height = MediaQuery.of(context).copyWith().size.height;
    var width = MediaQuery.of(context).copyWith().size.width;
    return Stack(
      children: <Widget>[
        CustomPaint(
          painter: BackgroundDesign(),
          child: Container(),
          ),
        Body(),
      ],
    );
  }
}
