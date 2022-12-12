import 'dart:async';
import 'dart:convert';
import 'dart:io';
// import 'package:file_picker/file_picker.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:maraka/logic/products_logic.dart';
import 'package:maraka/logic/user_logic.dart';
import 'package:maraka/models/product.dart';
import 'package:maraka/logic/constants.dart';
import 'package:maraka/themes/color.dart';
import 'package:maraka/themes/sideClipDesign.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class CreateAd extends StatefulWidget {
  User owner;
  CreateAd({Key? key, required this.owner}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CreateAdState createState() => _CreateAdState();
}

class _CreateAdState extends State<CreateAd> {
  //V EDIT
  // final ImagePicker imagePicker = ImagePicker();
  List<File> imageFileList = [];
  bool isBtnDisabled = false;
  void selectImages() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true, allowedExtensions: ['jpg', 'png', 'jpeg']);

    if (result != null) {
      setState(() {
        imageFileList = result.paths.map((path) => File(path!)).toList();
      });
    }
  }
  //V EDIT

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final List<String> _pageCategories = [];
  var uuid = const Uuid();
  var _error = '';
  bool _loading = false;
  final _loader = const SpinKitSpinningLines(
    color: MyColors.blue3,
    size: 280,
  );

  // ignore: prefer_typing_uninitialized_variables
  var _dropdownValue;
  @override
  void initState() {
    for (var element in categories) {
      _pageCategories.add(element['text'].toString().toLowerCase());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).copyWith().size.width;
    final height = MediaQuery.of(context).copyWith().size.height;
    return Scaffold(
      floatingActionButton: SingleChildScrollView(
        child: FloatingActionButton(
            tooltip: 'Save',
            backgroundColor: MyColors.blue2,
            foregroundColor: MyColors.gold,
            onPressed: isBtnDisabled
                ? null
                : () async {
                    if (_formKey.currentState!.validate()) {
                      if (_dropdownValue != null) {
                        setState(() {
                          _loading = true;
                        });
                        List<int> imageIds = [];
                        ProductLogic logic = ProductLogic();
                        int i = 0;
                        try {
                          for (var element in imageFileList) {
                            if (i <= 2) {
                              var res = await logic
                                  .postImages(
                                      imageFileList[0], imageFileList[0].path)
                                  .timeout(const Duration(seconds: 25),
                                      onTimeout: () => throw TimeoutException(
                                          'Can\'t upload image'));
                              if (res.statusCode == 201) {
                                imageIds.add(jsonDecode(res.body)['id']);
                              }
                            }
                            i++;
                          }
                          if (imageIds.isNotEmpty) {
                            var response = await logic
                                .postProduct(
                                    Product(
                                        title: _nameController.text.trim(),
                                        description:
                                            _descriptionController.text.trim(),
                                        price: _priceController.text.trim(),
                                        expiryDate: DateTime.now()
                                            .add(const Duration(days: 31)),
                                        id2: '',
                                        seller: Seller(),
                                        images: [],
                                        imageUrls: imageIds,
                                        category: _dropdownValue),
                                    widget.owner.id)
                                .timeout(const Duration(seconds: 25),
                                    onTimeout: () => throw TimeoutException(
                                        'Can\'t create product'));
                            // print(response.statusCode);
                            if (response.statusCode == 201) {
                              setState(() {
                                _loading = false;
                                isBtnDisabled = _loading;
                              });
                              
                              Navigator.pop(context);
                            } else {
                              setState(() {
                                _loading = false;
                                _error = "failed";
                              });
                            }
                          }
                        } catch (e) {
                          setState(() {
                            _loading = false;
                            _error = 'failed';
                          });
                        }
                      } else {
                        setState(() {
                          _error = "Please Choose Category";
                          setState(() {
                            _loading = false;
                          });
                        });
                      }
                    }
                  },
            child: const Icon(Icons.done)),
      ),
      body: Stack(
        children: <Widget>[
          CustomPaint(
            painter: TopRightClip1(),
            child: Container(),
          ),
          CustomPaint(
            painter: TopRightClip2(),
            child: Container(),
          ),
          SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  imageFileList.isNotEmpty
                      ? Padding(
                          padding: EdgeInsets.only(
                              left: width * 0.1, top: height * 0.19),
                          child: SizedBox(
                            // if ()
                            width: width * 0.35,
                            height: height * 0.2,
                            // if ()
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              child: CarouselSlider.builder(
                                itemCount: imageFileList.length,
                                itemBuilder: (BuildContext context, int index,
                                    int pageViewIndex) {
                                  return Image.file(
                                    imageFileList[index],
                                    fit: BoxFit.cover,
                                  );
                                },
                                options: CarouselOptions(height: 300),
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(
                              left: width * 0.1, top: height * 0.19),
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            width: width * 0.35,
                            height: height * 0.2,
                            // if ()
                            child: SvgPicture.asset(
                              "assets/upload.svg",
                              semanticsLabel: "Profile Image",
                              fit: BoxFit.scaleDown,
                              width: width * 0.35,
                              height: height * 0.25,
                            ),
                          ),
                        ),
                  Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.25, top: height * 0.001),
                      child: IconButton(
                        onPressed: () async {
                          selectImages();
                        },
                        icon: const Icon(
                          Icons.upload_file,
                          color: MyColors.goldenBrown,
                          size: 30,
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: height * 0.03),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).copyWith().size.width *
                              0.1),
                      child: SizedBox(
                        width:
                            MediaQuery.of(context).copyWith().size.width * 0.8,
                        child: TextFormField(
                          controller: _nameController,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.title,
                              color: MyColors.brown2,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: MyColors.blue2, width: 2.0),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            labelStyle: const TextStyle(color: MyColors.brown3),
                            labelText: 'Name',
                          ),
                          validator: (String? value) {
                            return value == null || value.isEmpty
                                ? 'Name Cannot be empty'
                                : null;
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: height * 0.05),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).copyWith().size.width *
                              0.1),
                      child: SizedBox(
                        width:
                            MediaQuery.of(context).copyWith().size.width * 0.8,
                        child: TextFormField(
                          controller: _priceController,
                          textInputAction: TextInputAction.next,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.amp_stories,
                              color: MyColors.brown2,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: MyColors.blue2, width: 2.0),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            labelStyle: const TextStyle(color: MyColors.brown3),
                            labelText: 'Price',
                            hintText: "M",
                          ),
                          validator: (String? value) {
                            return value == null || value.isEmpty
                                ? 'Price Cannot be empty'
                                : null;
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: height * 0.05),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).copyWith().size.width *
                              0.1),
                      child: SizedBox(
                        width:
                            MediaQuery.of(context).copyWith().size.width * 0.8,
                        child: TextFormField(
                          controller: _descriptionController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.description,
                              color: MyColors.brown2,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: MyColors.blue2, width: 2.0),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            labelStyle: const TextStyle(color: MyColors.brown3),
                            labelText: 'Description',
                          ),
                          validator: (String? value) {
                            return value == null || value.isEmpty
                                ? 'Name Cannot be empty'
                                : null;
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: height * 0.03, bottom: height * 0),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).copyWith().size.width *
                              0.1),
                      child: SizedBox(
                          width: MediaQuery.of(context).copyWith().size.width *
                              0.51,
                          child: DropdownButton(
                            value: _dropdownValue,
                            hint: const Text("Choose an Categories"),
                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items:
                                _pageCategories.sublist(1).map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _dropdownValue = value;
                              });
                            },
                          )),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: height * 0.0, left: width * 0.1),
                    child: Text(
                      _error,
                      style: const TextStyle(color: MyColors.red2),
                    ),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).copyWith().size.height * 0.07,
                left: MediaQuery.of(context).copyWith().size.width * 0.03,
              ),
              child: const Icon(
                Icons.arrow_back,
                color: MyColors.blue3,
                size: 40,
              ),
            ),
          ),
          if (_loading)
            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.8)),
              child: Center(child: _loader),
            )
        ],
      ),
    );
  }
}
