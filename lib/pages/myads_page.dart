import 'package:get/get.dart';
import 'package:maraka/logic/store.dart';
import 'package:maraka/logic/user_logic.dart';
import 'package:maraka/pages/create_ad.dart';
import 'package:maraka/themes/background.dart';
import 'package:maraka/screens/componets/widget/products_item.dart';
import 'package:maraka/themes/color.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyAds extends StatefulWidget {
  const MyAds({
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _MyAdsState createState() => _MyAdsState();
}

class _MyAdsState extends State<MyAds> {
  final User owner = Get.find();

  @override
  Widget build(BuildContext context) {
    final store = Get.find<StoreController>();
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

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
                padding:
                    EdgeInsets.only(top: height * 0.0, right: width * 0.65),
                child: SizedBox(
                  height: height * 0.2,
                  width: width * 0.2,
                  child: Image.asset(
                    "assets/iconlogo.png",
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder<dynamic>(
                  future: store.setMyproducts(owner),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasData) {
                      return GetBuilder<StoreController>(
                        init: store,
                        builder: (_) {
                          if (store.myProducts.isEmpty) {
                            return Center(
                              child: Text(
                                'No ads found. Create one to manage it here.',
                                style: TextStyle(
                                  color: MyColors.brown3.withOpacity(0.8),
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            );
                          }

                          return GridView.builder(
                            padding: const EdgeInsets.fromLTRB(14, 0, 14, 20),
                            itemCount: store.myProducts.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisExtent: 280,
                              mainAxisSpacing: 12,
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                            ),
                            itemBuilder: (context, index) => ProductsItem(
                              isFavouritedPage: false,
                              owner: owner,
                              isFavouriteclicked: false,
                              isFavouriteBtn: false,
                              product: index,
                            ),
                          );
                        },
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'create-ad',
        onPressed: () => Get.to(() => CreateAd(owner: owner)),
        tooltip: "Create Ad",
        backgroundColor: MyColors.blue3,
        foregroundColor: MyColors.brown3,
        child: const Icon(Icons.create, color: Colors.white),
      ),
    );
  }
}
