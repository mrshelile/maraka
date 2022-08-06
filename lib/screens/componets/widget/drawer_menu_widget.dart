import 'package:flutter/material.dart';

class DrawerMenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Row(
        children: [
          Column(
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 70),
            child: Column(
              children: [
                Text(
                  "Online Shop",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Column(
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.search)),
              ],
            ),
          ),
        ],
      ));
}
