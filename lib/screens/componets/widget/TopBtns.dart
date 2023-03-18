import 'package:flutter/material.dart';

class TopBTnsProductPreview extends StatefulWidget {
  const TopBTnsProductPreview({Key? key}) : super(key: key);

  @override
  State<TopBTnsProductPreview> createState() => _TopBTnsProductPreviewState();
}

class _TopBTnsProductPreviewState extends State<TopBTnsProductPreview> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        IconButton(
            onPressed: () {
              print("delete pressed");
            },
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            )),
        const Text("data"),
      ],
    );
  }
}
