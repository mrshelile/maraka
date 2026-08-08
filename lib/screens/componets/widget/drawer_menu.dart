import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  final VoidCallback onClicked;

  const DrawerMenu({super.key, required this.onClicked});

  @override
  Widget build(BuildContext context) => IconButton(
      onPressed: onClicked, icon: const Icon(Icons.menu),
      color: Colors.red ,
      );
}
