import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TestAdPage extends StatefulWidget {
  const TestAdPage({super.key});

  @override
  State<TestAdPage> createState() => _TestAdPageState();
}

class _TestAdPageState extends State<TestAdPage> {
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];

  void selectImages() async {
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty && selectedImages.length < 3) {
      //
      //imageFileList = selectedImages.map<File>((XFile(path)) => File(XFile.path)).toList();
      imageFileList!.addAll(selectedImages);
    }
    print("=========================================================");
    print("Image List Length:${imageFileList!.length}");
    print(
        "======================================================================================================");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Multiple Images'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  selectImages();
                },
                child: const Text('Select Images'),
              ),
              Container(
                child: CarouselSlider.builder(
                  itemCount: imageFileList!.length,
                  itemBuilder:
                      (BuildContext context, int index, int pageViewIndex) {
                    return Image.file(
                      File(imageFileList![index].path),
                      fit: BoxFit.cover,
                    );
                  },
                  options: CarouselOptions(height: 300),
                ),
              )
            ],
          ),
        ));
  }
}
