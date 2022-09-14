// ignore: file_names
import 'package:maraka/themes/background.dart';
import 'package:maraka/themes/color.dart';
import 'package:flutter/material.dart';

class CreateAds extends StatefulWidget {
  const CreateAds({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CreateAdsState createState() => _CreateAdsState();
}

class _CreateAdsState extends State<CreateAds> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).copyWith().size.height;
    double width = MediaQuery.of(context).copyWith().size.width;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomPaint(
            painter: BackgroundDesign(),
            child: Container(),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.only(top: height * 0.1, left: width * 0.05),
                    child: const Text(
                      "Categories",
                      style: TextStyle(color: MyColors.brown3, fontSize: 20),
                    ),
                  ),
                  Padding(
                      padding:
                          EdgeInsets.only(left: width * 0.2, top: height * 0.1),
                      child: Container(
                        width:
                            MediaQuery.of(context).copyWith().size.width * 0.35,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.6),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 5))
                            ],
                            border: Border.all(color: MyColors.blue2),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => Home()));
                            }
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      )),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
