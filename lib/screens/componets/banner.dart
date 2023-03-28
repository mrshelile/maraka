import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class Banner extends StatefulWidget {
  const Banner({Key? key}) : super(key: key);

  @override
  _BannerState createState() => _BannerState();
}

class _BannerState extends State<Banner> {
  @override
  Widget build(BuildContext context) {
    Widget image_carousel = new Container(
        child: new Carousel(
      images: [
        NetworkImage(
            'https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg'),
        NetworkImage(
            'https://cdn-images-1.medium.com/max/2000/1*wnIEgP1gNMrK5gZU7QS0-A.jpeg'),
        ExactAssetImage("assets/images/LaunchImage.jpg")
      ],
    ));
    var width = MediaQuery.of(context).copyWith().size.width;
    var height = MediaQuery.of(context).copyWith().size.height;
    return Container(
      width: width,
      height: height * 0.1,
      child: ListView(
        children: <Widget>[image_carousel],
      ),
    );
  }
}
