import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter/material.dart';

class Banner extends StatefulWidget {
  const Banner({super.key});

  @override
  _BannerState createState() => _BannerState();
}

class _BannerState extends State<Banner> {
  @override
  Widget build(BuildContext context) {
    Widget imageCarousel = AnotherCarousel(
      images: const [
        NetworkImage(
            'https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg'),
        NetworkImage(
            'https://cdn-images-1.medium.com/max/2000/1*wnIEgP1gNMrK5gZU7QS0-A.jpeg'),
        ExactAssetImage("assets/images/LaunchImage.jpg")
      ],
    );
    var width = MediaQuery.of(context).copyWith().size.width;
    var height = MediaQuery.of(context).copyWith().size.height;
    return SizedBox(
      width: width,
      height: height * 0.35,
      child: imageCarousel,
    );
  }
}
