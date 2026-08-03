import 'package:get/get.dart';
import 'package:maraka/logic/store.dart';
import 'package:maraka/logic/user_logic.dart';
import 'package:maraka/pages/create_ad.dart';
import 'package:maraka/pages/create_promotion.dart';
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
  User owner = Get.find();
  // List<Product> myads = [];
  // Future<List<Product>> myAdsList() async {
  //   var logic = ProductLogic();
  //   List<Product> ad = await logic.getMyAds(owner);
  //   myads = ad;

  //   return ad;
  // }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).copyWith().size.height;
    var width = MediaQuery.of(context).copyWith().size.width;
    final store = Get.find<StoreController>();
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
              FutureBuilder<dynamic>(
                future: store.setMyproducts(owner),
                builder: (context, snapshot) {
                  // print(snapshot.data);
                  if (snapshot.hasData) {
                    return GetBuilder(
                        init: store,
                        builder: (_) {
                          return SizedBox(
                            // decoration: BoxDecoration(
                            //     border: Border.all(color: Colors.black)),
                            height: height * 0.69,
                            width: width,
                            child: GridView.builder(
                                itemCount: store.myProducts.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        //childAspectRatio: 2,
                                        mainAxisExtent: 280,
                                        mainAxisSpacing: 12,
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 10),
                                itemBuilder: (context, index) => ProductsItem(
                                      isFavouritedPage: false,
                                      owner: owner,
                                      isFavouriteclicked: false,
                                      isFavouriteBtn: false,
                                      product: index,
                                    )),
                          );
                        });
                  } else {
                    return const Text("");
                  }
                },
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.small(
            heroTag: 'create-promotion',
            onPressed: () => Get.to(() => const CreatePromotionPage()),
            tooltip: 'Create promotion',
            backgroundColor: MyColors.gold,
            foregroundColor: MyColors.brown3,
            child: const Icon(Icons.local_offer_outlined),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            heroTag: 'create-ad',
            onPressed: () => Get.to(() => CreateAd(owner: owner)),
            tooltip: "Create Ad",
            backgroundColor: MyColors.blue3,
            foregroundColor: MyColors.brown3,
            child: const Icon(Icons.create, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
