// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:maraka/logic/products_logic.dart';
import 'package:maraka/logic/store.dart';
import 'package:maraka/models/ImageStrapi.dart';
import 'package:maraka/models/product.dart';
import 'package:maraka/themes/color.dart';

class EditAdForm extends StatefulWidget {
  int product;
  EditAdForm({Key? key, required this.product});

  @override
  State<EditAdForm> createState() => _EditAdFormState();
}

class _EditAdFormState extends State<EditAdForm> {
  @override
  void initState() {
    super.initState();
  }

  var imgs = [];
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

  var _error = '';
  bool _loading = false;
  final _loader = const SpinKitSpinningLines(
    color: MyColors.blue3,
    size: 280,
  );
  final List<String> _transmissionList = ["Auto", "Manual"];
  var _transmissionValue;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _modelController = TextEditingController();
  final _makeController = TextEditingController();
  final _mileageController = TextEditingController();
  final _fuelController = TextEditingController();
  final _yearController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).copyWith().size.width;
    final height = MediaQuery.of(context).copyWith().size.height;
    ProductLogic logic = ProductLogic();
    final store = Get.find<StoreController>();

    for (var item in store.myProducts[widget.product].images!) {
      imgs.add(NetworkImage(item.url));
    }
    _nameController.text = store.myProducts[widget.product].title.toString();
    _descriptionController.text =
        store.myProducts[widget.product].description.toString();
    _priceController.text = store.myProducts[widget.product].price.toString();
    if (store.myProducts[widget.product].category.toString().toLowerCase() ==
        'cars') {
      _fuelController.text = store.myProducts[widget.product].car['fuel'] ?? '';
      _makeController.text = store.myProducts[widget.product].car['make'] ?? '';
      _mileageController.text =
          store.myProducts[widget.product].car['kilos'] ?? '';
      _modelController.text =
          store.myProducts[widget.product].car['model'] ?? '';
      _yearController.text =
          store.myProducts[widget.product].car['year'].toString();
      _transmissionValue =
          store.myProducts[widget.product].car['transmission'] ?? '';
    }
    Widget name = Container(
      width: width * 0.8,
      padding: EdgeInsets.only(left: width * 0.09, top: height * 0.005),
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
        // validator: (String? value) {
        //   return value == null || value.trim().isEmpty
        //       ? 'Name Cannot be empty'
        //       : null;
        // },
      ),
    );
    Widget UploadField = GestureDetector(
      onTap: () {
        selectImages();
      },
      child: Container(
        padding: EdgeInsets.only(left: width * 0.09, top: height * 0.01),
        width: width * 0.8,
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
            labelStyle:
                TextStyle(color: MyColors.brown3, fontSize: width * 0.04),
            labelText: 'Chosse Image',
          ),
        ),
      ),
    );
    Widget model = Container(
      width: width * 0.8,
      padding: EdgeInsets.only(left: width * 0.09, top: height * 0.005),
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
        // validator: (String? value) {
        //   return value == null || value.trim().isEmpty
        //       ? 'Field Cannot be empty'
        //       : null;
        // },
      ),
    );
    Widget make = Container(
      padding: EdgeInsets.only(left: width * 0.09, top: height * 0.005),
      width: width * 0.8,
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
        // validator: (String? value) {
        //   return value == null || value.trim().isEmpty
        //       ? 'Field Cannot be empty'
        //       : null;
        // },
      ),
    );
    Widget mileage = Container(
      padding: EdgeInsets.only(left: width * 0.08, top: height * 0.005),
      width: width * 0.8,
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
        // validator: (String? value) {
        //   return value == null || value.trim().isEmpty
        //       ? 'Field Cannot be empty'
        //       : null;
        // },
      ),
    );
    Widget fuel = Container(
      padding: EdgeInsets.only(left: width * 0.08),
      width: width * 0.8,
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
        // validator: (String? value) {
        //   return value == null || value.trim().isEmpty
        //       ? 'Field Cannot be empty'
        //       : null;
        // },
      ),
    );
    Widget year = Container(
      padding: EdgeInsets.only(left: width * 0.09),
      width: width * 0.8,
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
        // validator: (String? value) {
        //   return value == null || value.trim().isEmpty
        //       ? 'Field Cannot be empty'
        //       : null;
        // },
      ),
    );
    Widget transmission = Container(
      padding: EdgeInsets.only(
        left: width * 0.09,
      ),
      width: width * 0.8,
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
      width: width * 0.8,
      padding: EdgeInsets.only(left: width * 0.09, top: height * 0.005),
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
        // validator: (String? value) {
        //   return value == null || value.trim().isEmpty
        //       ? 'Price Cannot be empty'
        //       : null;
        // },
      ),
    );
    Widget description = Container(
      width: width * 0.8,
      padding: EdgeInsets.only(left: width * 0.09, top: height * 0.005),
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
        // validator: (String? value) {
        //   return value == null || value.trim().isEmpty
        //       ? 'Descrition Cannot be empty'
        //       : null;
        // },
      ),
    );
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'Save',
        backgroundColor: MyColors.blue2,
        foregroundColor: Color.fromARGB(255, 253, 253, 251),
        child: const Icon(Icons.done),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            setState(() {
              _loading = true;
            });
            List<int> imgIds = [];
            var car;
            try {
              if (imageFileList.isNotEmpty) {
                store.myProducts[widget.product].images != [];
                for (var element in imageFileList) {
                  var res = await logic
                      .postImages(element, element.path)
                      .timeout(const Duration(minutes: 1),
                          onTimeout: () =>
                              throw TimeoutException('Can\'t upload image'));
                  if (res.statusCode == 201) {
                    imgIds.add(jsonDecode(res.body)['id']);
                    store.myProducts[widget.product].images!
                        .add(ImageStrapi(url: jsonDecode(res.body)['image']));
                  } else {
                    setState(() {
                      _loading = false;
                    });
                    throw Exception("image file not uploaded");
                  }
                }
              }

              if (store.myProducts[widget.product].category
                      .toString()
                      .toLowerCase() ==
                  'cars') {
                var car_res = await logic
                    .updateCar(
                        car: store.myProducts[widget.product].car['id'],
                        model: _modelController.text,
                        year: _yearController.text,
                        fuel: _fuelController.text,
                        make: _makeController.text,
                        mileage: _mileageController.text,
                        transmition: _transmissionValue)
                    .timeout(const Duration(minutes: 1),
                        onTimeout: () =>
                            throw TimeoutException('Can\'t create a Car'));
                if (car_res.statusCode == 200) {
                  car = jsonDecode(car_res.body)["id"];
                  store.myProducts[widget.product].car['model'] =
                      _modelController.text;
                  store.myProducts[widget.product].car['year'] =
                      _yearController.text;
                  store.myProducts[widget.product].car['fuel'] =
                      _fuelController.text;
                  store.myProducts[widget.product].car['make'] =
                      _makeController.text;
                  store.myProducts[widget.product].car['kilos'] =
                      _mileageController.text;
                  store.myProducts[widget.product].car['transmission'] =
                      _transmissionValue;
                } else {
                  car = -1;
                  setState(() {
                    _loading = false;
                  });
                  throw Exception("failed to create car");
                }
              }

              var res = await logic
                  .updateProduct(
                      Product(
                          title: _nameController.text,
                          description: _descriptionController.text,
                          price: _priceController.text,
                          expiryDate: '',
                          id1: store.myProducts[widget.product].id1,
                          id2: '',
                          seller: null,
                          images: null,
                          imageUrls: imgIds,
                          category: store.myProducts[widget.product].category),
                      car)
                  .timeout(const Duration(minutes: 1),
                      onTimeout: () =>
                          throw TimeoutException('Can\'t create Product'));
              if (res.statusCode == 200) {
                if (store.myProducts[widget.product].category != 'cars') {
                  store.myProducts[widget.product].title = _nameController.text;
                }
                store.myProducts[widget.product].price = _priceController.text;
                store.myProducts[widget.product].description =
                    _descriptionController.text;
                store.update();
                setState(() {
                  _loading = false;
                });
                FocusScope.of(context).requestFocus(FocusNode());
                Navigator.pop(context);
              } else {
                setState(() {
                  _loading = false;
                });
                throw Exception("failed to create product");
              }
            } catch (e) {
              setState(() {
                _loading = false;
                _error = "Failed! Try again later";
              });
            }
          }
        },
      ),
      backgroundColor: Color.fromARGB(255, 236, 235, 232),
      body: GetBuilder(
          init: store,
          builder: (_) {
            return Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(
                        width: width,
                        height: height * 0.3,
                        child: Carousel(
                          autoplay: true,
                          dotBgColor: Colors.transparent,
                          dotSize: 0,
                          boxFit: BoxFit.cover,
                          // borderRadius: true,
                          images: imageFileList.isEmpty
                              ? imgs
                              : imageFileList
                                  .map((e) => Image.file(e))
                                  .toList(),
                        ))
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: height * 0.2, left: width * 0.05),
                  child: Container(
                    width: width * 0.9,
                    height: height * 0.73,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: SingleChildScrollView(
                      child: Wrap(
                        children: [
                          Center(
                              child: Padding(
                            padding: EdgeInsets.only(top: height * 0.02),
                            child: const Text(
                              "Edit Contents",
                              style: TextStyle(
                                  color: MyColors.blue3,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18),
                            ),
                          )),
                          Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  UploadField,
                                  if (store.myProducts[widget.product].category
                                          .toString()
                                          .toLowerCase() !=
                                      'cars') ...[
                                    name,
                                    description,
                                  ],
                                  price,
                                  if (store.myProducts[widget.product].category
                                          .toString()
                                          .toLowerCase() ==
                                      'cars') ...[
                                    year,
                                    model,
                                    make,
                                    fuel,
                                    mileage,
                                    description,
                                    transmission
                                  ],
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: width * 0.08,
                                        bottom: height * 0.1),
                                    child: Text(
                                      _error,
                                      style:
                                          const TextStyle(color: MyColors.red2),
                                    ),
                                  )
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: height * 0.02, left: width * 0.01),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Color.fromARGB(255, 9, 9, 10),
                      size: 40,
                    ),
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      Navigator.pop(context);
                    },
                  ),
                ),
                if (_loading) _loader
              ],
            );
          }),
    );
  }
}
