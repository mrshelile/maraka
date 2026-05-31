import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maraka/logic/store.dart';
import 'package:maraka/models/product.dart';
import 'package:maraka/size_config.dart';


class ProductDescription extends StatelessWidget {
  ProductDescription({
    Key? key,
    required this.product,
    this.pressOnSeeMore,
  }) : super(key: key);
  final store = Get.find<StoreController>();
  final Product product;
  final GestureTapCallback? pressOnSeeMore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20,context)),
          child: Text(
            product.title.toString(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20,context)),
          child: Column(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).copyWith().size.height*0.02,),
              Text(product.seller!.fullNames.toString(),style: const TextStyle(color: Colors.black),),
              Text(product.seller!.email.toString(),style: const TextStyle(color: Colors.black),),
              Text(product.seller!.phone1.toString(),style: const TextStyle(color: Colors.black),),
              SizedBox(height: MediaQuery.of(context).copyWith().size.height*0.01,),
            ],
          )
        ),
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20,context),
            right: getProportionateScreenWidth(64,context),
          ),
          child: Text(
            product.description.toString(),
            
          ),
        ),
        
      ],
    );
  }
}
