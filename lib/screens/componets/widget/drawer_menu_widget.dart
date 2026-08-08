import 'package:flutter/material.dart';

class DrawerMenuWidget extends StatelessWidget {
  const DrawerMenuWidget({super.key});

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Row(
        children: [
          Column(
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 70),
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
                IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
              ],
            ),
          ),
        ],
      ));
}
