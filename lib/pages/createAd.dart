import 'dart:async';
import 'dart:convert';
import 'dart:io';
// import 'package:file_picker/file_picker.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
import 'package:maraka/logic/products_logic.dart';
import 'package:maraka/logic/user_logic.dart';
import 'package:maraka/models/product.dart';
import 'package:maraka/logic/constants.dart';
import 'package:maraka/screens/home.dart';
import 'package:maraka/themes/color.dart';
import 'package:maraka/themes/sideClipDesign.dart';
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
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true
            // allowMultiple: true, allowedExtensions: ['jpg', 'png', 'jpeg']
            );

    if (result != null) {
      if (result.files.length <= 5) {
        if (result.files.every((element) => element.size <= 3750000)) {
          setState(() {
            _error = "";
            imageFileList = result.paths.map((path) => File(path!)).toList();
          });
        } else {
          setState(() {
            _error = "image is too large";
          });
        }
      } else {
        setState(() {
          _error = "maximum of 5 images";
        });
      }
    }
  }
  //V EDIT

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _modelController = TextEditingController();
  final _makeController = TextEditingController();
  final _mileageController = TextEditingController();
  final _fuelController = TextEditingController();
  final _yearController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final List<String> _pageCategories = [];
  final List<String> _transmissionList = ["Auto", "Manual"];
  var uuid = const Uuid();
  var _error = '';
  bool _loading = false;
  final _loader = const SpinKitSpinningLines(
    color: MyColors.blue3,
    size: 280,
  );

  // ignore: prefer_typing_uninitialized_variables
  var _dropdownValue, _transmissionValue;
  @override
  void initState() {
    for (var element in categories) {
      _pageCategories.add(element['text'].toString().toLowerCase());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int countBtnDisable = 0;
    final width = MediaQuery.of(context).copyWith().size.width;
    final height = MediaQuery.of(context).copyWith().size.height;
    Widget name = Container(
      padding: EdgeInsets.only(left: width * 0.1, top: height * 0.005),
      child: TextFormField(
        controller: _nameController,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.title,
            color: MyColors.brown2,
            size: width * 0.04,
          ),
          labelStyle: TextStyle(color: MyColors.brown3, fontSize: width * 0.04),
          labelText: 'Name',
        ),
        validator: (String? value) {
          return value == null || value.trim().isEmpty
              ? 'Name Cannot be empty'
              : null;
        },
      ),
    );
    Widget UploadField = GestureDetector(
      onTap: (){
         selectImages();
      },
      child: Container(
        padding: EdgeInsets.only(left: width * 0.1, top: height * 0.005),
        child: TextFormField(
          readOnly: true,
          enableInteractiveSelection: false,
          enabled: false,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.image,
              color: MyColors.brown2,
              size: width * 0.04,
            ),
            labelStyle: TextStyle(color: MyColors.brown3, fontSize: width * 0.04),
            labelText: 'Chosse Image',
          ),
         
        ),
      ),
    );
    Widget model = Container(
      padding: EdgeInsets.only(left: width * 0.1, top: height * 0.005),
      child: TextFormField(
        controller: _modelController,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.model_training_outlined,
            color: MyColors.brown2,
            size: width * 0.04,
          ),
          labelStyle: TextStyle(color: MyColors.brown3, fontSize: width * 0.04),
          labelText: 'Model',
        ),
        validator: (String? value) {
          return value == null || value.trim().isEmpty
              ? 'Field Cannot be empty'
              : null;
        },
      ),
    );
    Widget make = Container(
      padding: EdgeInsets.only(left: width * 0.1, top: height * 0.005),
      width: width,
      child: TextFormField(
        controller: _makeController,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.type_specimen,
            color: MyColors.brown2,
            size: width * 0.04,
          ),
          labelStyle: TextStyle(color: MyColors.brown3, fontSize: width * 0.04),
          labelText: 'Make',
        ),
        validator: (String? value) {
          return value == null || value.trim().isEmpty
              ? 'Field Cannot be empty'
              : null;
        },
      ),
    );
    Widget mileage = Container(
      padding: EdgeInsets.only(left: width * 0.1, top: height * 0.005),
      width: width,
      child: TextFormField(
        controller: _mileageController,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.travel_explore_outlined,
            color: MyColors.brown2,
            size: width * 0.04,
          ),
          labelStyle: TextStyle(color: MyColors.brown3, fontSize: width * 0.04),
          labelText: 'Mileage',
        ),
        validator: (String? value) {
          return value == null || value.trim().isEmpty
              ? 'Field Cannot be empty'
              : null;
        },
      ),
    );
    Widget fuel = Container(
      padding: EdgeInsets.only(left: width * 0.1),
      width: width,
      child: TextFormField(
        controller: _fuelController,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.ramp_left_outlined,
            color: MyColors.brown2,
            size: width * 0.042,
          ),
          labelStyle: TextStyle(color: MyColors.brown3, fontSize: width * 0.04),
          labelText: 'Fuel Type',
        ),
        validator: (String? value) {
          return value == null || value.trim().isEmpty
              ? 'Field Cannot be empty'
              : null;
        },
      ),
    );
    Widget year = Container(
      padding: EdgeInsets.only(left: width * 0.1),
      width: width,
      child: TextFormField(
        controller: _yearController,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          FilteringTextInputFormatter.digitsOnly
        ],
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.calendar_today,
            color: MyColors.brown2,
            size: width * 0.04,
          ),
          labelStyle: TextStyle(color: MyColors.brown3, fontSize: width * 0.04),
          labelText: 'Year',
        ),
        validator: (String? value) {
          return value == null || value.trim().isEmpty
              ? 'Field Cannot be empty'
              : null;
        },
      ),
    );
    Widget transmission = Container(
      padding: EdgeInsets.only(left: width * 0.1),
      width: width,
      child: DropdownButton(
        value: _transmissionValue,
        hint: Text(
          "Transmission",
          style: TextStyle(fontSize: width * 0.04, color: MyColors.brown3),
        ),
        // Down Arrow Icon
        icon: const Icon(
          Icons.keyboard_arrow_down,
        ),
        underline: Container(),
        items: _transmissionList.map((String item) {
          return DropdownMenuItem(
            value: item.toLowerCase(),
            child: Text(item),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _transmissionValue = value;
          });
        },
      ),
    );
    Widget price = Container(
      padding: EdgeInsets.only(left: width * 0.1, top: height * 0.005),
      child: TextFormField(
        controller: _priceController,
        textInputAction: TextInputAction.next,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          FilteringTextInputFormatter.digitsOnly
        ],
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.amp_stories,
            color: MyColors.brown2,
            size: width * 0.04,
          ),
          labelStyle: TextStyle(color: MyColors.brown3, fontSize: width * 0.04),
          labelText: 'Price',
          hintText: "M",
        ),
        validator: (String? value) {
          return value == null || value.trim().isEmpty
              ? 'Price Cannot be empty'
              : null;
        },
      ),
    );
    Widget description = Container(
      padding: EdgeInsets.only(left: width * 0.1, top: height * 0.005),
      child: TextFormField(
        controller: _descriptionController,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.description,
            color: MyColors.brown2,
            size: width * 0.04,
          ),
          labelStyle: TextStyle(color: MyColors.brown3, fontSize: width * 0.04),
          labelText: 'Description',
        ),
        validator: (String? value) {
          return value == null || value.trim().isEmpty
              ? 'Descrition Cannot be empty'
              : null;
        },
      ),
    );
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          tooltip: 'Save',
          backgroundColor: MyColors.blue2,
          foregroundColor: MyColors.gold,
          onPressed: isBtnDisabled
              ? null
              : () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      isBtnDisabled = true;
                      countBtnDisable++;
                    });
                    var car;
                    if (imageFileList.isNotEmpty) {
                      if (_dropdownValue != null && countBtnDisable < 2) {
                        if (mounted) {
                          setState(() {
                            _loading = true;
                          });
                        }
                        List<int> imageIds = [];
                        ProductLogic logic = ProductLogic();
                        int i = 0;

                        try {
                          for (var element in imageFileList) {
                            if (i <= 4) {
                              var res = await logic
                                  .postImages(element, element.path)
                                  .timeout(const Duration(minutes: 1),
                                      onTimeout: () => throw TimeoutException(
                                          'Can\'t upload image'));
                              if (res.statusCode == 201) {
                                imageIds.add(jsonDecode(res.body)['id']);
                              }
                            }
                            i++;
                          }
                          // debugPrint(imageIds.toString());
                          if (imageIds.isNotEmpty) {
                            if (_dropdownValue.toString().toLowerCase() ==
                                "cars") {
                              if (_transmissionValue != null) {
                                var carRes = await logic.postCar(
                                    fuel: _fuelController.text,
                                    make: _makeController.text,
                                    mileage: _mileageController.text,
                                    model: _modelController.text,
                                    transmition: _transmissionValue,
                                    year: _yearController.text);

                                if (carRes.statusCode == 201) {
                                  car = jsonDecode(carRes.body)["id"];
                                } else {
                                  car = -1;
                                  throw Exception("failed to create car");
                                }
                              } else {
                                throw UnauthorizedException();
                              }
                            }
                            var response = await logic
                                .postProduct(
                                    Product(
                                      views: 0,
                                        title: _nameController.text.trim(),
                                        description:
                                            _descriptionController.text.trim(),
                                        price: _priceController.text.trim(),
                                        expiryDate: DateTime.now()
                                            .add(const Duration(days: 93)),
                                        id2: '',
                                        seller: Seller(),
                                        images: [],
                                        imageUrls: imageIds,
                                        category: _dropdownValue),
                                    widget.owner.id,
                                    car)
                                .timeout(const Duration(seconds: 25),
                                    onTimeout: () => throw TimeoutException(
                                        'Can\'t create product'));

                            if (response.statusCode == 201) {
                              if (mounted) {
                                setState(() {
                                  _loading = false;
                                  isBtnDisabled = true;
                                  // countBtnDisable = 0;
                                });
                              }

                              if (!mounted) return;
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home(
                                            user: widget.owner,
                                            currentIndex: 1,
                                          )));
                              // Navigator.pop(context);
                            } else {
                              throw Exception("product not created");
                            }
                          }
                        } on UnauthorizedException {
                          if (mounted) {
                            setState(() {
                              _loading = false;
                              _error = "Transmission not chosen";
                              isBtnDisabled = false;
                              countBtnDisable = 0;
                            });
                          }
                        } catch (e) {
                          debugPrint(e.toString());
                          if (mounted) {
                            setState(() {
                              _loading = false;
                              _error = 'failed';
                              isBtnDisabled = false;
                              countBtnDisable = 0;
                            });
                          }
                        }
                      } else {
                        if (mounted) {
                          setState(() {
                            _error = "Please Choose Category";
                            setState(() {
                              _loading = false;
                              isBtnDisabled = false;
                              countBtnDisable = 0;
                            });
                          });
                        }
                      }
                    } else {
                      setState(() {
                        _loading = false;
                        _error = "Choose Image";
                        countBtnDisable = 0;
                        isBtnDisabled = false;
                      });
                    }
                  }
                },
          child: const Icon(Icons.done)),
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
                crossAxisAlignment: CrossAxisAlignment.center,
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
                              semanticsLabel: "Image",
                              fit: BoxFit.scaleDown,
                              width: width * 0.35,
                              height: height * 0.25,
                            ),
                          ),
                        ),
                  // Padding(
                  //     padding: EdgeInsets.only(
                  //         left: width * 0.25, top: height * 0.001),
                  //     child: IconButton(
                  //       onPressed: () async {
                  //         selectImages();
                  //       },
                  //       icon: const Icon(
                  //         Icons.upload_file,
                  //         color: MyColors.goldenBrown,
                  //         size: 30,
                  //       ),
                  //     )),
                  UploadField,
                  if (_dropdownValue.toString().toLowerCase() != 'cars') ...[
                    name,
                    description,
                  ],
                  price,
                  if (_dropdownValue.toString().toLowerCase() == 'cars') ...[
                    year,
                    model,
                    make,
                    fuel,
                    mileage,
                    description,
                    transmission
                  ],
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
                            hint: Text(
                              "Choose a Category",
                              style: TextStyle(fontSize: width * 0.04),
                            ),
                            // Down Arrow Icon
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                            ),
                            items: _pageCategories.map((String items) {
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
