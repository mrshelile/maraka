import 'package:flutter/material.dart';
import 'package:maraka/themes/color.dart';

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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: Colors.white),
          child: IconButton(
              onPressed: () {
                print("delete pressed");
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              )),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: Colors.white),
          child: IconButton(
              onPressed: () {
                print("edit pressed");
              },
              icon: Icon(
                Icons.edit_note_rounded,
                color: MyColors.blue2,
              )),
        ),
      ],
    );
  }
}
