import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  final VoidCallback onClicked;

  const DrawerMenu({Key? key, required this.onClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) => IconButton(
      onPressed: onClicked, icon: Icon(Icons.menu),
      color: Colors.red ,
      );
}
