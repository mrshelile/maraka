
import 'package:maraka/logic/user_logic.dart';
import 'package:maraka/pages/home/components/body.dart';
import 'package:maraka/themes/background.dart';

import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  User owner;
  HomePage({Key? key, required this.owner}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).copyWith().size.height;
    var width = MediaQuery.of(context).copyWith().size.width;
    return Stack(
      children: <Widget>[
        CustomPaint(
          painter: BackgroundDesign(),
          child: Container(),
          ),
        Body(owner: widget.owner,),
      ],
    );
  }
}
