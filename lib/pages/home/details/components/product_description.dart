import 'package:flutter/material.dart';
import 'package:maraka/pages/home/components/Product.dart';
import 'package:maraka/size_config.dart';


class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key? key,
    required this.product,
    this.pressOnSeeMore,
  }) : super(key: key);

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
            product.title,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20,context)),
          child: Column(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).copyWith().size.height*0.02,),
              Text("Malefetsane Shelile",style: TextStyle(color: Colors.black),),
              Text("davertzshelile@gmail.com",style: TextStyle(color: Colors.black),),
              Text("(+266) 69356845",style: TextStyle(color: Colors.black),),
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
            product.description,
            
          ),
        ),
        
      ],
    );
  }
}
