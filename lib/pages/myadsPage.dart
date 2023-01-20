import 'package:maraka/logic/products_logic.dart';
import 'package:maraka/logic/user_logic.dart';
import 'package:maraka/models/product.dart';
import 'package:maraka/models/products.dart';
import 'package:maraka/pages/createAd.dart';
import 'package:maraka/themes/background.dart';
import 'package:maraka/screens/componets/widget/products_item.dart';
import 'package:maraka/themes/color.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyAds extends StatefulWidget {
  User owner;
  MyAds({Key? key, required this.owner}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyAdsState createState() => _MyAdsState();
}

class _MyAdsState extends State<MyAds> {
  List<Product> myads = [];
  Future<List<Product>> myAdsList() async {
    var logic = ProductLogic();
    List<Product> ad = await logic.getMyAds(widget.owner);
    myads = ad;
    return ad;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).copyWith().size.height;
    var width = MediaQuery.of(context).copyWith().size.width;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomPaint(
            painter: BackgroundDesign(),
            child: Container(),
          ),
          Column(
            children: <Widget>[
           
              Padding(
                padding: EdgeInsets.only(top: height * 0.0, right: width * 0.65),
                child: SizedBox(
                  height: height * 0.22,
                  width: width * 0.23,
                  child: Image.asset(
                    "assets/iconlogo.png",
                  ),
                ),
              ),
              FutureBuilder<dynamic>(
                future: myAdsList(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      // decoration: BoxDecoration(
                      //     border: Border.all(color: Colors.black)),
                      height: height * 0.68,
                      width: width,
                      child: GridView.builder(
                          itemCount: myads.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  //childAspectRatio: 2,
                                  mainAxisExtent: 280,
                                  mainAxisSpacing: 12,
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10),
                          itemBuilder: (context, index) => ProductsItem(
                                isFavouritedPage: false,
                                owner: widget.owner,
                                isFavouriteclicked: false,
                                isFavouriteBtn: false,
                                product: myads[index],
                              )),
                    );
                  } else {
                    return const Text("");
                  }
                },
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateAd(
                        owner: widget.owner,
                      )));
        },
        tooltip: "Create Ad",
        backgroundColor: MyColors.blue3,
        foregroundColor: MyColors.brown3,
        child: const Icon(
          Icons.create,
          color: Colors.white,
        ),
      ),
    );
  }
}
